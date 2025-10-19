local M = {
  -- https://github.com/stevearc/conform.nvim#installation
  -- Lightweight yet powerful formatter plugin for Neovim
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua", "luaformatter" },
        -- json = { "prettierd" },
        markdown = { "prettierd" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    })

    local kmap = vim.keymap.set
    kmap({ "n", "v" }, "<leader>cf", "<cmd>lua require('conform').format()<CR>", { desc = "Format Buffer" })
  end,
}

return M
