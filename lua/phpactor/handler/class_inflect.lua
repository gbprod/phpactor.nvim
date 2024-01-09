local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function(options)
  rpc.call("class_inflect", {
    current_path = utils.path(),
    new_path = options["new_path"] or nil,
    variant = options["variant"] or nil,
    overwrite = options["overwrite"] or false,
  })
end
