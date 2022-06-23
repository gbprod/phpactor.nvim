local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("generate_accessor", {
    offset = utils.offset(),
    source = utils.source(),
    path = utils.path(),
  })
end
