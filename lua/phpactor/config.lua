local config = {}

config.options = {}

local default_values = {
  install = {
    path = vim.fn.stdpath("data") .. "/opt/",
    branch = "master",
    bin = nil,
    php_bin = "php",
    composer_bin = "composer",
    git_bin = "git",
    check_on_startup = "none",
    confirm = true,
  },
  lspconfig = {
    enabled = true,
    options = {},
  },
}

function config.setup(options)
  config.options = vim.tbl_deep_extend("force", default_values, options or {})

  -- add trailing space if necessary
  if nil == string.match(config.options.install.path, "/$") then
    config.options.install.path = config.options.install.path .. "/"
  end

  if nil == config.options.install.bin then
    config.options.install.bin = config.options.install.path .. "phpactor/bin/phpactor"
  end

  if not vim.tbl_contains({ "daily", "always", "none" }, config.options.install.check_on_startup) then
    vim.notify(
      "Invalid value for `check_on_startup` option\nAccepted values : daily, always, none",
      vim.log.levels.ERROR,
      { title = "PhpActor" }
    )
    config.options.install.check_on_startup = "none"
  end
end

return config
