return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })


      local omnisharp_cmd = vim.fn.stdpath("data") .. "\\mason\\bin\\omnisharp.cmd"

      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = {
          omnisharp_cmd,
          "-z",
          "--hostPID",
          tostring(vim.fn.getpid()),
          "DotNet:enablePackageRestore=false",
          "--encoding",
          "utf-8",
          "--languageserver",
          "FormattingOptions:EnableEditorConfigSupport=true",
          "Sdk:IncludePrereleases=true",
        },
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}
