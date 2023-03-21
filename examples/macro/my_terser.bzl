"Defines a trivial macro that invokes esbuild"

def terser_help(name, terser, out):
    # Show how to call esbuild directly using the toolchain.
    native.genrule(
        name = name,
        srcs = [],
        # The result will be in bazel-bin/examples/macro/help
        outs = [out],
        cmd = "BAZEL_BINDIR=$(BINDIR) $(location {}) --help > $@".format(terser),
        tools = [terser],
    )
