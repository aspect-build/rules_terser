# How to Contribute

## Formatting

Starlark files should be formatted by buildifier.
We suggest using a pre-commit hook to automate this.
First [install pre-commit](https://pre-commit.com/#installation),
then run

```shell
pre-commit install
```

Otherwise later tooling on CI may yell at you about formatting/linting violations.

## Using this as a development dependency of other rules

You'll commonly find that you develop in another repository, such as
some other ruleset that depends on rules_terser.

To always tell Bazel to use this directory rather than some release
artifact or a version fetched from the internet, run this from this
directory:

```sh
OVERRIDE="--override_module=aspect_rules_terser=$(pwd)"
echo "common $OVERRIDE" >> ~/.bazelrc
```

This means that any usage of `@aspect_rules_terser` on your system will point to this folder.

## Releasing

1. Determine the next release version, following semver (could automate in the future from changelog)
1. Tag the repo and push it (or create a tag in GH UI)
1. Watch the automation run on GitHub actions
