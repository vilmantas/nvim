local M = {}

M.toggle_spec = function()
  if vim.bo.filetype ~= "ruby" then
    print("Not a Ruby file — skipping toggle.")
    return
  end

  local path = vim.api.nvim_buf_get_name(0)
  local target = nil

  if path:find("/spec/") then
    target = path
      :gsub("(/[^/]+/)spec/", "%1app/")
      :gsub("_spec%.rb$", ".rb")
    if not vim.loop.fs_stat(target) then
      target = path
        :gsub("(/[^/]+/)spec/", "%1lib/")
        :gsub("_spec%.rb$", ".rb")
    end
  else
    if path:find("/app/") then
      target = path
        :gsub("(/[^/]+/)app/", "%1spec/")
        :gsub("%.rb$", "_spec.rb")
    elseif path:find("/lib/") then
      target = path
        :gsub("(/[^/]+/)lib/", "%1spec/lib/")
        :gsub("%.rb$", "_spec.rb")
    end
  end

  if target then
    if not vim.loop.fs_stat(target) then
      -- Auto-create the file and any missing directories
      local uv = vim.loop
      local dir = target:match("(.*/)")
      if dir then
        uv.fs_mkdir(dir, 493, function() end) -- 0755
      end
      local fd = io.open(target, "w")
      if fd then
        fd:write("") -- empty file
        fd:close()
        print("📄 Created: " .. target)
      else
        print("❌ Failed to create file: " .. target)
        return
      end
    end
    vim.cmd("edit " .. target)
  else
    print("❌ Could not determine target file.")
  end
end

return M

