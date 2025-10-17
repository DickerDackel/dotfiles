return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',
  },

  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = { nerd_font_variant = 'mono' },

    completion = {
      list = {
        selection = { preselect = false, auto_insert = false },
        max_items = 10,
      },
      -- ML: enabling this is fucking annoying.  It puts () behind a completed function.
      accept = { auto_brackets = { enabled = false } },
      documentation = { auto_show = false },
      ghost_text = {
        enabled = true,
        show_without_selection = true,
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- ML This will kill digraphs
    keymap = { preset = 'super-tab' },
    -- ML This is a copy of super-tab without C-k

    --ML keymap = {
    --ML   ['<CR>'] = { 'accept', 'fallback' },
    --ML   ['<C-\\>'] = { 'hide', 'fallback' },
    --ML   ['<C-n>'] = { 'select_next', 'show' },
    --ML   ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    --ML   ['<C-p>'] = { 'select_prev' },
    --ML   ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    --ML   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    --ML   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    --ML },

    -- ML: I like these...
    signature = {
      enabled = true,
      window = {
        -- direction_priority = { 's', 'n' },
        direction_priority = { 's' },
        border = "rounded",
        treesitter_highlighting = true,
        show_documentation = false,
      },
    },

    snippets = { preset = "luasnip" },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" }
}
