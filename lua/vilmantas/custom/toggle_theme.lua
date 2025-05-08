local themes = { "solarized", "github_light", "github_dark" }
local current = 1

vim.api.nvim_create_user_command("ToggleTheme", function()
  current = (current % #themes) + 1
  vim.cmd("colorscheme " .. themes[current])
  print("Switched to colorscheme: " .. themes[current])
end, {})

