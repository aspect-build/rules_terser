<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="#terser_minified"></a>

## terser_minified

<pre>
terser_minified(<a href="#terser_minified-name">name</a>, <a href="#terser_minified-args">args</a>, <a href="#terser_minified-config_file">config_file</a>, <a href="#terser_minified-debug">debug</a>, <a href="#terser_minified-sourcemap">sourcemap</a>, <a href="#terser_minified-src">src</a>, <a href="#terser_minified-terser">terser</a>)
</pre>

Run the terser minifier.
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


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="terser_minified-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="terser_minified-args"></a>args |  Additional command line arguments to pass to terser. Terser only parses minify() args from the config file so additional arguments such as <code>--comments</code> may be passed to the rule using this attribute. See https://github.com/terser/terser#command-line-usage for the full list of terser CLI options.   | List of strings | optional | [] |
| <a id="terser_minified-config_file"></a>config_file |  A JSON file containing Terser minify() options. This is the file you would pass to the --config-file argument in terser's CLI. https://github.com/terser-js/terser#minify-options documents the content of the file. Bazel will make a copy of your config file, treating it as a template. Run bazel with <code>--subcommands</code> to see the path to the copied file. If you use the magic strings <code>"bazel_debug"</code> or <code>"bazel_no_debug"</code>, these will be replaced with <code>true</code> and <code>false</code> respecting the value of the <code>debug</code> attribute or the <code>--compilation_mode=dbg</code> bazel flag. For example <pre><code> {     "compress": {         "arrows": "bazel_no_debug"     } } </code></pre> Will disable the <code>arrows</code> compression setting when debugging. If <code>config_file</code> isn't supplied, Bazel will use a default config file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //terser/private:terser_config.default.json |
| <a id="terser_minified-debug"></a>debug |  Configure terser to produce more readable output. Instead of setting this attribute, consider using debugging compilation mode instead bazel build --compilation_mode=dbg //my/terser:target so that it only affects the current build.   | Boolean | optional | False |
| <a id="terser_minified-sourcemap"></a>sourcemap |  Whether to produce a .js.map output   | Boolean | optional | True |
| <a id="terser_minified-src"></a>src |  File(s) to minify. Can be a .js file, a rule producing .js files as its default output, or a rule producing a directory of .js files. Note that you can pass multiple files to terser, which it will bundle together. If you want to do this, you can pass a filegroup here.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="terser_minified-terser"></a>terser |  An executable target that runs Terser   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @terser |


