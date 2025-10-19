local M = {
  {
    "ethro/jellybeans-nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme jellybeans-nvim]])
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    "EdenEast/nightfox.nvim",
    "HoNamDuong/hybrid.nvim",
    "blazkowolf/gruber-darker.nvim",
    "bluz71/vim-moonfly-colors",
    "dgox16/oldworld.nvim",
    "eldritch-theme/eldritch.nvim",
    "kaiuri/nvim-juliana",
    "miikanissi/modus-themes.nvim",
    "ramojus/mellifluous.nvim",
    "rebelot/kanagawa.nvim",
    "rockyzhang24/arctic.nvim",
    "shaeinst/roshnivim-cs",
    "xiantang/darcula-dark.nvim",
  },
}

return M
