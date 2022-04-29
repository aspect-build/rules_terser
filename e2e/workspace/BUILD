load("@bazel_skylib//rules:build_test.bzl", "build_test")

genrule(
    name = "help",
    srcs = [],
    outs = ["help.txt"],
    cmd = "BAZEL_BINDIR=$(BINDIR) $(location @terser) --help > $@",
    tools = ["@terser"],
)

build_test(
    name = "test",
    targets = [":help"],
)
