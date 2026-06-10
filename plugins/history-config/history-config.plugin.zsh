# history-config — zsh command history configuration
# Sets the history file, sizes, and append behavior.
# See: plugins/history-config/README.md

# Register in $DBARJS_ZSH_PLUGINS — see docs/adr/0003-plugin-registry-as-shared-shell-array.md
typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
