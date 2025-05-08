return {
  "maxmx03/solarized.nvim",
  priority = 1000,
  config = function()
    require("solarized").setup({
      theme = "neo", -- or "default"
      transparent = {
        enable = false, -- ✅ FIXED: now a table
      },
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    })

    vim.o.background = "light"
    vim.cmd("colorscheme solarized")
  end,
}

