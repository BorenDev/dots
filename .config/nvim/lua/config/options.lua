vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- TODO: Need to understand how this affects lsp formatting/conform
-- vim.g.autoformat = true

-- What does root_spec do? LazyVim command that shows info about the root dir detection
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.swapfile = false
opt.undofile = true
opt.colorcolumn = "80"
opt.termguicolors = true

-- From LazyVim
opt.autowrite = true
opt.completeopt = "menu,menuone,noselect,preview"
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.laststatus = 3
opt.inccommand = "nosplit"
opt.list = true
opt.number = true
opt.pumblend = 0
opt.pumheight = 15
opt.relativenumber = false
opt.scrolloff = 3
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
vim.wo.wrap = false
vim.wo.linebreak = false
vim.wo.list = false -- extra option I set in addition to the ones in your question
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
-- TODO:Review settings and decide if they're what I really want.
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --json"
opt.diffopt = "iwhite,filler"
opt.ruler = true
opt.showbreak = "↪"
opt.conceallevel = 0
vim.opt.breakindent = true

-- Folding
opt.foldlevel = 99
-- opt.foldtext = "v:lua.require'az.utils'.ui.foldtext()"
-- if vim.fn.has("nvim-0.9.0") == 1 then
--   opt.statuscolumn = [[%!v:lua.require'az.utils'.ui.statuscolumn()]]
-- end

opt.foldmethod = "syntax"
-- opt.formatexpr = "v:lua.require'az.utils'.format.formatexpr()"

--[[
-- Keep for reference
--]]
-- opt.mouse = "n" -- Enable mouse mode
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
