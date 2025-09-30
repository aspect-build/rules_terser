"Fetch our dependencies that users need as well."

load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def http_archive(**kwargs):
    maybe(_http_archive, **kwargs)

# buildifier: disable=function-docstring
def rules_terser_dependencies():
    http_archive(
        name = "bazel_lib",
        sha256 = "46960e9fa6c9352d883768280951ac388dba8cb9ff0256182fb77925eae2b6ac",
        strip_prefix = "bazel-lib-3.0.0-beta.1",
        url = "https://github.com/bazel-contrib/bazel-lib/releases/download/v3.0.0-beta.1/bazel-lib-v3.0.0-beta.1.tar.gz",
    )

    http_archive(
        name = "aspect_bazel_lib",
        sha256 = "6d758a8f646ecee7a3e294fbe4386daafbe0e5966723009c290d493f227c390b",
        strip_prefix = "bazel-lib-2.7.7",
        url = "https://github.com/aspect-build/bazel-lib/releases/download/v2.7.7/bazel-lib-v2.7.7.tar.gz",
    )

    http_archive(
        name = "aspect_rules_js",
        sha256 = "6b7e73c35b97615a09281090da3645d9f03b2a09e8caa791377ad9022c88e2e6",
        strip_prefix = "rules_js-2.0.0",
        url = "https://github.com/aspect-build/rules_js/releases/download/v2.0.0/rules_js-v2.0.0.tar.gz",
    )

    http_archive(
        name = "rules_nodejs",
        sha256 = "87c6171c5be7b69538d4695d9ded29ae2626c5ed76a9adeedce37b63c73bef67",
        strip_prefix = "rules_nodejs-6.2.0",
        url = "https://github.com/bazelbuild/rules_nodejs/releases/download/v6.2.0/rules_nodejs-v6.2.0.tar.gz",
    )

    http_archive(
        name = "aspect_tools_telemetry_report",
        sha256 = "fea3bc2f9b7896ab222756c27147b1f1b8f489df8114e03d252ffff475f8bce6",
        strip_prefix = "tools_telemetry-0.2.8",
        url = "https://github.com/aspect-build/tools_telemetry/releases/download/v0.2.8/tools_telemetry-v0.2.8.tar.gz",
    )
