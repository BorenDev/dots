-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
local kmap = vim.keymap.set

-- Should be able to get the path from NVIM vars...?
local tmux_conf = "~/.config/tmux/tmux.conf"
local bashrcd = "~/.bashrc.d/"
local g_gitconfig = "~/.gitconfig"

-- Edit common files
kmap("n", "<leader>et", ":tabedit" .. tmux_conf .. "<CR>", { desc = "Edit tmux.conf" })
kmap("n", "<leader>eb", ":tabedit" .. bashrcd .. "<CR>", { desc = "Edit bashrc.d" })
kmap("n", "<leader>eg", ":tabedit" .. g_gitconfig .. "<CR>", { desc = "Edit global gitconfig" })

-- Suppress help
kmap({ "n", "v", "i" }, "<F1>", "<nop>", { desc = "Don't spit help at me" })

-- Move Lines
kmap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
kmap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
kmap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
kmap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
kmap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
kmap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
kmap("n", "<leader>bd", ":bd<CR>", { desc = "Buffer delete" })

-- Clear search with <esc>
kmap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
kmap("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
kmap("n", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
kmap("x", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
kmap("o", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
kmap("n", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })
kmap("x", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })
kmap("o", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })

-- saner behavior of j and k when wrapping
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- lazy
kmap("n", "<leader>Ol", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
kmap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

kmap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
kmap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

kmap("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
kmap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Diagnostics -----------------------------------------------------------------
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- kmap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
kmap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
kmap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
kmap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
kmap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
kmap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
kmap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- quit
kmap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Look at putting in LSP attach mappings...
kmap("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition in vertical split" })

-- windows
kmap("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
kmap("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
kmap("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
kmap("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
kmap("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
kmap("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
kmap("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })
kmap("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
kmap("n", "<leader>t<tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
kmap("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next Tab" })
kmap("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
kmap("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

kmap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", { desc = "Neogen generate", noremap = true, silent = true })
