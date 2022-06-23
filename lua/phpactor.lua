local phpactor = {}

function phpactor.setup(options)
  require("phpactor.config").setup(options)
end

function phpactor.complete()
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

function phpactor.command(args)
  if not vim.tbl_contains(phpactor.complete(), args.fargs[1]) then
    vim.notify("Invalid command", vim.log.levels.INFO, {})
    return
  end

  require("phpactor.command").run(args.fargs)
  -- require("phpactor.command." .. args.fargs[1]).run(args.fargs)
end

return phpactor
