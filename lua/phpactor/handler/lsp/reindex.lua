return function()
  vim.lsp.buf_notify(0, "phpactor/indexer/reindex", {})

  vim.notify("Reindexing started", vim.log.levels.INFO, { title = "PhpActor" })
end
