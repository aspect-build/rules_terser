"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("//terser/private:versions.bzl", "TOOL_VERSIONS")
load("@aspect_rules_js//npm:npm_import.bzl", _npm_translate_lock = "npm_translate_lock")

LATEST_VERSION = TOOL_VERSIONS[0]

def terser_repositories(name, terser_version = LATEST_VERSION):
    """
    Fetch external tools needed for terser

    Args:
        name: Unique name for this terser tools repository
        terser_version: The terser version to fetch.

            See /terser/private/versions.bzl for available versions.
    """
    if terser_version not in TOOL_VERSIONS:
        fail("""\
terser version {} is not currently mirrored into rules_terser.
Please instead choose one of these available versions: {}
Or, make a PR to the repo running /scripts/mirror_release.sh to add the newest version.
If you need custom versions, please file an issue.""".format(terser_version, TOOL_VERSIONS))

    _npm_translate_lock(
        name = name,
        pnpm_lock = "@aspect_rules_terser//terser/private:{version}/pnpm-lock.yaml".format(version = terser_version),
        # We'll be linking in the @foo repository and not the repository where the pnpm-lock file is located
        link_workspace = name,
        # Override the Bazel package where pnpm-lock.yaml is located and link to the specified package instead
        root_package = "",
        defs_bzl_filename = "npm_link_all_packages.bzl",
        repositories_bzl_filename = "npm_repositories.bzl",
        additional_file_contents = {
            "BUILD.bazel": [
                """load("@aspect_bazel_lib//lib:copy_file.bzl", "copy_file")""",
                """load("@aspect_rules_js//js:defs.bzl", "js_binary")""",
                """load("//:npm_link_all_packages.bzl", "npm_link_all_packages")""",
                """npm_link_all_packages(name = "node_modules")""",
                """copy_file(
    name = "run_terser",
    src = "@aspect_rules_terser//terser/private:run_terser.js",
    out = "run_terser.js",
    visibility = ["//visibility:public"],
)""",
                """js_binary(
    name = "{name}",
    data = [":node_modules/terser"],
    entry_point = "run_terser.js",
    visibility = ["//visibility:public"],
)""".format(name = name),
            ],
        },
    )
