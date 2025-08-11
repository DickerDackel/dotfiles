require("config.lazy")
--
require("lazy").setup({
  require("plugins.testing.neodev"),

  require("plugins.testing.align"),
  require("plugins.testing.conform"),
  require("plugins.testing.harpoon"),
  require("plugins.testing.lualine"),
  require("plugins.testing.obsidian"),
  require("plugins.testing.snacks"),
  require("plugins.testing.tabline"),
  require("plugins.testing.tree"),
  require("plugins.testing.trouble"),
  require("plugins.testing.mini"),

  require("plugins.kickstart.blink"),
  require("plugins.kickstart.fidget"),
  require("plugins.kickstart.init"),
  require("plugins.kickstart.lazydev"),
  require("plugins.kickstart.nvim-lspconfig"),
  require("plugins.kickstart.nvim-treesitter"),
  -- require("plugins.kickstart.telescope"),
  require("plugins.kickstart.todo-comments"),
  require("plugins.kickstart.which-key"),

  require("plugins.approved.commentary"),
  require("plugins.approved.fugitive"),
  require("plugins.approved.fzf"),
  require("plugins.approved.markdown"),
  require("plugins.approved.pep8indent"),
  require("plugins.approved.startify"),
  require("plugins.approved.tagbar"),
  require("plugins.approved.ultisnips"),

  -- require("plugins.kickstart.git-signs"),

  -- install = { colorscheme = { "vividchalk"} },
  -- install = { colorscheme = { "golden"} },
  -- install = { colorscheme = { "ayu"} }, -- Fix background
})

require("lualine").setup({
    options = { theme = "ayu_dark" },
})

require("settings")
require("bindings")
require("colors")

vim.diagnostic.config({
    virtual_text = false,
    -- virtual_text = {
    -- 	virt_text_pos = "eol_right_align",
    -- },
    signs = true,
    jump = { float = true },
})

-- vim.keymap.set({'n', 'v'}, '<Leader>f', vim.lsp.buf.format, bufopts)
vim.keymap.set({'n', 'v'}, '<leader>f', function()
  vim.lsp.buf.format({ })
end , bufopts)

vim.keymap.set('n', '<leader>/', function () Snacks.terminal() end)

-- vim.lsp.set_log_level("TRACE")
