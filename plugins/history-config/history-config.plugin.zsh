# history-config — zsh command history configuration
# Sets the history file, sizes, and append behavior.
# See: plugins/history-config/README.md

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
