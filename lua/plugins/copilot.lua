return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter", -- lazy-load on first insert
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<C-k>",
          prev = "<C-]>",
          dismiss = "<C-x>",
        },
      },
      panel = { enabled = false },
    })
  end
}
