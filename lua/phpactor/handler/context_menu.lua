local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("context_menu", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  })
end
