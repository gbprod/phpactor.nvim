local rpc = require("phpactor.rpc")

return function()
  rpc.call("status", {
    type = "formatted",
  }, {
    echo_mode = "float",
  })
end
