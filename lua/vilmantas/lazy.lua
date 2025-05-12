-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set mapleader before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Import plugins from lua/plugins/
    { import = "plugins" },
  },
  install = {
    -- Optional: set a default colorscheme on plugin install
    colorscheme = { "habamax" },
  },
  checker = {
    enabled = true, -- Enable automatic plugin update checking
  },
  change_detection = {
    enabled = true,  -- Detect changes in plugin config files
    notify = false,  -- ✅ Don't show the "press any key to continue" message
  },
})

