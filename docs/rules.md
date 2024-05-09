<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API

<a id="terser"></a>

## terser

<pre>
terser(<a href="#terser-name">name</a>, <a href="#terser-node_modules">node_modules</a>, <a href="#terser-srcs">srcs</a>, <a href="#terser-data">data</a>, <a href="#terser-sourcemap">sourcemap</a>, <a href="#terser-config_file">config_file</a>, <a href="#terser-debug">debug</a>, <a href="#terser-args">args</a>, <a href="#terser-kwargs">kwargs</a>)
</pre>

Run the terser minifier.

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


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="terser-name"></a>name |  A unique name for this target.   |  none |
| <a id="terser-node_modules"></a>node_modules |  Label pointing to the linked node_modules target where the `terser` is linked, e.g. `//:node_modules`.<br><br>`terser` must be linked into the node_modules supplied.   |  none |
| <a id="terser-srcs"></a>srcs |  File(s) to minify.<br><br>Can be `.js` files, a rule producing `.js` files as its default output, or a rule producing a directory of `.js` files.<br><br>If multiple files are passed, terser will bundle them together.   |  none |
| <a id="terser-data"></a>data |  Runtime dependencies to include in binaries/tests that depend on this target.<br><br>The transitive npm dependencies, transitive sources, default outputs and runfiles of targets in the `data` attribute are added to the runfiles of this target. They should appear in the '*.runfiles' area of any executable which has a runtime dependency on this target.<br><br>If this list contains linked npm packages, npm package store targets or other targets that provide `JsInfo`, `NpmPackageStoreInfo` providers are gathered from `JsInfo`. This is done directly from the `npm_package_store_deps` field of these. For linked npm package targets, the underlying `npm_package_store` target(s) that back the links is used. Gathered `NpmPackageStoreInfo` providers are propagated to the direct dependencies of downstream linked `npm_package` targets.<br><br>NB: Linked npm package targets that are "dev" dependencies do not forward their underlying `npm_package_store` target(s) through `npm_package_store_deps` and will therefore not be propagated to the direct dependencies of downstream linked `npm_package` targets. npm packages that come in from `npm_translate_lock` are considered "dev" dependencies if they are have `dev: true` set in the pnpm lock file. This should be all packages that are only listed as "devDependencies" in all `package.json` files within the pnpm workspace. This behavior is intentional to mimic how `devDependencies` work in published npm packages.   |  `[]` |
| <a id="terser-sourcemap"></a>sourcemap |  Whether to produce a .js.map output   |  `True` |
| <a id="terser-config_file"></a>config_file |  A JSON file containing Terser minify() options.<br><br>This is the file you would pass to the --config-file argument in terser's CLI. https://github.com/terser-js/terser#minify-options documents the content of the file. Bazel will make a copy of your config file, treating it as a template. Run bazel with `--subcommands` to see the path to the copied file. If you use the magic strings `"bazel_debug"` or `"bazel_no_debug"`, these will be replaced with `true` and `false` respecting the value of the `debug` attribute or the `--compilation_mode=dbg` bazel flag. For example<br><br><pre><code>{&#10;    "compress": {&#10;        "arrows": "bazel_no_debug"&#10;    }&#10;}</code></pre><br><br>Will disable the `arrows` compression setting when debugging. If `config_file` isn't supplied, Bazel will use a default config file.   |  `"@aspect_rules_terser//terser/private:terser_config.default.json"` |
| <a id="terser-debug"></a>debug |  Configure terser to produce more readable output.<br><br>Instead of setting this attribute, consider using debugging compilation mode instead bazel build --compilation_mode=dbg //my/terser:target so that it only affects the current build.   |  `False` |
| <a id="terser-args"></a>args |  Additional command line arguments to pass to terser.<br><br>Terser only parses minify() args from the config file so additional arguments such as `--comments` may be passed to the rule using this attribute. See https://github.com/terser/terser#command-line-usage for the full list of terser CLI options.   |  `[]` |
| <a id="terser-kwargs"></a>kwargs |  Other common arguments such as `tags` and `visibility`   |  none |


