# 🐘 phpactor.nvim

Lua version of [phpactor](https://github.com/phpactor/phpactor) nvim plugin.

## ✨ Features

It allows to use phpactor commands using new neovim lua api. It uses `vim.ui`
and `vim.notify` to provide modern UI using plugins like [nvim-notify](https://github.com/rcarriga/nvim-notify), [notifier.nvim](https://github.com/vigoux/notifier.nvim),
[dressing.nvim](https://github.com/stevearc/dressing.nvim) or [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

I've only implemented commands that are not available using LSP Code Actions.

It also automaticly install, update and configure [phpactor](https://github.com/phpactor/phpactor)
using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).

This provides `PhpActor` command to call phpactor rpc methods:

```
PhpActor [
  class_inflect
  context_menu
  expand_class
  generate_accessor
  change_visibility
  copy_class
  import_class
  import_missing_classes
  move_class
  navigate
  new_class
  transform
  update
  config
  status
  cache_clear
  copy_fcqn
  lsp/status
  lsp/reindex
  lsp/debug/config
  lsp/debug/config
  blackfire/start
  blackfire/stop
]
```

You can also use the lua function `require('phpactor').rpc(name, options)`.
Eg: `:lua require('phpactor').rpc('context_menu', {})`

## ⚡️ Requirements

- Neovim >= 0.7.0

## 📦 Installation

Install the plugin with your preferred package manager:

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- Lua
{
  {
    "gbprod/phpactor.nvim",
    ft = "php",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      -- If the update/install notification doesn't show properly,
      -- you should also add here UI plugins like "folke/noice.nvim" or "stevearc/dressing.nvim"
    },
    opts = {
      -- you're options goes here
    },
  },
}
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
    check_on_startup = "none",
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

Default: `none`  
Accepted values: `none|daily|always`

This will check if phpactor install is up-to-date when the plugin is loaded.  
This could be slow, use wisely.

### install.confirm

Default: `true`

If true, will ask for confirmation before installing/updating phpactor.

### `lspconfig.enabled`

Default: `true`

Does `phpactor.nvim` should configure lsp server using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/).

### `lspconfig.options`

Default: `{}`

This is here where you can define options to pass to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/).
Basicly, you should pass a `on_attach` function to set your mappings ;)

## 🤝 Integration

<details>
<summary><b>nvim-neo-tree/neo-tree.nvim</b></summary>

This plugin works out-of-the-box with [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim).
If you execute a `PhpActor navigate` command on a file/folder in neo-tree, it will use this file as source.

Eg. If you run `PhpActor new_class` in a neo-tree buffer, this will create a new class inside the folder you are in.

</details>

## 🎉 Credits

- [phpactor](https://github.com/phpactor/phpactor) for this awesome lsp serveur
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/)
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
