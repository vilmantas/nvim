local function file_with_parent()
  local filepath = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")
  local parent = vim.fn.fnamemodify(filepath, ":h:t") -- get the parent folder name
  if parent == "" then return filename end
  return parent .. "/" .. filename
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            sections = {
                lualine_c = {
                    file_with_parent
                },
            }
        })
    end
}
