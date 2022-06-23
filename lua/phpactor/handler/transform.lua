local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function(options)
  options = options or {}

  rpc.call("transform", {
    path = utils.path(),
    source = utils.source(),
    transform = options.transform or nil,
  })
end
