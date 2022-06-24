local phpactor = {}

function phpactor.setup(options)
  local config = require("phpactor.config")
  config.setup(options)

  if config.options.install.check_on_startup then
    if not require("phpactor.check_install")() then
      vim.notify({ "PhpActor is outdated", "run `:PhpActor update`" }, vim.log.levels.INFO, { title = "PhpActor" })
    end
  end

  if config.options.lspconfig.enabled then
    require("lspconfig").phpactor.setup(vim.tbl_deep_extend("force", {
      cmd = {
        config.options.install.bin,
        "language-server",
      },
    }, config.options.lspconfig.options))
  end
end

return phpactor
