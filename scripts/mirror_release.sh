#!/usr/bin/env bash
# Produce a dictionary for the current esbuild release,
# suitable for appending to esbuild/private/versions.bzl
set -o errexit -o nounset
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

version="${1:-$(curl --silent "https://registry.npmjs.org/terser/latest" | jq --raw-output ".version")}"
out="$SCRIPT_DIR/../terser/private/v${version}"
mkdir -p "$out"

cd $(mktemp -d)
npx pnpm install "terser@$version" --lockfile-only
touch BUILD
cat >WORKSPACE <<EOF
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_rules_js",
    sha256 = "538049993bec3ee1ae9b1c3cd669156bca04eb67027b222883e47b0a2aed2e67",
    strip_prefix = "rules_js-1.0.0",
    url = "https://github.com/aspect-build/rules_js/archive/refs/tags/v1.0.0.tar.gz",
)
load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@rules_nodejs//nodejs:repositories.bzl", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = "16.9.0",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "DEFAULT_YQ_VERSION", "register_yq_toolchains")

register_yq_toolchains(
    version = DEFAULT_YQ_VERSION,
)

load("@aspect_rules_js//npm:npm_import.bzl", "npm_translate_lock")

npm_translate_lock(name = "npm_aspect_rules_terser", pnpm_lock = "//:pnpm-lock.yaml")

load("@npm_aspect_rules_terser//:repositories.bzl", "npm_repositories")

npm_repositories()
EOF
bazel fetch @npm_aspect_rules_terser//:all
cp $(bazel info output_base)/external/npm_aspect_rules_terser/{defs,repositories}.bzl "$out"
echo "Mirrored terser versior $version to $out. Now add it to terser/private/versions.bzl"
