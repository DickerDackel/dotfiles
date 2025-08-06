-- Snacks...
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
    },
  },
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
  },
}
