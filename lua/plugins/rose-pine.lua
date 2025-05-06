return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
        require("rose-pine").setup({
            variant = "auto",
            dark_variant = "moon",
            disable_italics = true,
            italics = false,
            highlight_groups = {
            ColorColumn = { bg = "rose" },
            CursorLine = { bg = "rose" },
            CursorLineNr = { fg = "love" },
            LineNr = { fg = "love" },
            StatusLineNC = { fg = "muted" },
            StatusLine = { fg = "muted", bg = "love" },
            NormalFloat = { bg = "base" },
            },
        })

		vim.cmd.colorscheme "rose-pine"
	end,
}
