vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

local api = require("nvim-tree.api")
local view = require("nvim-tree.view")

-- Save nvim-tree window width on resize
vim.api.nvim_create_augroup('save_nvim_tree_width', { clear = true })
vim.api.nvim_create_autocmd('WinResized', {
  group = 'save_nvim_tree_width',
  pattern = '*',
  callback = function()
    local filetree_winnr = view.get_winnr()
    if filetree_winnr and vim.tbl_contains(vim.v.event['windows'], filetree_winnr) then
      vim.t['filetree_width'] = vim.api.nvim_win_get_width(filetree_winnr)
    end
  end,
})

-- Restore nvim-tree width when reopened
api.events.subscribe(api.events.Event.TreeOpen, function()
  if vim.t['filetree_width'] ~= nil then
    view.resize(vim.t['filetree_width'])
  end

  -- Optional: minimal statusline in nvim-tree
  local winid = api.tree.winid()
  if winid then
    vim.api.nvim_set_option_value('statusline', '%t', { win = winid })
  end
end)

-- === Unified on_attach ===
local function on_attach(bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Apply default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Resize tree to fit longest visible line (max 80 cols)
  local function auto_resize_tree()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    if vim.bo[buf].filetype ~= "NvimTree" then return end

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local max_width = 0
    for _, line in ipairs(lines) do
      local width = vim.fn.strdisplaywidth(line)
      if width > max_width then max_width = width end
    end

    local padding = 4
    local new_width = math.min(80, max_width + padding)
    vim.api.nvim_win_set_width(win, new_width)
  end

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    callback = auto_resize_tree,
  })

  -- h = collapse or go to parent
  local function lefty()
    local node = api.tree.get_node_under_cursor()
    if node.nodes and node.open then
      api.node.open.edit()
    else
      api.node.navigate.parent()
    end
  end

  -- l = expand folder
  local function righty()
    local node = api.tree.get_node_under_cursor()
    if node.nodes and not node.open then
      api.node.open.edit()
    end
  end

  vim.keymap.set("n", "h", lefty, opts)
  vim.keymap.set("n", "<Left>", lefty, opts)
  vim.keymap.set("n", "l", righty, opts)
  vim.keymap.set("n", "<Right>", righty, opts)
end

-- === Final setup ===
require("nvim-tree").setup({
  on_attach = on_attach,
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
    },
  },
  actions = {
    open_file = {
      resize_window = false, -- we handle it ourselves
    },
  },
})

