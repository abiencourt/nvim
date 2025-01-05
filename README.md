# Neovim Config

[![Plugin Manager](https://dotfyle.com/abiencourt/nvim/badges/plugin-manager?style=flat)](https://dotfyle.com/abiencourt/nvim)
[![Leaderkey](https://dotfyle.com/abiencourt/nvim/badges/leaderkey?style=flat)](https://dotfyle.com/abiencourt/nvim)

[![Last commit](https://img.shields.io/github/last-commit/abiencourt/nvim?style=flat)](https://github.com/abiencourt/nvim/commits/master)
[![Coding time over the last 30 days](https://wakapi.dev/api/badge/abiencourt/interval:30_days/label:nvim?label=last%2030d)](https://wakapi.dev/)

![Neovim Screenshot](./docs/images/neovim_screenshot.png)

## Installation

> Install requires Neovim 0.9+.

Clone the repository and install the plugins:

```sh
git clone git@github.com:abiencourt/nvim ~/.config/abiencourt/nvim
NVIM_APPNAME=abiencourt/nvim/ nvim --headless +"Lazy! restore" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=abiencourt/nvim/ nvim
```

## Tips

### LSPs, formatters and linters

Documentation on the configuration of LSPs, formatters and linters is available in this [README.md](lua/abiencourt/plugins/lsp-formatter-linter/README.md)

### Search and replace

The below applies when replacing using `:%s`.

- You can use `<C-r><C-w>` to get the word under the cursor into to command line.
- When a word was already searched (e.g. `\word`), use `:%s//` to replace the word searched.

### Useful keymaps

- `<C+]>` is used to follow tags in `:help`

### nvm

As [nvm](https://github.com/nvm-sh/nvm) is used to switch versions of Node.js, some plugins might require to rebuild when changing `nvm` default version:

- markmap.nvim
- import-cost.nvim
