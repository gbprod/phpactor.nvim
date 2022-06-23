local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("class_new", {
    current_path = utils.path(),
  })
end
