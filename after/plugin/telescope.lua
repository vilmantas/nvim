local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Telescope live grep" }) 
vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = "Telescope old files" }) 


local function grep_visual_selection()
  local text = vim.fn.getreg("v")
  builtin.live_grep({ default_text = text })
end


vim.keymap.set("v", "<leader>ps", function()
  -- Yank visual selection to register v
  vim.cmd('normal! "vy')
  grep_visual_selection()
end, { noremap = true, silent = true })


