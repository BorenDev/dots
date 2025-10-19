local M = {
  "smjonas/inc-rename.nvim",
  config = function()
    require("inc_rename").setup({
         input_buffer_type = "dressing",
    })
  end,
}

return M
