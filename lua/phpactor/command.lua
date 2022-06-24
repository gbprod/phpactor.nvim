local command = {}

function command.complete()
  return {
    "cache_clear",
    "class_inflect",
    "config",
    "context_menu",
    "copy_class",
    "expand_class",
    "generate_accessor",
    "change_visibility",
    "import_class",
    "import_missing_classes",
    "move_class",
    "navigate",
    "new_class",
    "status",
    "transform",
    "update",
  }
end

function command.run(args)
  if not vim.tbl_contains(command.complete(), args.fargs[1]) then
    vim.notify("Invalid command", vim.log.levels.INFO, {})
    return
  end

  local handler = require("phpactor.handler." .. args.fargs[1])

  local options = {}

  if "transform" == args[1] and nil ~= args[2] then
    options.transform = args[2]
  end

  handler(options)
end

return command
