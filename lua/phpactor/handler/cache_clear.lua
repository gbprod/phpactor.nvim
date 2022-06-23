local rpc = require("phpactor.rpc")

return function()
  rpc.call("cache_clear", {})
end
