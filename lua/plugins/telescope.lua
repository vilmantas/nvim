return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8', 
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() 
        require("telescope").setup({
            defaults = {
                preview = {
                    treesitter = true,
                }
            }
        })
        vim.keymap.set("n", "<leader>ca", function()
            require("telescope.builtin").lsp_code_actions()
        end, { desc = "LSP Code Actions" })

    end
}
