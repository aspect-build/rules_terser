"""Mirror of release info"""

# Run /scripts/mirror_release.sh to produce a new bzl file.
load("v5.13.0/repositories.bzl", v5_13_0 = "npm_repositories")
load("v5.14.0/repositories.bzl", v5_14_0 = "npm_repositories")

TOOL_VERSIONS = {
    "v5.13.0": v5_13_0,
    "v5.14.0": v5_14_0,
}

LATEST_VERSION = TOOL_VERSIONS.keys()[-1]
