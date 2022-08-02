<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="#terser_minified"></a>

## terser_minified

<pre>
terser_minified(<a href="#terser_minified-name">name</a>, <a href="#terser_minified-args">args</a>, <a href="#terser_minified-config_file">config_file</a>, <a href="#terser_minified-data">data</a>, <a href="#terser_minified-debug">debug</a>, <a href="#terser_minified-sourcemap">sourcemap</a>, <a href="#terser_minified-srcs">srcs</a>, <a href="#terser_minified-terser">terser</a>)
</pre>

Run the terser minifier.
Typical example:
```starlark
load("@aspect_rules_terser//terser:defs.bzl", "terser_minified")
terser_minified(
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


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="terser_minified-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="terser_minified-args"></a>args |  Additional command line arguments to pass to terser. Terser only parses minify() args from the config file so additional arguments such as <code>--comments</code> may be passed to the rule using this attribute. See https://github.com/terser/terser#command-line-usage for the full list of terser CLI options.   | List of strings | optional | [] |
| <a id="terser_minified-config_file"></a>config_file |  A JSON file containing Terser minify() options. This is the file you would pass to the --config-file argument in terser's CLI. https://github.com/terser-js/terser#minify-options documents the content of the file. Bazel will make a copy of your config file, treating it as a template. Run bazel with <code>--subcommands</code> to see the path to the copied file. If you use the magic strings <code>"bazel_debug"</code> or <code>"bazel_no_debug"</code>, these will be replaced with <code>true</code> and <code>false</code> respecting the value of the <code>debug</code> attribute or the <code>--compilation_mode=dbg</code> bazel flag. For example <pre><code> {     "compress": {         "arrows": "bazel_no_debug"     } } </code></pre> Will disable the <code>arrows</code> compression setting when debugging. If <code>config_file</code> isn't supplied, Bazel will use a default config file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //terser/private:terser_config.default.json |
| <a id="terser_minified-data"></a>data |  Runtime dependencies to include in binaries/tests that depend on this target.<br><br>    The transitive npm dependencies, transitive sources, default outputs and runfiles of targets in the <code>data</code> attribute     are added to the runfiles of this taregt. Thery should appear in the '*.runfiles' area of any executable which has     a runtime dependency on this target.<br><br>    If this list contains linked npm packages, npm package store targets or other targets that provide <code>JsInfo</code>,     <code>NpmPackageStoreInfo</code> providers are gathered from <code>JsInfo</code>. This is done directly from <code>npm_package_stores</code> and     <code>transitive_npm_package_stores</code> fields of these and for linked npm package targets, from the underlying     npm_package_store target(s) that back the links via <code>npm_linked_packages</code> and <code>transitive_npm_linked_packages</code>.<br><br>    Gathered <code>NpmPackageStoreInfo</code> providers are used downstream as direct dependencies when linking a downstream     <code>npm_package</code> target with <code>npm_link_package</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="terser_minified-debug"></a>debug |  Configure terser to produce more readable output. Instead of setting this attribute, consider using debugging compilation mode instead bazel build --compilation_mode=dbg //my/terser:target so that it only affects the current build.   | Boolean | optional | False |
| <a id="terser_minified-sourcemap"></a>sourcemap |  Whether to produce a .js.map output   | Boolean | optional | True |
| <a id="terser_minified-srcs"></a>srcs |  File(s) to minify.<br><br>Can be .js files, a rule producing .js files as its default output, or a rule producing a directory of .js files.<br><br>If multiple files are passed, terser will bundle them together.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| <a id="terser_minified-terser"></a>terser |  An executable target that runs Terser   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @terser |


