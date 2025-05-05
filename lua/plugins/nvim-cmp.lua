return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",    -- LSP source
        "hrsh7th/cmp-buffer",      -- buffer source
        "hrsh7th/cmp-path",        -- file path completions
        "hrsh7th/cmp-cmdline",     -- command-line completions
        "saadparwaiz1/cmp_luasnip",-- LuaSnip integration
        "L3MON4D3/LuaSnip",        -- Snippet engine
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = {
                { name = "copilot", group_index = 1 },
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "luasnip" },
            },
        })
    end
}

