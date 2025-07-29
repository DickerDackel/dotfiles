require("config.lazy")
require("settings")
require("bindings")
require("colors")
require("questionable_kickstart_configs")

-- Don't use automatic includes.  I want control and sometimes keep config
-- files in the directory because I might re-enable them.
require("lazy").setup({
	require("plugins.kickstart.autoformat"),
	require("plugins.kickstart.blink"),
	require("plugins.kickstart.git-signs"),
	require("plugins.kickstart.init"),
	require("plugins.kickstart.lazydev"),
	require("plugins.kickstart.mini"),
	require("plugins.kickstart.nvim-lspconfig"),
	require("plugins.kickstart.nvim-treesitter"),
	require("plugins.kickstart.telescope"),
	require("plugins.kickstart.todo-comments"),
	require("plugins.kickstart.which-key"),

	require("plugins.approved.startify"),
	require("plugins.approved.fzf"),
	require("plugins.approved.ultisnips"),
	require("plugins.approved.commentary"),
	require("plugins.approved.fugitive"),
	require("plugins.approved.tagbar"),
	require("plugins.approved.pep8indent"),
	require("plugins.approved.markdown"),

	require("plugins.testing.neodev"),
	require("plugins.testing.harpoon"),
	require("plugins.testing.lualine"),

	install = { colorscheme = { "vividchalk", "habamax" } },
})

require("lualine").setup({
	options = { theme = "ayu_dark" },
})
