# Context & glossary

Shared vocabulary for this repository. Use these terms consistently in code, commits, and
documentation.

## Plugin

A self-contained directory under `plugins/<name>/` that owns a **single concern**. It
consists of a `<name>.plugin.zsh` entry file and a `README.md`. A plugin is loaded
independently by Sheldon and must not depend on any other plugin in this repo.

_Avoid_ calling it a "module" or "package" — it is a **plugin**.

## Concern

The single responsibility a plugin owns (e.g. git aliases, history configuration). If a
change introduces a second, unrelated concern, it belongs in a new plugin instead.

## Sheldon

The [Rust zsh plugin manager](https://sheldon.cli.rs/) that consumes this repo. Users
declare plugins in a `plugins.toml` file; Sheldon fetches them and generates the source
lines for `.zshrc`. This repo's file layout (`plugins/<name>/<name>.plugin.zsh`) is chosen
to match Sheldon's default `match` templates.
