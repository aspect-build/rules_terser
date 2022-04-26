"""Mirror of release info"""

# Run /scripts/mirror_release.sh to produce a new bzl file.
load("v5.12.1/repositories.bzl", v5_12_1 = "npm_repositories")
load("v5.13.0/repositories.bzl", v5_13_0 = "npm_repositories")

TOOL_VERSIONS = {
    "v5.12.1": v5_12_1,
    "v5.13.0": v5_13_0,
}
