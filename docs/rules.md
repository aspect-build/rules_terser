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
| <a id="terser-node_modules"></a>node_modules |  Label pointing to the linked node_modules target where the <code>terser</code> is linked, e.g. <code>//:node_modules</code>.<br><br><code>terser</code> must be linked into the node_modules supplied.   |  none |
| <a id="terser-srcs"></a>srcs |  File(s) to minify.<br><br>Can be <code>.js</code> files, a rule producing <code>.js</code> files as its default output, or a rule producing a directory of <code>.js</code> files.<br><br>If multiple files are passed, terser will bundle them together.   |  none |
| <a id="terser-data"></a>data |  Runtime dependencies to include in binaries/tests that depend on this target.<br><br>The transitive npm dependencies, transitive sources, default outputs and runfiles of targets in the <code>data</code> attribute are added to the runfiles of this target. They should appear in the '*.runfiles' area of any executable which has a runtime dependency on this target.<br><br>If this list contains linked npm packages, npm package store targets or other targets that provide <code>JsInfo</code>, <code>NpmPackageStoreInfo</code> providers are gathered from <code>JsInfo</code>. This is done directly from the <code>npm_package_store_deps</code> field of these. For linked npm package targets, the underlying <code>npm_package_store</code> target(s) that back the links is used. Gathered <code>NpmPackageStoreInfo</code> providers are propagated to the direct dependencies of downstream linked <code>npm_package</code> targets.<br><br>NB: Linked npm package targets that are "dev" dependencies do not forward their underlying <code>npm_package_store</code> target(s) through <code>npm_package_store_deps</code> and will therefore not be propagated to the direct dependencies of downstream linked <code>npm_package</code> targets. npm packages that come in from <code>npm_translate_lock</code> are considered "dev" dependencies if they are have <code>dev: true</code> set in the pnpm lock file. This should be all packages that are only listed as "devDependencies" in all <code>package.json</code> files within the pnpm workspace. This behavior is intentional to mimic how <code>devDependencies</code> work in published npm packages.   |  <code>[]</code> |
| <a id="terser-sourcemap"></a>sourcemap |  Whether to produce a .js.map output   |  <code>True</code> |
| <a id="terser-config_file"></a>config_file |  A JSON file containing Terser minify() options.<br><br>This is the file you would pass to the --config-file argument in terser's CLI. https://github.com/terser-js/terser#minify-options documents the content of the file. Bazel will make a copy of your config file, treating it as a template. Run bazel with <code>--subcommands</code> to see the path to the copied file. If you use the magic strings <code>"bazel_debug"</code> or <code>"bazel_no_debug"</code>, these will be replaced with <code>true</code> and <code>false</code> respecting the value of the <code>debug</code> attribute or the <code>--compilation_mode=dbg</code> bazel flag. For example<br><br><pre><code> {     "compress": {         "arrows": "bazel_no_debug"     } } </code></pre><br><br>Will disable the <code>arrows</code> compression setting when debugging. If <code>config_file</code> isn't supplied, Bazel will use a default config file.   |  <code>"@aspect_rules_terser//terser/private:terser_config.default.json"</code> |
| <a id="terser-debug"></a>debug |  Configure terser to produce more readable output.<br><br>Instead of setting this attribute, consider using debugging compilation mode instead bazel build --compilation_mode=dbg //my/terser:target so that it only affects the current build.   |  <code>False</code> |
| <a id="terser-args"></a>args |  Additional command line arguments to pass to terser.<br><br>Terser only parses minify() args from the config file so additional arguments such as <code>--comments</code> may be passed to the rule using this attribute. See https://github.com/terser/terser#command-line-usage for the full list of terser CLI options.   |  <code>[]</code> |
| <a id="terser-kwargs"></a>kwargs |  Other common arguments such as <code>tags</code> and <code>visibility</code>   |  none |


