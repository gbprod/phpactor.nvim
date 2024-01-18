local rpc = require("phpactor.rpc")
local utils = require("phpactor.utils")

return function()
  rpc.call("file_info", {
    path = utils.path(),
  }, {
    callback = function(file_info)
      if vim.NIL == file_info.class then
        vim.notify("No php class found", vim.log.levels.ERROR, { title = "PhpActor" })

        return
      end
      vim.fn.setreg(utils.get_default_register(), file_info.class)
    end,
  })
end
