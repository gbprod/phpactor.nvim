local rpc = require("phpactor.rpc")

return function()
  rpc.call("config", {})
end
