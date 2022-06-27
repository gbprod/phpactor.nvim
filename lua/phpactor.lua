local config = require("phpactor.config")

local phpactor = {}

function phpactor.setup(options)
  config.setup(options)

  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = phpactor.check_install,
  })

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
  if config.options.install.check_on_startup == "none" then
    return
  end

  if config.options.install.check_on_startup == "daily" then
    if vim.g.PHPACTOR_LAST_CHECK ~= nil and vim.g.PHPACTOR_LAST_CHECK == os.date("%x") then
      return
    end

    vim.g.PHPACTOR_LAST_CHECK = os.date("%x")
  end

  if not require("phpactor.check_install")() then
    vim.notify({ "PhpActor is outdated", "run `:PhpActor update`" }, vim.log.levels.INFO, { title = "PhpActor" })
  end
end

return phpactor
