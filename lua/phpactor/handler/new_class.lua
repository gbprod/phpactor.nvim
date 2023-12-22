local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function(options)
  rpc.call("class_new", {
    current_path = utils.folder(),
    new_path = options["new_path"] or nil,
  })
end
