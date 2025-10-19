local M = {
  {
    -- Easy configuration for trimming trailing whitespace and lines
    -- https://github.com/cappyzawa/trim.nvim
    "cappyzawa/trim.nvim",
    lazy = true,
    config = function()
      local trim = require("trim")

      trim.setup({
        ft_blocklist = { "markdown" },
        trim_on_write = true,
        trim_trailing = true,
        trim_last_line = true,
        trim_first_line = true,
      })
    end,
  },
}

return M
