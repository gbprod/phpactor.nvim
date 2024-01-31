local phpactor = require("phpactor")

local command = {}

function command.complete()
  return phpactor.AVAILABLE_RPC
end

function command.run(args)
  if not vim.tbl_contains(phpactor.AVAILABLE_RPC, args.fargs[1]) then
    args.fargs[1] = "context_menu"
  end

  local options = {}

  local do_run = function(cmd, ...)
    for _, argument in ipairs({ ... }) do
      if argument:find("=", 1) ~= nil then
        local param = vim.split(argument, "=")
        local key = table.remove(param, 1)
        param = table.concat(param, "=")
        options[key] = param
      end
    end

    phpactor.rpc(cmd, options)
  end

  local table_unpack = table.unpack or unpack
  do_run(table_unpack(args.fargs))
end

return command
