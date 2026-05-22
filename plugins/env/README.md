# env

Load environment variables from a dotenv-style file into the current shell.

## Usage

```sh
read_env [path]
```

`path` defaults to `.env` in the current directory. The variables are `export`ed into the
running shell. Nothing is loaded automatically — call `read_env` explicitly.

If the file does not exist, `read_env` prints an error to stderr and returns `1`. It does
**not** exit the shell.

## Supported syntax

- Blank lines and `#`-comment lines are ignored.
- An optional `export ` prefix is stripped.
- The line is split on the **first** `=`, so `=` may appear in values.
- A matching pair of surrounding `"..."` or `'...'` quotes is stripped from the value.
  Anything after the closing quote (e.g. an inline `# comment`) is dropped.
- Leading/trailing whitespace around the key is trimmed.

Example `.env`:

```sh
# database
export DB_URL="postgres://u:p@host/db?x=1" # primary
TOKEN='abc=def'
```

## Install (Sheldon)

```toml
[plugins.env]
github = "dbarjs/zsh"
dir = "plugins/env"
```
