local command = {}

function command.run(args)
  local handler = require("phpactor.handler." .. args[1])

  local options = {}

  if "transform" == args[1] and nil ~= args[2] then
    options.transform = args[2]
  end

  handler(options)
end

return command
