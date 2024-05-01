local config = require("phpactor.config")
local utils = require("phpactor.utils")

local rpc = {}

function rpc.call(action, parameters, options)
  options = options or {}
  local request = { action = action, parameters = parameters }

  local workspace_dir = utils.get_root_dir()

  local cmd = string.format(
    '%s %s rpc --working-dir "%s"',
    config.options.install.php_bin,
    config.options.install.bin,
    workspace_dir
  )
  local result = vim.fn.system(cmd, vim.fn.json_encode(request))

  if vim.v.shell_error ~= 0 then
    vim.notify("Phpactor returns an error: " .. result, vim.log.levels.ERROR, { title = "PhpActor" })

    return
  end

  local response = vim.fn.json_decode(result)

  local handler = string.format("handle_%s", response["action"])

  if rpc[handler] == nil then
    vim.notify(
      "Do not know how to handle action '" .. response["action"] .. "'",
      vim.log.levels.ERROR,
      { title = "PhpActor" }
    )
    return
  end

  return rpc[handler](response["parameters"], options)
end

function rpc.handle_return(parameters, options)
  options.callback(parameters.value)
end

function rpc.handle_return_choice(parameters, options)
  vim.ui.select(vim.tbl_values(parameters.choices), {
    format_item = function(item)
      return item.name
    end,
  }, function(item)
    if nil == item then
      return
    end
    options.callback(item.value)
  end)
end

function rpc.handle_collection(parameters, options)
  for _, action in pairs(parameters.actions) do
    local handler = string.format("handle_%s", action.name)

    if rpc[handler] == nil then
      vim.notify(
        "Do not know how to handle action '" .. action.name .. "'",
        vim.log.levels.ERROR,
        { title = "PhpActor" }
      )
    else
      rpc[handler](action.parameters, options)
    end
  end
end

function rpc.handle_echo(parameters, options)
  options = options or {}
  if options.echo_mode == "float" then
    utils.open_message_win(vim.split(parameters.message, "\n", {}))
  else
    vim.notify(parameters.message, vim.log.levels.INFO, { title = "PhpActor" })
  end
end

function rpc.handle_error(parameters)
  vim.notify(parameters.message, vim.log.levels.ERROR, { title = "PhpActor" })
end

function rpc.handle_update_file_source(parameters)
  for _, edit in pairs(parameters.edits) do
    local bufnr = vim.fn.bufadd(parameters.path)

    -- @see https://github.com/phpactor/phpactor/blob/master/autoload/phpactor.vim#L459
    vim.api.nvim_buf_set_lines(
      bufnr,
      edit.start.line,
      edit["end"].line,
      false,
      vim.split(edit.text:gsub("\n$", ""), "\n", {})
    )
  end
end

function rpc.handle_input_callback(parameters)
  local input = table.remove(parameters.inputs)
  if "list" == input.type or "choice" == input.type then
    vim.ui.select(vim.tbl_values(input.parameters.choices), { prompt = input.parameters.label }, function(item)
      if nil == item then
        return
      end

      parameters.callback.parameters[input.name] = item
      rpc.call(parameters.callback.action, parameters.callback.parameters)
    end)

    return
  end

  if "text" == input.type then
    local opts = { prompt = input.parameters.label, default = input.parameters.default }
    if "file" == input.parameters.type then
      opts.completion = "file"
      opts.default = input.parameters.default
    end

    vim.ui.input(opts, function(item)
      if nil == item then
        return
      end

      parameters.callback.parameters[input.name] = item
      rpc.call(parameters.callback.action, parameters.callback.parameters)
    end)

    return
  end

  if "confirm" == input.type then
    vim.ui.select({ "Yes", "No" }, { prompt = input.parameters.label }, function(item)
      if nil == item or "No" == item then
        return
      end

      parameters.callback.parameters[input.name] = true
      rpc.call(parameters.callback.action, parameters.callback.parameters)
    end)

    return
  end

  vim.notify("Don't know how to handle input_callback: " .. input.type, vim.log.levels.ERROR, { title = "PhpActor" })
end

function rpc.handle_close_file(parameters)
  local bufnr = vim.fn.bufnr(parameters.path .. "$")

  if bufnr == -1 then
    return
  end

  vim.api.nvim_buf_delete(bufnr, {})
end

function rpc.handle_open_file(parameters, options)
  local target = options.target or parameters.target or "edit"

  local bufnr = vim.fn.bufnr(parameters.path .. "$")

  if -1 ~= bufnr and "focused_window" == target then
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), bufnr)
    return
  end

  local open_cmd = utils.get_open_cmd_form_target(target)

  vim.cmd(string.format("%s %s", open_cmd, parameters.path))

  if bufnr ~= -1 and parameters.force_reload == true then
    vim.cmd("edit!")
  end

  if parameters.offset ~= nil then
    vim.cmd(string.format("goto %s", parameters.offset + 1))
  end
end

function rpc.handle_replace_file_source(parameters)
  local bufnr = vim.fn.bufnr(parameters.path .. "$")

  if bufnr == -1 then
    vim.cmd(string.format("edit %s", parameters.path))
    bufnr = vim.fn.bufnr(parameters.path .. "$")
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(parameters.source, "\n", {}))
end

function rpc.handle_information(parameters)
  utils.open_message_win(vim.split(parameters.information, "\n", {}))
end

return rpc
