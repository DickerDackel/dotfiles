return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
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

    keymap = {
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-\\>'] = { 'hide', 'fallback' },
      ['<C-n>'] = { 'select_next', 'show' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'select_prev' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' }, 
    },

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

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" }
}
