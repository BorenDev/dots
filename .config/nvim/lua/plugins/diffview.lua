local M = {
  "sindrets/diffview.nvim",
  opts = {
    default_mappings = true,
    resizing_mappings = true,
    height = 25,
    on_attach = function(buffer)
      local function kmap(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

        -- stylua: ignore start
        kmap("n", "<leader>do", "<cmd>DiffviewOpen<cr>", "DiffviewOpen")
        kmap("n", "<leader>dq", "<cmd>DiffviewClose<cr>", "DiffviewClose")
    end,
  },
}

return M
