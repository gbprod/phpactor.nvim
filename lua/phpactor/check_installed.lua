local config = require("phpactor.config")
local Path = require("plenary.path")

return function()
  local phpactor_bin_path = Path:new(config.options.install.bin)

  return phpactor_bin_path:exists()
end
