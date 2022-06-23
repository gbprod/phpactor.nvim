local phpactor = require("phpactor")

vim.api.nvim_create_user_command("PhpActor", phpactor.command, {
  nargs = "*",
  complete = phpactor.complete,
})
