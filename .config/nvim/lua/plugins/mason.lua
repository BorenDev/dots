local M = {
  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>Om", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- DAP
        "bash-debug-adapter",
        "cpptools",
        "debugpy",
        -- Formatter
        "isort",
        "black",
        "clang-format",
        -- "cmakelang",
        "luaformatter",
        "prettierd",
        "shfmt",
        "yamlfmt",
        -- Linter
        "ansible-lint",
        "flake8",
        "luacheck",
        "mypy",
        "pydocstyle",
        "pyflakes",
        "shellcheck",
        "shellharden",
        "stylua",
        "yamllint",
        -- LSP
        "ansible-language-server",
        "bash-language-server",
        -- "cmake-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "json-lsp",
        "lua-language-server",
        "yaml-language-server",
        "clangd",
        "marksman",
        "pyright",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}

return M
