local M = {
  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    -- event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function kmap(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        kmap("n", "]g", gs.next_hunk, "Next Hunk")
        kmap("n", "[g", gs.prev_hunk, "Prev Hunk")
        kmap({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        kmap({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        kmap("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        kmap("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        kmap("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        kmap("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        kmap("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        kmap("n", "<leader>gd", gs.diffthis, "Diff This")
        kmap("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        kmap({ "o", "x" }, "gh", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
}

return M
