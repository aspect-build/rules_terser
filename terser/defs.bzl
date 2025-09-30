"Public API"

load("@aspect_rules_js//js:defs.bzl", "js_binary")
load("@aspect_tools_telemetry_report//:defs.bzl", "TELEMETRY")  # buildifier: disable=load
load("@bazel_lib//lib:copy_file.bzl", "copy_file")
load("//terser/private:terser.bzl", terser_lib = "lib")

_terser = rule(
    implementation = terser_lib.implementation,
    attrs = terser_lib.attrs,
    toolchains = terser_lib.toolchains,
)

def terser(
        name,
        node_modules,
        srcs,
        data = [],
        sourcemap = True,
        config_file = "@aspect_rules_terser//terser/private:terser_config.default.json",
        debug = False,
        args = [],
        **kwargs):
    """Run the terser minifier.

    Typical example:

    ```starlark
    load("@aspect_rules_terser//terser:defs.bzl", "terser")

    terser(
        name = "out.min",
        srcs = "input.js",
        config_file = "terser_config.json",
    )
    ```

    Note that the `name` attribute determines what the resulting files will be called.

    So the example above will output `out.min.js` and `out.min.js.map` (since `sourcemap` defaults to `true`).

    If the input is a directory, then the output will also be a directory, named after the `name` attribute.

    Note that this rule is **NOT** recursive. It assumes a flat file structure. Passing in a folder with nested folder
    will result in an empty output directory.

    Args:
        name: A unique name for this target.

        node_modules: Label pointing to the linked node_modules target where the `terser` is linked, e.g. `//:node_modules`.

            `terser` must be linked into the node_modules supplied.

        srcs: File(s) to minify.

            Can be `.js` files, a rule producing `.js` files as its default output, or a rule producing a directory of `.js` files.

            If multiple files are passed, terser will bundle them together.

        data: Runtime dependencies to include in binaries/tests that depend on this target.

            The transitive npm dependencies, transitive sources, default outputs and runfiles of targets in the `data` attribute
            are added to the runfiles of this target. They should appear in the '*.runfiles' area of any executable which has
            a runtime dependency on this target.

            If this list contains linked npm packages, npm package store targets or other targets that provide
            `JsInfo`, `NpmPackageStoreInfo` providers are gathered from `JsInfo`. This is done directly from
            the `npm_package_store_deps` field of these. For linked npm package targets, the underlying
            `npm_package_store` target(s) that back the links is used. Gathered `NpmPackageStoreInfo`
            providers are propagated to the direct dependencies of downstream linked `npm_package` targets.

            NB: Linked npm package targets that are "dev" dependencies do not forward their underlying
            `npm_package_store` target(s) through `npm_package_store_deps` and will therefore not be
            propagated to the direct dependencies of downstream linked `npm_package` targets. npm packages
            that come in from `npm_translate_lock` are considered "dev" dependencies if they are have
            `dev: true` set in the pnpm lock file. This should be all packages that are only listed as
            "devDependencies" in all `package.json` files within the pnpm workspace. This behavior is
            intentional to mimic how `devDependencies` work in published npm packages.

        sourcemap: Whether to produce a .js.map output

        config_file: A JSON file containing Terser minify() options.

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

        debug: Configure terser to produce more readable output.

            Instead of setting this attribute, consider using debugging compilation mode instead
            bazel build --compilation_mode=dbg //my/terser:target
            so that it only affects the current build.

        args: Additional command line arguments to pass to terser.

            Terser only parses minify() args from the config file so additional arguments such as `--comments` may
            be passed to the rule using this attribute. See https://github.com/terser/terser#command-line-usage for the
            full list of terser CLI options.

        **kwargs: Other common arguments such as `tags` and `visibility`
    """
    entry_point = "_{}_terser_runner.cjs".format(name)
    copy_file(
        name = "_{}_copy_terser_runner".format(name),
        src = "@aspect_rules_terser//terser/private:runner.cjs",
        out = entry_point,
    )

    terser = "_{}_terser_binary".format(name)
    js_binary(
        name = terser,
        data = ["{}/terser".format(node_modules)],
        entry_point = entry_point,
    )

    _terser(
        name = name,
        srcs = srcs,
        data = data,
        sourcemap = sourcemap,
        config_file = config_file,
        debug = debug,
        args = args,
        terser = terser,
        **kwargs
    )
