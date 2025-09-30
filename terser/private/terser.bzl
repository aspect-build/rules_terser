"terser"

load("@aspect_rules_js//js:libs.bzl", "js_lib_helpers")
load("@aspect_rules_js//js:providers.bzl", "js_info")
load("@bazel_lib//lib:copy_to_bin.bzl", "COPY_FILE_TO_BIN_TOOLCHAINS", "copy_files_to_bin_actions")

_ATTRS = {
    "config_file": attr.label(
        allow_single_file = True,
    ),
    "debug": attr.bool(),
    "sourcemap": attr.bool(
        default = True,
    ),
    "srcs": attr.label_list(
        allow_files = [".js", ".map", ".mjs"],
        mandatory = True,
    ),
    "args": attr.string_list(),
    "data": attr.label_list(
        allow_files = True,
    ),
    "terser": attr.label(
        mandatory = True,
        executable = True,
        cfg = "exec",
    ),
}

def _filter_js(files):
    return [f for f in files if f.is_directory or f.extension == "js" or f.extension == "mjs"]

def _impl(ctx):
    args = ctx.actions.args()

    inputs = copy_files_to_bin_actions(ctx, ctx.files.srcs)

    input_sources = _filter_js(inputs)
    input_dir_sources = [s for s in input_sources if s.is_directory]

    output_sources = []

    if len(input_dir_sources) > 0:
        if len(input_sources) > 1:
            fail("When directories are passed to terser, there should be only one input")
        output_sources.append(ctx.actions.declare_directory(ctx.label.name))
    else:
        output_sources.append(ctx.actions.declare_file("%s.js" % ctx.label.name))
        if ctx.attr.sourcemap:
            output_sources.append(ctx.actions.declare_file("%s.js.map" % ctx.label.name))

    args.add_all([s.short_path for s in input_sources])
    args.add_all(["--output", output_sources[0].short_path])

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

    args.add_all(ctx.attr.args)

    if ctx.file.config_file:
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
        args.add_all(["--config-file", options.short_path])

    ctx.actions.run(
        inputs = inputs,
        outputs = output_sources,
        executable = ctx.executable.terser,
        arguments = [args],
        env = {
            "COMPILATION_MODE": ctx.var["COMPILATION_MODE"],
            "BAZEL_BINDIR": ctx.bin_dir.path,
        },
        mnemonic = "TerserMinify",
        progress_message = "Minifying JavaScript %{output}",
    )

    output_sources_depset = depset(output_sources)

    transitive_sources = js_lib_helpers.gather_transitive_sources(
        sources = output_sources,
        targets = ctx.attr.srcs,
    )

    transitive_types = js_lib_helpers.gather_transitive_types(
        types = [],
        targets = ctx.attr.srcs,
    )

    npm_sources = js_lib_helpers.gather_npm_sources(
        srcs = ctx.attr.srcs,
        deps = [],
    )

    npm_package_store_infos = js_lib_helpers.gather_npm_package_store_infos(
        targets = ctx.attr.srcs + ctx.attr.data,
    )

    runfiles = js_lib_helpers.gather_runfiles(
        ctx = ctx,
        sources = transitive_sources,
        data = ctx.attr.data,
        deps = ctx.attr.srcs,
    )

    return [
        js_info(
            target = ctx.label,
            sources = output_sources_depset,
            types = depset(),  # terser does not emit types directly
            transitive_sources = transitive_sources,
            transitive_types = transitive_types,
            npm_sources = npm_sources,
            npm_package_store_infos = npm_package_store_infos,
        ),
        DefaultInfo(
            files = output_sources_depset,
            runfiles = runfiles,
        ),
    ]

lib = struct(
    attrs = _ATTRS,
    implementation = _impl,
    toolchains = COPY_FILE_TO_BIN_TOOLCHAINS,
)
