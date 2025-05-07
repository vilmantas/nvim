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

local api = require("nvim-tree.api")
require"nvim-tree".setup {
    on_attach = function (bufnr)
        local opts = { buffer = bufnr }
        api.config.mappings.default_on_attach(bufnr)
        -- function for left to assign to keybindings
        local lefty = function ()
            local node_at_cursor = api.tree.get_node_under_cursor()
            -- if it's a node and it's open, close
            if node_at_cursor.nodes and node_at_cursor.open then
                api.node.open.edit()
            -- else left jumps up to parent
            else
                api.node.navigate.parent()
            end
        end
        -- function for right to assign to keybindings
        local righty = function ()
            local node_at_cursor = api.tree.get_node_under_cursor()
            -- if it's a closed node, open it
            if node_at_cursor.nodes and not node_at_cursor.open then
                api.node.open.edit()
            end
        end
        vim.keymap.set("n", "h", lefty , opts )
        vim.keymap.set("n", "<Left>", lefty , opts )
        vim.keymap.set("n", "<Right>", righty , opts )
        vim.keymap.set("n", "l", righty , opts )
    end,

    -- actions, view, etc.
}
