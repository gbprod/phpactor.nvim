local config = require("phpactor.config")
local Path = require("plenary.path")

return function()
  local phpactor_path = Path:new(config.options.install.path .. "phpactor/")

  if not phpactor_path:exists() then
    return false
  end

  local network_status = os.execute("ping -c 2 8.8.8.8 > /dev/null 2>&1")
  if network_status ~= 0 then
    vim.notify("Network is not reachable, cannot check if Phpactor is up-to-date", vim.log.levels.ERROR, {
      title = "Phpactor",
    })

    return
  end

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
