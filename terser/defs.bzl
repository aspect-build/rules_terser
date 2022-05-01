"Public API re-exports"

load("//terser/private:terser.bzl", terser_lib = "lib")

terser_minified = rule(
    implementation = terser_lib.implementation,
    attrs = terser_lib.attrs,
    doc = terser_lib.doc,
)