# env — load environment variables from a dotenv-style file
# Provides `read_env [path]`; nothing is loaded automatically.
# See: plugins/env/README.md

# Read KEY=VALUE pairs from a file (default: .env) and export them.
# Supports: blank/`#`-comment lines, an optional `export ` prefix,
# `=` inside values, and matching surrounding "..." / '...' quotes
# (anything after a closing quote, e.g. an inline comment, is dropped).
read_env() {
  emulate -L zsh
  setopt extended_glob

  local file_path="${1:-.env}"

  if [[ ! -f "$file_path" ]]; then
    print -u2 "read_env: missing ${file_path}"
    return 1
  fi

  local line key value
  while IFS= read -r line || [[ -n "$line" ]]; do
    # strip a trailing carriage return, then surrounding whitespace
    line="${line%$'\r'}"
    line="${line##[[:space:]]##}"
    line="${line%%[[:space:]]##}"

    # skip blank and comment lines
    [[ -z "$line" || "$line" == '#'* ]] && continue

    # drop an optional leading `export ` prefix
    line="${line#export[[:space:]]##}"

    # require a KEY=VALUE form, then split on the first `=`
    [[ "$line" != *'='* ]] && continue
    key="${line%%=*}"
    value="${line#*=}"

    # trim whitespace around the key
    key="${key##[[:space:]]##}"
    key="${key%%[[:space:]]##}"
    [[ -z "$key" ]] && continue

    # strip a matching pair of surrounding quotes from the value
    if [[ "$value" == \"*\"* ]]; then
      value="${value#\"}"
      value="${value%%\"*}"
    elif [[ "$value" == \'*\'* ]]; then
      value="${value#\'}"
      value="${value%%\'*}"
    fi

    export "${key}=${value}"
  done < "$file_path"
}
