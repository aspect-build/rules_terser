#!/usr/bin/env bash
# Produce a dictionary for the current esbuild release,
# suitable for appending to esbuild/private/versions.bzl
set -o errexit -o nounset
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

version="$(curl --silent "https://registry.npmjs.org/terser/latest" | jq --raw-output ".version")"
out="$SCRIPT_DIR/../terser/private/v${version}"
mkdir -p "$out"

cd $(mktemp -d)
npx pnpm install terser
yq -o=json -I=2 eval pnpm-lock.yaml > pnpm-lock.json
touch BUILD
cat >WORKSPACE <<EOF
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive,
    name = "aspect_rules_js",
    sha256 = "fae5e9ee00dc52d29a1eafea3e6d8293ac38da219cc86691cd4e10ade4b3b264",
    strip_prefix = "rules_js-2736ed7c95a418f9976c365ae13731b0522574bd",
    url = "https://github.com/aspect-build/rules_js/archive/2736ed7c95a418f9976c365ae13731b0522574bd.tar.gz",
)
load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_js//js:npm_import.bzl", "translate_pnpm_lock")

translate_pnpm_lock(name = "npm", pnpm_lock = "//:pnpm-lock.json")
EOF
bazel fetch @npm//:all
cp $(bazel info output_base)/external/npm/{node_modules,repositories}.bzl "$out"
echo "Mirrored terser versior $version to $out. Now add it to terser/private/versions.bzl"
