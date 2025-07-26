# My neovim config


## Requirements

* nvim >= 0.11.0
* git
* curl
* gzip
* unzip
* tar

## Dev

Commit convention (based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/))

Use `./commit-msg -- install-self` to install the hook to check commit format

**Types**

* `chore`:  mostly reserved for updating `lazy-lock.json`
* `command`: user commands
* `config`: configuration settings
* `core`: core functionality (LSP, keymap loading, etc.)
* `docs`: documentation
* `keybind`: user commands
* `lang`: language specific configurations
* `plugin`: plugin config/adding plugins

**Scope**

Mostly free-form. Plugin and language scopes need to match the plugin or
language respectively.
