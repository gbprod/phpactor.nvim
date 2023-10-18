local utils = {}

function utils.offset(winnr, bufnr)
  winnr = winnr or 0
  bufnr = bufnr or 0
  local cursor = vim.api.nvim_win_get_cursor(winnr)

  return vim.api.nvim_buf_get_offset(bufnr, cursor[1] - 1) + cursor[2] + 1
end

function utils.source(bufnr)
  bufnr = bufnr or 0

  return vim.fn.join(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
end

function utils.path(bufnr)
  bufnr = bufnr or 0

  return vim.api.nvim_buf_get_name(bufnr)
end

function utils.get_root_dir()
  local buf_clients = vim.lsp.get_clients({ name = "phpactor", bufnr = 0 })

  if #buf_clients > 0 then
    return buf_clients[1].config.root_dir
  end

  return vim.fn.getcwd()
end

function utils.open_message_win(content)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)

  vim.api.nvim_open_win(bufnr, true, {
    relative = "win",
    style = "minimal",
    row = math.floor(vim.o.lines * 0.05),
    height = math.floor(vim.o.lines * 0.9),
    col = math.floor(vim.o.columns * 0.05),
    width = math.floor(vim.o.columns * 0.9),
    border = "single",
  })
end

function utils.get_open_cmd_form_target(target)
  if "focused_window" == target then
    target = "edit"
  elseif "hsplit" == target then
    target = "split"
  elseif "new_tab" == target then
    target = "tabedit"
  end

  if not vim.tbl_contains({ "edit", "split", "vsplit", "tabedit" }, target) then
    return "edit"
  end

  return target
end

return utils
