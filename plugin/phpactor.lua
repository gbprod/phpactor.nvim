local command = require("phpactor.command")

vim.api.nvim_create_user_command("PhpActor", command.run, {
  nargs = "*",
  complete = command.complete,
})
