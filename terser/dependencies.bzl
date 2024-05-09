"Fetch our dependencies that users need as well."

load("//terser/private:maybe.bzl", http_archive = "maybe_http_archive")

def rules_terser_dependencies():
    http_archive(
        name = "bazel_skylib",
        sha256 = "b8a1527901774180afc798aeb28c4634bdccf19c4d98e7bdd1ce79d1fe9aaad7",
        urls = ["https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz"],
    )

    http_archive(
        name = "aspect_bazel_lib",
        sha256 = "b848cd8e93be7f18c3deda6d2f3ade92a657d3585e119953bc50dc75fef535c2",
        strip_prefix = "bazel-lib-1.38.0",
        url = "https://github.com/aspect-build/bazel-lib/releases/download/v1.38.0/bazel-lib-v1.38.0.tar.gz",
    )

    http_archive(
        name = "aspect_rules_js",
        sha256 = "7cb2d84b7d5220194627c9a0267ae599e357350e75ea4f28f337a25ca6219b83",
        strip_prefix = "rules_js-1.29.2",
        url = "https://github.com/aspect-build/rules_js/releases/download/v1.29.2/rules_js-v1.29.2.tar.gz",
    )

    http_archive(
        name = "rules_nodejs",
        sha256 = "764a3b3757bb8c3c6a02ba3344731a3d71e558220adcb0cf7e43c9bba2c37ba8",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.8.2/rules_nodejs-core-5.8.2.tar.gz"],
    )
