vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local lspconfig_util = require("lspconfig.util")
    local fname = vim.api.nvim_buf_get_name(args.buf)
    local root = lspconfig_util.root_pattern("Gemfile", ".git")(fname)

    if root and root ~= vim.fn.getcwd() then
      vim.cmd("lcd " .. root)
    end
  end,
})

