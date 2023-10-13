return function()
  local results, _ = vim.lsp.buf_request_sync(0, "blackfire/start", { ["return"] = true })

  for _, result in pairs(results or {}) do
    if result.error then
      vim.notify("Error while start blackfire", vim.log.levels.ERROR, { title = "PhpActor" })

      return
    end
  end

  vim.notify("Blackfire started", vim.log.levels.INFO, { title = "PhpActor" })
end
