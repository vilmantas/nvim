local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Telescope live grep" }) 
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Telescope buffers" })

vim.keymap.set('n', '<leader><leader>', function()
  require("telescope.builtin").oldfiles({ only_cwd = true, cwd = vim.fn.getcwd() })
end, { desc = "Telescope old files" })


local function grep_visual_selection()
    -- Yank current selection into register v
    vim.cmd('normal! "vy')

    -- Get the content and sanitize
    local text = vim.fn.getreg("v"):gsub("\n", ""):gsub("^%s+", ""):gsub("%s+$", "")

    -- Only search if there's something meaningful
    if text ~= "" then
        require("telescope.builtin").live_grep({ default_text = text })
    else
        print("No valid selection")
    end
end


vim.keymap.set("v", "<leader>ps", function()
    -- Yank visual selection to register v
    vim.cmd('normal! "vy')
    grep_visual_selection()
end, { noremap = true, silent = true })


