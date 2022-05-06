"terser"

load("@aspect_bazel_lib//lib:copy_to_bin.bzl", "copy_files_to_bin_actions")
load("@rules_nodejs//nodejs:providers.bzl", "JSModuleInfo")


_DOC = """Run the terser minifier.
Typical example:
```starlark
load("@aspect_rules_terser//terser:defs.bzl", "terser_minified")
terser_minified(
    name = "out.min",
    src = "input.js",
    config_file = "terser_config.json",
)
```
Note that the `name` attribute determines what the resulting files will be called.
So the example above will output `out.min.js` and `out.min.js.map` (since `sourcemap` defaults to `true`).
If the input is a directory, then the output will also be a directory, named after the `name` attribute.
Note that this rule is **NOT** recursive. It assumes a flat file structure. Passing in a folder with nested folder
will result in an empty output directory.
"""


_ATTRS = {
    "args": attr.string_list(
        doc = """Additional command line arguments to pass to terser.
Terser only parses minify() args from the config file so additional arguments such as `--comments` may
be passed to the rule using this attribute. See https://github.com/terser/terser#command-line-usage for the
full list of terser CLI options.""",
    ),
    "config_file": attr.label(
        doc = """A JSON file containing Terser minify() options.
This is the file you would pass to the --config-file argument in terser's CLI.
https://github.com/terser-js/terser#minify-options documents the content of the file.
Bazel will make a copy of your config file, treating it as a template.
Run bazel with `--subcommands` to see the path to the copied file.
If you use the magic strings `"bazel_debug"` or `"bazel_no_debug"`, these will be
replaced with `true` and `false` respecting the value of the `debug` attribute
or the `--compilation_mode=dbg` bazel flag.
For example
```
{
    "compress": {
        "arrows": "bazel_no_debug"
    }
}
```
Will disable the `arrows` compression setting when debugging.
If `config_file` isn't supplied, Bazel will use a default config file.
""",
        allow_single_file = True,
        # These defaults match how terser was run in the legacy built-in rollup_bundle rule.
        # We keep them the same so it's easier for users to migrate.
        default = Label("//terser/private:terser_config.default.json"),
    ),
    "debug": attr.bool(
        doc = """Configure terser to produce more readable output.
Instead of setting this attribute, consider using debugging compilation mode instead
bazel build --compilation_mode=dbg //my/terser:target
so that it only affects the current build.
""",
    ),
    "sourcemap": attr.bool(
        doc = "Whether to produce a .js.map output",
        default = True,
    ),
    "src": attr.label(
        doc = """File(s) to minify.
Can be a .js file, a rule producing .js files as its default output, or a rule producing a directory of .js files.
Note that you can pass multiple files to terser, which it will bundle together.
If you want to do this, you can pass a filegroup here.""",
        allow_files = [".js", ".map", ".mjs"],
        mandatory = True,
    ),
    "terser": attr.label(
        doc = "An executable target that runs Terser",
        default = "@terser",
        executable = True,
        cfg = "exec",
    ),
    "_windows_constraint": attr.label(
        doc = "Internal use only. Do not change.",
        default = "@platforms//os:windows"
    )
}

def _filter_js(files):
    return [f for f in files if f.is_directory or f.extension == "js" or f.extension == "mjs"]


def _impl(ctx):
    _is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])
    
    args = ctx.actions.args()

    inputs = []
    outputs = []

    # If src has a JSModuleInfo provider than use that otherwise use DefaultInfo files
    if JSModuleInfo in ctx.attr.src:
        inputs.extend(ctx.attr.src[JSModuleInfo].sources.to_list())
    else:
        inputs.extend(ctx.files.src[:])
    
    inputs = copy_files_to_bin_actions(ctx, inputs, is_windows = _is_windows)

    sources = _filter_js(inputs)
    # already a treeartifact. no need to copy it
    dir_sources = [s for s in sources if s.is_directory]

    if len(dir_sources) > 0:
        if len(sources) > 1:
            fail("When directories are passed to terser_minified, there should be only one input")
        outputs.append(ctx.actions.declare_directory(ctx.label.name))
    else:
        outputs.append(ctx.actions.declare_file("%s.js" % ctx.label.name))
        if ctx.attr.sourcemap:
            outputs.append(ctx.actions.declare_file("%s.js.map" % ctx.label.name))

    args.add_all([s.short_path for s in sources])
    args.add_all(["--output", outputs[0].short_path])

    debug = ctx.attr.debug or ctx.var["COMPILATION_MODE"] == "dbg"
    if debug:
        args.add("--debug")
        args.add("--beautify")

    
    if ctx.attr.sourcemap:
        sourcemaps = [f for f in inputs if f.extension == "map"]

        # Source mapping options are comma-packed into one argv
        # see https://github.com/terser-js/terser#command-line-usage
        source_map_opts = ["includeSources"]

        if len(sourcemaps) == 0:
            source_map_opts.append("content=inline")
        elif len(sourcemaps) == 1:
            source_map_opts.append("content='%s'" % sourcemaps[0].short_path)
        else:
            fail("When sourcemap is True, there should only be one or none input sourcemaps")

        # Add a comment at the end of the js output so DevTools knows where to find the sourcemap
        source_map_opts.append("url='%s.js.map'" % ctx.label.name)

        # This option doesn't work in the config file, only on the CLI
        args.add_all(["--source-map", ",".join(source_map_opts)])

    options = ctx.actions.declare_file("_%s.minify_options.json" % ctx.label.name)
    inputs.append(options)
    ctx.actions.expand_template(
        template = ctx.file.config_file,
        output = options,
        substitutions = {
            "\"bazel_debug\"": str(debug).lower(),
            "\"bazel_no_debug\"": str(not debug).lower(),
        },
    )

    ctx.actions.run(
        inputs = inputs,
        outputs = outputs,
        executable = ctx.executable.terser,
        arguments = [args],
        env = {
            "COMPILATION_MODE": ctx.var["COMPILATION_MODE"],
            "BAZEL_BINDIR": ctx.bin_dir.path
        },
        mnemonic = "TerserMinify",
        progress_message = "Minifying JavaScript %{output}",
    )
    
    outputs_depset = depset(outputs)
    
    return [
        DefaultInfo(files = outputs_depset),
        JSModuleInfo(
            direct_sources = outputs_depset,
            sources = outputs_depset,
        ),
    ]

lib = struct(
    attrs = _ATTRS,
    doc = _DOC,
    implementation = _impl
)