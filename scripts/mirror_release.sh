#!/usr/bin/env bash
# Produce a dictionary for the current terser release,
# suitable for appending to terser/private/versions.bzl
set -o errexit -o nounset
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

version="${1:-$(curl --silent "https://registry.npmjs.org/terser/latest" | jq --raw-output ".version")}"

out="$SCRIPT_DIR/../terser/private/v${version}"
mkdir -p "$out"

cd $(mktemp -d)
npx pnpm install "terser@$version" --lockfile-only
cp pnpm-lock.yaml "$out"
cp package.json "$out"
echo "Mirrored terser versior $version to $out. Now add it to terser/private/versions.bzl"
