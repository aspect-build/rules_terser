# Bazel rules for terser

[terser](https://terser.org/) is a JavaScript minifier.

These rules teach Bazel how to interact with the [terser CLI](https://terser.org/docs/cli-usage).

_Need help?_ This ruleset has support provided by https://aspect.build/services.

## Installation

From the release you wish to use:
<https://github.com/aspect-build/rules_terser/releases>
copy the WORKSPACE snippet into your `WORKSPACE` file.

## Usage

See the [API documentation](docs/rules) and the example usage in the [`examples/`](https://github.com/aspect-build/rules_terser/tree/main/examples/) directory.
Note that the examples rely on code in the `/WORKSPACE` file in the root of this repo.

### From a BUILD file

This is the most common usage. See [`examples/minify`](https://github.com/aspect-build/rules_terser/tree/main/examples/)

### From a macro

You could write a Bazel macro which uses terser, by calling it from a `genrule` or
[`run_binary`](https://docs.aspect.build/bazelbuild/bazel-skylib/1.2.1/docs/run_binary_doc_gen.html#run_binary).
This is illustrated in examples/macro.

### From a custom rule

The most advanced usage is to write your own custom rule.

This is a good choice if you need to integrate with other Bazel rules via [Providers](https://docs.bazel.build/versions/main/skylark/rules.html#providers).
