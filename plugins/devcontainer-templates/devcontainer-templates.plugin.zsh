# devcontainer-templates — apply devcontainer templates from a registry
# Requires the devcontainers CLI (invoked via `npx @devcontainers/cli`).
# See: plugins/devcontainer-templates/README.md

# Register in $DBARJS_ZSH_PLUGINS — see docs/adr/0003-plugin-registry-as-shared-shell-array.md
typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})

# Apply a devcontainer template by name from ghcr.io/dbarjs/devcontainer-templates.
apply_devcontainer_template() {
  local template="ghcr.io/dbarjs/devcontainer-templates/$1"

  echo "Applying devcontainer template from $template"

  npx @devcontainers/cli@latest templates apply -t "$template"
}

alias applytemplate="apply_devcontainer_template"
