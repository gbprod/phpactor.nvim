local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("class_inflect", {
    current_path = utils.path(),
  })
end
