local util = require("lspconfig.util")

require("lspconfig").ruby_lsp.setup({
  root_dir = function(fname)
    -- Search upwards for a directory with both Gemfile and Gemfile.lock
    return util.search_ancestors(fname, function(path)
      local gemfile = util.path.join(path, "Gemfile")
      local lockfile = util.path.join(path, "Gemfile.lock")
      if util.path.is_file(gemfile) and util.path.is_file(lockfile) then
        return path
      end
    end)
  end,
})

