vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

require("nvim-tree").setup({
    actions = {
        open_file = {
            resize_window = false,
        },
    },
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
            "^.git$",
        }
    },
})

local nt_api = require'nvim-tree.api'

nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
    local tree_winid = nt_api.tree.winid()

    if tree_winid ~= nil then
        vim.api.nvim_set_option_value('statusline', '%t', {win = tree_winid})
    end
end)

local view = require('nvim-tree.view')
local api = require('nvim-tree.api')
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- save nvim-tree window width on WinResized event
augroup('save_nvim_tree_width', { clear = true })
autocmd('WinResized', {
  group = 'save_nvim_tree_width',
  pattern = '*',
  callback = function()
    local filetree_winnr = view.get_winnr()
    if filetree_winnr ~= nil and vim.tbl_contains(vim.v.event['windows'], filetree_winnr) then
      vim.t['filetree_width'] = vim.api.nvim_win_get_width(filetree_winnr)
    end
  end,
})

-- restore window size when openning nvim-tree
api.events.subscribe(api.events.Event.TreeOpen, function()
  if vim.t['filetree_width'] ~= nil then
    view.resize(vim.t['filetree_width'])
  end
end)
