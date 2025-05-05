vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

require("nvim-tree").setup({
  view = {
    width = 40,
    side = "left",
    number = false,
    relativenumber = false,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = {
            "%.uid",
            "%.import",
            ".git",
        }
  },
})

