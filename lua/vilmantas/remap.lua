vim.g.mapleader = " "

vim.keymap.set("n", "<leader><Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<leader><Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<leader><Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<leader><Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.keymap.set("n", "<leader>ts", require("vilmantas.custom.toggle_spec").toggle_spec, {
      desc = "Toggle between spec and source (engine-aware)",
      noremap = true,
      silent = true,
      buffer = true  -- only active in that buffer
    })
  end
})

