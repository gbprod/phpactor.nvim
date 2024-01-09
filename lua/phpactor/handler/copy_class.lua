local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function(options)
  rpc.call("copy_class", {
    source_path = utils.path(),
    dest_path = options["dest_path"] or nil,
  })
end
