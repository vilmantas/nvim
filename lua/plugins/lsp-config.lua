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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Ruby LSP
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })

      -- Cross-platform OmniSharp path setup
      local omnisharp_cmd
      if vim.loop.os_uname().sysname == "Windows_NT" then
        -- Windows: use the .cmd launcher
        omnisharp_cmd = vim.fn.stdpath("data") .. "\\mason\\bin\\omnisharp.cmd"
      else
        -- Unix/macOS: use dotnet to run OmniSharp.dll
        omnisharp_cmd = {
          "dotnet",
          vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll",
          "--languageserver",
          "--hostPID", tostring(vim.fn.getpid()),
        }
      end

      -- OmniSharp LSP setup
      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = omnisharp_cmd,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
      })

      -- Global LSP keymaps (optional: you could scope them to `on_attach`)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}

