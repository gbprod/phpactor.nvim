local config = require("phpactor.config")

local phpactor = {}

phpactor.AVAILABLE_RPC = {
  "cache_clear",
  "class_inflect",
  "config",
  "context_menu",
  "copy_class",
  "expand_class",
  "generate_accessor",
  "change_visibility",
  "import_class",
  "import_missing_classes",
  "move_class",
  "navigate",
  "new_class",
  "status",
  "transform",
  "update",
  "copy_fcqn",
  "lsp/status",
  "lsp/reindex",
  "lsp/debug/config",
  "lsp/debug/workspace",
  "blackfire/start",
  "blackfire/finish",
}

function phpactor.setup(options)
  config.setup(options)

  vim.schedule(phpactor.check_install)

  if config.options.lspconfig.enabled then
    require("lspconfig").phpactor.setup(vim.tbl_deep_extend("force", {
      cmd = {
        config.options.install.bin,
        "language-server",
      },
    }, config.options.lspconfig.options))
  end
end

function phpactor.check_install()
  local do_update = function(confirm_message)
    if config.options.install.confirm then
      vim.ui.select({ "Yes", "No" }, {
        prompt = confirm_message,
      }, function(item)
        if item == "Yes" then
          require("phpactor.handler.update")()
        end
      end)
    else
      require("phpactor.handler.update")()
    end
  end

  if not require("phpactor.check_installed")() then
    do_update("Phpactor is not installed, would you like to install it?")

    return
  end

  if config.options.install.check_on_startup == "none" then
    return
  end

  if config.options.install.check_on_startup == "daily" then
    if vim.g.PHPACTOR_LAST_CHECK ~= nil and vim.g.PHPACTOR_LAST_CHECK == os.date("%x") then
      return
    end

    vim.g.PHPACTOR_LAST_CHECK = os.date("%x")
  end

  if not require("phpactor.check_uptodate")() then
    do_update("Phpactor is not up-to-date, would you like to update it?")
  end
end

function phpactor.rpc(name, options)
  options = options or {}

  if not vim.tbl_contains(phpactor.AVAILABLE_RPC, name) then
    name = "context_menu"
  end

  local handler = require("phpactor.handler." .. name)

  handler(options)
end

return phpactor
