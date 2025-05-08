return {
  "projekt0n/github-nvim-theme",
  priority = 1000,
  config = function()
    require("github-theme").setup({
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          functions = "NONE",
          variables = "NONE",
        },
      },
    })

    -- 👇 This selects the theme variant: "github_light"
    vim.cmd("colorscheme github_light")
  end,
}

