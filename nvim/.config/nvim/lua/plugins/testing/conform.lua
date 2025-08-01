return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = {
	notify_on_error = false,
	formatters_by_ft = {
	    lua = { "stylua" },
	    -- python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
	    -- python = { "autopep8" },
	    -- python = { "blue" },
	    -- python = { "pyink" },
	},
	format_on_save = function(bufnr) return nil end,
	keys = {
	    {
		"<leader>f",
		function()
		    require("conform").format({ async = true, lsp_format = "fallback" })
		end,
		mode = "",
		desc = "[F]ormat buffer",
	    },
	},
    },
}
