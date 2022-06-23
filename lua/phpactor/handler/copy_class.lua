local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("copy_class", {
    source_path = utils.path(),
  })
end
