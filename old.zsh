
# Configurações de Histórico
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

# TODO: move to separate file
read_env() {
  local filePath="${1:-.env}"

  if [ ! -f "$filePath" ]; then
    echo "missing ${filePath}"
    exit 1
  fi

  # echo "Reading $filePath"
  
  while read -r LINE; do
    # Remove leading and trailing whitespaces, and carriage return
    CLEANED_LINE=$(echo "$LINE" | awk '{$1=$1};1' | tr -d '\r')

    if [[ $CLEANED_LINE != '#'* ]] && [[ $CLEANED_LINE == *'='* ]]; then
      export "$CLEANED_LINE"
    fi
  done < "$filePath"
}

# -------------------------------- #
# Node Package Manager
# -------------------------------- #
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev --no-fork"
alias play="nr play --no-fork"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias p="nr play"
alias c="nr typecheck"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"

# -------------------------------- #
# Git
# -------------------------------- #
# https://github.com/antfu/ni

alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'

# -------------------------------- #
# Dev Containers
# -------------------------------- #

# function to apply devcontainer templates with argument for the url of template
apply_devcontainer_template() {
  local template="ghcr.io/dbarjs/devcontainer-templates/$1"

  echo "Applying devcontainer template from $template"

  npx @devcontainers/cli@latest templates apply -t "$template"
}

alias applytemplate="apply_devcontainer_template"


# -------------------------------- #
# Window Title
# -------------------------------- #
function set_win_title(){
  echo -ne "\033]0; YOUR_WINDOW_TITLE_HERE \007"
}

precmd_functions+=(set_win_title)

