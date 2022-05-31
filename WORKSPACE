# Declare the local Bazel workspace.
workspace(name = "aspect_rules_terser")

load(":internal_deps.bzl", "rules_terser_internal_deps")

# Fetch deps needed only locally for development
rules_terser_internal_deps()

load("@aspect_rules_terser//terser:dependencies.bzl", "rules_terser_dependencies")

rules_terser_dependencies()

load("@rules_nodejs//nodejs:repositories.bzl", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "node16",
    node_version = "16.9.0",
)

load("//terser:repositories.bzl", "terser_register_toolchains")

terser_register_toolchains(
    # Give an unusual name so it's obvious if we've hard-coded it somewhere
    name = "terser5",
    terser_version = "v5.13.0",
)

# For running our own unit tests
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

############################################
# Gazelle, for generating bzl_library targets
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.2")

gazelle_dependencies()
