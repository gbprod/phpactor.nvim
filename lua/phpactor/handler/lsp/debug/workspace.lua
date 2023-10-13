local utils = require("phpactor.utils")

return function()
  local results, _ = vim.lsp.buf_request_sync(0, "phpactor/debug/workspace", { ["return"] = true })
  print(vim.inspect(results))
  local message = {}
  for _, result in ipairs(results or {}) do
    message = vim.tbl_extend("force", message, vim.split(result["result"] or "", "\n", {}))
  end
  utils.open_message_win(message)
end
