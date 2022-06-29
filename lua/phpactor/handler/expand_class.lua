local rpc = require("phpactor.rpc")

return function()
  local word = vim.fn.expand("<cword>")
  rpc.call("class_search", {
    short_name = word,
  }, {
    callback = function(class_info)
      if class_info == nil then
        return
      end

      vim.cmd(string.format("normal! ciw%s", class_info["class"]))
    end,
  })
end
