local config = {}

config.options = {}

local default_values = {
  install = {
    path = vim.fn.stdpath("data") .. "/opt/",
    branch = "master",
    bin = vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor",
    php_bin = "php",
  },
}

function config.setup(options)
  config.options = vim.tbl_deep_extend("force", default_values, options or {})

  -- add trailing space if necessary
  if nil == string.match(config.options.install.path, "/$") then
    config.options.install.path = config.options.install.path .. "/"
  end
end

return config
