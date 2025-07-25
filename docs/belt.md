# `belt` - Olion's compile unit

( like `crate` in Rust, `package` in Go, etc. )

## Manifest

The manifest file is `olion.toml` at the root of the project.

```toml
[belt]
name = "my-belt" # name of the belt
version = "0.1.0" # version of the belt
description = "A sample Olion belt" # description of the belt
authors = ["Your Name <example@email.com"] # authors of the belt
license = "MIT" # license of the belt
repository = "repository-url" # repository URL of the belt
homepage = "homepage-url" # homepage URL of the belt
documentation = "documentation-url" # documentation URL of the belt
keywords = ["olion", "belt", "example"] # keywords of the belt
edition = "2025" # edition of Olion

[dependencies]
# dependencies of the belt
# format: `name = "version"` or `name = { version = "version", ... }`
another-belt = "0.1.0" # example dependency

[dev-dependencies]
# development dependencies of the belt
codegen = "0.1.0" # example development dependency
```
