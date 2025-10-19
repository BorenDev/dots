local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
    },
  },
  keys = {
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fr", ":lua require'telescope.builtin'.oldfiles{}<CR>", desc = "Recent" },
    { "<leader>fR", ":lua require'telescope.builtin'.oldfiles{ cwd = vim.loop.cwd()}<CR>", desc = "Recent" },
    { "<leader>fc", ":lua require'telescope.builtin'.find_files{ cwd = vim.fn.stdpath('config')}<CR>", desc = "Find Config File" },
    { "<leader><space>", ":lua require'telescope.builtin'.find_files{ vim.loop.cwd() }<CR>", desc = "Find Files cwd" },
    {
      "<leader>uC",
      ":lua require'telescope.builtin'.colorscheme{enable_preview = true}<CR>",
      desc = "Colorscheme with preview",
    },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gbc", "<cmd>Telescope git_bcommits<CR>", desc = "buffer commits" },
    { "<leader>gbc", "<cmd>Telescope git_bcommits_range<CR>", mode = "v", desc = "buffer commits range" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>st", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
    { "<leader>sw", ":lua require'telescope.builtin'.grep_string{ cwd = vim.loop.cwd(), word_match = '-w'}<CR>", desc = "Word (cwd)" },
    { "<leader>ss", ":lua require'telescope.builtin'.lsp_document_symbols{}<CR>", desc = "Search document symbols" },
    { "<leader>sS", ":lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<CR>", desc = "Search workspace symbols" },
    { "<leader>/", ":lua require'telescope.builtin'.live_grep{ cwd = vim.loop.cwd(), word_match = '-w'}<CR>", desc = "Live Grep (cwd)" },
  },
  opts = function()
    require("telescope").setup({
      pickers = {
        buffers = { theme = "ivy" },
        colorscheme = { theme = "ivy" },
        command_history = { theme = "ivy" },
        find_files = { theme = "ivy" },
        man_pages = { theme = "ivy" },
        oldfiles = { theme = "ivy" },
        marks = { theme = "ivy" },
        registers = { theme = "ivy" },
        current_buffer_fuzzy_find = { theme = "ivy" },
        resume = { theme = "ivy" },
        git_bcommits = { theme = "ivy" },
        git_bcommits_range = { theme = "ivy" },
      },
      extensions = {
        fzf = {},
      },
    })

    require("telescope").load_extension("fzf")
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end

    local open_tab = function(prompt_bufnr, _mode)
      local entry = require("telescope.actions.state").get_selected_entry()
      vim.api.nvim_input("<esc>")
      return vim.cmd("tabedit " .. entry.path)
    end

    local open_vsplit = function(prompt_bufnr, _mode)
      local entry = require("telescope.actions.state").get_selected_entry()
      vim.api.nvim_input("<esc>")
      return vim.cmd("vsplit " .. entry.path)
    end

    local open_split = function(prompt_bufnr, _mode)
      local entry = require("telescope.actions.state").get_selected_entry()
      vim.api.nvim_input("<esc>")
      return vim.cmd("split " .. entry.path)
    end

    local yank_selected_path = function()
      local entry = require("telescope.actions.state").get_selected_entry()
      local cb_opts = vim.opt.clipboard:get()
      if vim.tbl_contains(cb_opts, "unnamed") then
        vim.fn.setreg("*", entry.path)
      end
      if vim.tbl_contains(cb_opts, "unnamedplus") then
        vim.fn.setreg("+", entry.path)
      end
      vim.fn.setreg("", entry.path)
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<a-t>"] = open_with_trouble,
            ["<c-t>"] = open_tab,
            ["<c-v>"] = open_vsplit,
            ["<c-s>"] = open_split,
            ["<c-y>"] = yank_selected_path,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    }
  end,
}

return M
