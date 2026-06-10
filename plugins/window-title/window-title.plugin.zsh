# window-title — keep the terminal title in sync with the shell
# Idle: shows the current directory. Running: shows the command.
# See: plugins/window-title/README.md

# Register in $DBARJS_ZSH_PLUGINS — see docs/adr/0003-plugin-registry-as-shared-shell-array.md
typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})

autoload -Uz add-zsh-hook

_window_title_precmd()  { print -Pn '\e]0;%~\a'; }
_window_title_preexec() { printf '\e]0;%s\a' "$1"; }

add-zsh-hook precmd  _window_title_precmd
add-zsh-hook preexec _window_title_preexec
