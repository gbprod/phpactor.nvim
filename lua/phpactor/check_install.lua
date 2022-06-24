local config = require("phpactor.config")
local Path = require("plenary.path")

return function()
  local phpactor_path = Path:new(config.options.install.path .. "phpactor/")

  vim.fn.system({
    config.options.install.git_bin,
    "-C",
    phpactor_path:absolute(),
    "fetch",
    "origin",
    config.options.install.branch,
  })

  local current_status = vim.fn.system({
    config.options.install.git_bin,
    "-C",
    phpactor_path:absolute(),
    "status",
    "--porcelain",
    "--branch",
  })

  return string.match(current_status, "%[behind %d*%]") == nil
end
