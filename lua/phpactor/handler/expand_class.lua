local rpc = require("phpactor.rpc")

return function()
  local word = vim.fn.expand("<cword>")
  local class_info = rpc.call("class_search", { short_name = word })

  if class_info == nil then
    return
  end

  vim.cmd(string.format("normal! ciw%s", class_info["class"]))
end
