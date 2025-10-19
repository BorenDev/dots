local kmap = vim.keymap.set

local function az_dbg()
  local dbg_val = vim.g.disable_autoformat
  if dbg_val then
    print("az_dbg" .. dbg_val)
  else
    print("az_dbg")
  end
end

local function print_keys()
  local keys = {}
  local n = 0
  local tab = require("lazy.core.config")
  local msg = ""
  for key, _ in pairs(tab) do
    n = n + 1
    keys[n] = key
    -- print(key)
    msg = key .. " " .. msg
  end
  -- print(keys)
  -- print("======")
  -- print(tab.notes_path)
  -- print("------")
  print(msg)
  return keys
end

local M = {
  kmap("n", "<leader>dz", function()
    print_keys()
  end, { desc = "az debug" }),
  kmap("n", "<leader>dm", "<cmd>messages<CR>", { desc = "show messages" }),
}

return M
