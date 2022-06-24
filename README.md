# 🐘 phpactor.nvim

Lua version of [phpactor](https://github.com/phpactor/phpactor) nvim plugin.

## ✨ Features

It allows to use phpactor commands using new neovim lua api. It uses `vim.ui`
and `vim.notify` to provide modern UI using plugins like [nvim-notify](https://github.com/rcarriga/nvim-notify)
[dressing.nvim](https://github.com/stevearc/dressing.nvim) or [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

I've only implemented commands that are not available using LSP Code Actions.

It also automaticly install, update and configure [phpactor](https://github.com/phpactor/phpactor)
using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).

This provides `PhpActor` command to call phpactor rpc methods:

`PhpActor [class_inflect|context_menu|expand_class|generate_accessor|change_visibility|copy_class|import_class|import_missing_classes|move_class|navigate|new_class|transform|update|config|status|cache_clear]`

## ⚡️ Requirements

- Neovim >= 0.7.0

## 📦 Installation

Install the plugin with your preferred package manager:

### [packer](https://github.com/wbthomason/packer.nvim)

```lua
-- Lua
use({
  "gbprod/phpactor.nvim",
  run = require("phpactor.handler.update"), -- To install/update phpactor when installing this plugin
  requires = {
    "nvim-lua/plenary.nvim", -- required to update phpactor
    "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
  },
  config = function()
    require("phpactor").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
  end
})
```

## ⚙️ Configuration

`phpactor.nvim` comes with the following defaults:

```lua
{
  install = {
    path = vim.fn.stdpath("data") .. "/opt/",
    branch = "master",
    bin = vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor",
    php_bin = "php",
    composer_bin = "composer",
    git_bin = "git",
    check_on_startup = false,
  },
  lspconfig = {
    enabled = true,
    options = {},
  },
}
```

### `install.path`

Default : `vim.fn.stdpath("data") .. "/opt/"`

Path where phpactor will be installed by the plugin. This could be an existing
install of phpactor.

### `install.branch`

Default : `master`

Branch that will be used for phpactor.

### `install.bin`

Default: `vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor"`

Phpactor binary.

### `install.php_bin`

Default: `php`

Php binary.

### `install.composer_bin`

Default: `composer`

Composer binary.

### `install.git_bin`

Default: `git`

Git binary.

### `install.check_on_startup`

Default: `false`

This will check if phpactor install is up-to-date on nvim startup. This could be
slow, use wisely.

### `lspconfig.enabled`

Default: `true`

Does `phpactor.nvim` should configure lsp server using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/).

### `lspconfig.options`

Default: `{}`

This is here where you can define options to pass to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/).
Basicly, you should pass a `on_attach` function to set your mappings ;)

## 🎉 Credits

- [phpactor](https://github.com/phpactor/phpactor) for this awesome lsp serveur
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/).
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
