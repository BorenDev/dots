--- Support optional editorconfig parameter `auto_format` to enable or disable
--- auto formatting code with conform by default.
---
---@param bufnr integer
---@param val string
---@param opts table
require("editorconfig").properties.auto_format = function(bufnr, val, opts)
  if opts.auto_format == "false" then
    vim.g.disable_autoformat = true
  else
    vim.g.disable_autoformat = false
  end
end
