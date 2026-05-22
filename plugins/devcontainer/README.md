# devcontainer

Apply [devcontainer](https://containers.dev/) templates from a registry with a single command.

## Prerequisite

Uses the [devcontainers CLI](https://github.com/devcontainers/cli), invoked on demand via
`npx @devcontainers/cli@latest` — no global install required, but `npx` (Node.js) must be
available.

## Usage

```sh
apply_devcontainer_template <template-name>
# or the short alias:
applytemplate <template-name>
```

Templates are pulled from `ghcr.io/dbarjs/devcontainer-templates/<template-name>`.

## Install (Sheldon)

```toml
[plugins.devcontainer]
github = "dbarjs/zsh"
dir = "plugins/devcontainer"
```
