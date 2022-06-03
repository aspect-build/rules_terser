"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("//terser/private:versions.bzl", "TOOL_VERSIONS", _LATEST_VERSION = "LATEST_VERSION")

# Expose as Public API
LATEST_VERSION = _LATEST_VERSION

########
# Remaining content of the file is only used to support toolchains.
########
_DOC = "Fetch external tools needed for terser toolchain"
_ATTRS = {
    "terser_version": attr.string(),
}

def _terser_repo_impl(repository_ctx):
    repository_ctx.symlink(Label("//terser/private:run_terser.js"), "run_terser.js")

    # Base BUILD file for this repository
    repository_ctx.file("BUILD.bazel", """\
# Generated by aspect_rules_terser/terser/repositories.bzl
load("@aspect_rules_js//js:defs.bzl", "js_binary")
load("@aspect_rules_terser//terser/private:{version}/defs.bzl", "link_all_npm_packages")

link_all_npm_packages(name = "node_modules")

js_binary(
    name = "{name}",
    data = [":node_modules/terser"],
    entry_point = "run_terser.js",
    visibility = ["//visibility:public"],
)
""".format(
        name = repository_ctx.attr.name,
        version = repository_ctx.attr.terser_version,
    ))

terser_repositories = repository_rule(
    _terser_repo_impl,
    doc = _DOC,
    attrs = _ATTRS,
)

# Wrapper macro around everything above, this is the primary API
def terser_register_toolchains(name, terser_version, **kwargs):
    """Convenience macro for users which does typical setup.

    Users can avoid this macro and do these steps themselves, if they want more control.
    Args:
        name: base name for all created repos, like "terser"
        terser_version: a version which is mirrored into rules_terser
        **kwargs: passed to each node_repositories call
    """
    if terser_version not in TOOL_VERSIONS.keys():
        fail("""\
terser version {} is not currently mirrored into rules_terser.
Please instead choose one of these available versions: {}
Or, make a PR to the repo running /scripts/mirror_release.sh to add the newest version.
If you need custom versions, please file an issue.""".format(terser_version, TOOL_VERSIONS.keys()))

    npm_repositories = TOOL_VERSIONS[terser_version]
    npm_repositories()

    terser_repositories(
        name = name,
        terser_version = terser_version,
    )
