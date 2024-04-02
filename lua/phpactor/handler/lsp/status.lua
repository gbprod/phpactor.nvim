local utils = require("phpactor.utils")

return function()
  local results, _ = vim.lsp.buf_request_sync(0, "phpactor/status", { ["return"] = true })

  local message = {}
  for _, result in pairs(results or {}) do
    message = vim.tbl_extend("force", message, vim.split(result["result"] or {}, "\n", {}))
  end

  utils.open_message_win(message)
end
