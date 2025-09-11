require("config.lazy")
vim.cmd("colorscheme golden")
--
require("lazy").setup({
  require("plugins.testing.neodev"),

  require("plugins.testing.align"),
  require("plugins.testing.conform"),
  require("plugins.testing.harpoon"),
  require("plugins.testing.luasnip"),
  require("plugins.testing.obsidian"),
  require("plugins.testing.snacks"),
  require("plugins.testing.trouble"),
  require("plugins.testing.gruvbox"),

  require("plugins.kickstart.lazydev"),
  require("plugins.kickstart.todo-comments"),

  require("plugins.approved.blink"),
  require("plugins.approved.fzf"),
  require("plugins.approved.lualine"),
  require("plugins.approved.markdown"),
  require("plugins.approved.nvim-lspconfig"),
  require("plugins.approved.nvim-treesitter"),
  require("plugins.approved.oil"),
  require("plugins.approved.pep8indent"),
  require("plugins.approved.startify"),
  require("plugins.approved.tree"),
  require("plugins.approved.which-key"),

  -- require("plugins.kickstart.git-signs"),
  --
  -- require("plugins.retire.commentary"),
  -- require("plugins.retire.fugitive"),
  -- require("plugins.retire.tagbar"),
  -- require("plugins.retire.ultisnips"),

  -- install = { colorscheme = { "vividchalk"} },
  install = { colorscheme = { "golden"} },
  -- install = { colorscheme = { "ayu"} }, -- Fix background
})

require("lualine").setup({
    options = { theme = "ayu_dark" },
})

require("helpers")
require("config.settings")
require("config.bindings")

-- vim.cmd("colorscheme vividchalk")
vim.cmd("colorscheme golden")
-- vim.cmd("colorscheme ayu")
require("config.colors")  -- patch colors afterselecting a theme

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
vim.keymap.set('n', '<leader>v', function () FzfLua.files({cwd = '~/.config/nvim' }) end)

-- vim.lsp.set_log_level("TRACE")
