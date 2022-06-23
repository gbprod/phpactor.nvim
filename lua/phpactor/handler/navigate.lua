local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("navigate", {
    source_path = utils.path(),
  })
end
