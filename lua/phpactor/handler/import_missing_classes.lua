local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("import_missing_classes", {
    source = utils.source(),
    path = utils.path(),
  })
end
