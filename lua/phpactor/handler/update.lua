local config = require("phpactor.config")

return function()
  local Path = require("plenary.path")
  local install_path = Path:new(config.options.install.path)
  local phpactor_path = Path:new(config.options.install.path .. "phpactor/")
  local trace

  if not phpactor_path:exists() then
    vim.notify({ "Phpactor install not found, clone repo" }, vim.log.levels.INFO, { title = "PhpActor" })

    if not install_path:mkdir({ parents = true }) then
      vim.notify({ "Error while installing phpactor : mkdir failed" }, vim.log.levels.ERROR, { title = "PhpActor" })

      return
    end

    trace = vim.fn.system({
      config.options.install.git_bin,
      "clone",
      "https://github.com/phpactor/phpactor.git",
      phpactor_path:absolute(),
    })

    if vim.v.shell_error > 0 then
      vim.notify(
        vim.tbl_extend("keep", { "Error while installing phpactor : clone failed", "" }, vim.split(trace, "\n")),
        vim.log.levels.ERROR,
        { title = "PhpActor" }
      )

      return
    end
  else
    if require("phpactor.check_install")() then
      vim.notify("PhpActor is already up-to-date", vim.log.levels.INFO, { title = "PhpActor" })

      return
    end
  end

  trace = vim.fn.system({
    config.options.install.git_bin,
    "-C",
    phpactor_path:absolute(),
    "checkout",
    config.options.install.branch,
  })

  if vim.v.shell_error > 0 then
    vim.notify(
      vim.tbl_extend("keep", { "Error while updating phpactor : checkout failed", "" }, vim.split(trace, "\n")),
      vim.log.levels.ERROR,
      { title = "PhpActor" }
    )
    return
  end

  trace = vim.fn.system({
    config.options.install.git_bin,
    "-C",
    phpactor_path:absolute(),
    "pull",
    "origin",
    config.options.install.branch,
  })

  if vim.v.shell_error > 0 then
    vim.notify(
      vim.tbl_extend("keep", { "Error while updating phpactor : pull failed", "" }, vim.split(trace, "\n")),
      vim.log.levels.ERROR,
      { title = "PhpActor" }
    )

    return
  end

  trace = vim.fn.system({
    config.options.install.composer_bin,
    "install",
    "--optimize-autoloader",
    "--classmap-authoritative",
    "-d",
    phpactor_path:absolute(),
  })

  if vim.v.shell_error > 0 then
    vim.notify(
      vim.tbl_extend("keep", { "Error while updating phpactor : composer failed", "" }, vim.split(trace, "\n")),
      vim.log.levels.ERROR,
      { title = "PhpActor" }
    )

    return
  end

  vim.notify("PhpActor updated", vim.log.levels.INFO, { title = "PhpActor" })
end
