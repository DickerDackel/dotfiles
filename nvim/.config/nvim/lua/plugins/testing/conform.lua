return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      -- python = { "ruff", "ruff_organize_imports", "ruff_format" },
      python = { "isort", "yapf" },
      lua = { "stylua" },
    },
    format_on_save = function(bufnr) return nil end,
    -- keys = {
    --   {
	-- "<leader>f",
	-- function()
	  -- require("conform").format({ async = true, lsp_format = "fallback" })
	-- end,
	-- mode = "",
	-- desc = "[F]ormat buffer",
    --   },
    -- },
  },
}
