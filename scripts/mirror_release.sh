#!/usr/bin/env bash
# Produce a dictionary for the current esbuild release,
# suitable for appending to esbuild/private/versions.bzl
set -o errexit -o nounset
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

version="$(curl --silent "https://registry.npmjs.org/terser/latest" | jq --raw-output ".version")"
out="$SCRIPT_DIR/../terser/private/v${version}.bzl"
cd $(mktemp -d)
npm install terser
touch BUILD
cat >WORKSPACE <<EOF
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_rules_js",
    sha256 = "3e64e87a7885f1f4ae21ffaa2dc512b9bc315ff8b6e6332c9ccd5b38d66e230b",
    strip_prefix = "rules_js-0.4.0",
    url = "https://github.com/aspect-build/rules_js/archive/refs/tags/v0.4.0.tar.gz",
)

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_js//js:npm_import.bzl", "translate_package_lock")

translate_package_lock(name = "npm", package_lock = "//:package-lock.json")
EOF
bazel fetch @npm//:all
cp $(bazel info output_base)/external/npm/repositories.bzl "$out"
echo "Mirrored terser versior $version to $out. Now add it to terser/private/versions.bzl"
