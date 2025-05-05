vim.g.mapleader = " "

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.keymap.set("n", "<leader>ts", require("vilmantas.toggle_spec").toggle_spec, {
      desc = "Toggle between spec and source (engine-aware)",
      noremap = true,
      silent = true,
      buffer = true  -- only active in that buffer
    })
  end
})

