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

  if "transform" == args.fargs[1] and nil ~= args.fargs[2] then
    options.transform = args.fargs[2]
  end

  phpactor.rpc(args.fargs[1], options)
end

return command
