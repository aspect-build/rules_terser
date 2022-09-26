"Fetch our dependencies that users need as well."

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
def rules_terser_dependencies():
    # The minimal version of bazel_skylib we require
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "aspect_rules_js",
        sha256 = "0707a425093704fab05fb91c3a4b62cf22dca18ea334d8a72f156d4c18e8db90",
        strip_prefix = "rules_js-1.3.1",
        url = "https://github.com/aspect-build/rules_js/archive/refs/tags/v1.3.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "aspect_bazel_lib",
        sha256 = "a12740bcc1a1f47de850ff84f10d9eb4c930792f69309feb986fdbeb69f83cfe",
        strip_prefix = "bazel-lib-1.11.8",
        url = "https://github.com/aspect-build/bazel-lib/archive/refs/tags/v1.11.8.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_nodejs",
        sha256 = "404fb7ee034671eb30cc04c59d217adf0a8bd04b311ece17e052fc7ecb60ac32",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.5.4/rules_nodejs-core-5.5.4.tar.gz"],
    )
