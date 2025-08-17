return { -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        -- map('grr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
        -- map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
        -- map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
        -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')
        -- map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- -- The following two autocommands are used to highlight references of the
        -- -- word under your cursor when your cursor rests there for a little while.
        -- --    See `:help CursorHold` for information about when this is executed
        -- --
        -- -- When you move your cursor, the highlights will be cleared (the second autocommand).
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        --   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        --     buffer = event.buf,
        --     group = highlight_augroup,
        --     callback = vim.lsp.buf.document_highlight,
        --   })
        --
        --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        --     buffer = event.buf,
        --     group = highlight_augroup,
        --     callback = vim.lsp.buf.clear_references,
        --   })
        --
        --   vim.api.nvim_create_autocmd('LspDetach', {
        --     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        --     callback = function(event2)
        --       vim.lsp.buf.clear_references()
        --       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        --     end,
        --   })
        -- end
        --
        -- -- The following code creates a keymap to toggle inlay hints in your
        -- -- code, if the language server you are using supports them
        -- --
        -- -- This may be unwanted, since they displace some of your code
        -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        --   map('<leader>th', function()
        --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        --   end, '[T]oggle Inlay [H]ints')
        -- end
      end,
    })

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      clangd = {},
      -- basedpyright = { },
      -- jedi_language_server = {},
      -- ty = {},
      ruff = { },
      pylsp = {
	pylsp = {
	  configurationSources = {'pycodestyle'},
	  rope = {
	    extensionModules = null,  -- string = null - Builtin and c-extension modules that are allowed to be imported and inspected by rope.
	    ropeFolder = null,  -- array of unique string items = null - The name of the folder in which rope stores project configurations and data. Pass null for not using such a folder at all.
	  },
	  signature = {
	    formatter = "black",  -- string (one of: 'black', 'ruff', None) = "black" - Formatter to use for reformatting signatures in docstrings.
	    line_length = 88,  -- number = 88 - Maximum line length in signatures.
	  },
	  plugins = {
	    -- autopep8 = { enabled = false }, -- [true] - Enable or disable the plugin (disabling required to use yapf).
	    flake8 = {
	      enabled = false,  -- bool = false - Enable or disable the plugin.

	      config = null,  -- str = null - Path to the config file that will be the authoritative config source.
	      exclude = {},   -- list[str] - List of files or directories to exclude.
	      executable = "flake8",  -- str = "flake8" - Path to the flake8 executable.
	      extendIgnore = {},  -- list[str] = [] - List of errors and warnings to append to ignore list.
	      extendSelect = {},  -- list[str] = [] - List of errors and warnings to append to select list.
	      filename = null,  -- str = null - Only check for filenames matching the patterns in this list.
	      hangClosing = null,  -- bool = null - Hang closing bracket instead of matching indentation of opening bracket's line.
	      ignore = {},  -- list[str] = [] - List of errors and warnings to ignore (or skip).
	      indentSize = null,  -- int = null - Set indentation spaces.
	      maxComplexity = null,  -- int = null - Maximum allowed complexity threshold.
	      maxLineLength= null,  -- int = null - Maximum allowed line length for the entirety of this run.
	      perFileIgnores = {},  -- list[str] = [] - A pairing of filenames and violation codes that defines which violations to ignore in a particular file, for example: ["file_path.py:W305,W304"]).
	      select = {},  -- list[str] = null - List of errors and warnings to enable.
	    },
	    jedi8 = {
	      jedi = {
		auto_import_modules = {"numpy"},  -- array of string items = ["numpy"] - List of module names for jedi.settings.auto_import_modules.
		extra_paths = {},  -- array of string items = [] - Define extra paths for jedi.Script.
		prioritize_extra_paths = false,  -- boolean = false - Whether to place extra_paths at the beginning (true) or end (false) of sys.path
		env_vars = null,  -- object = null - Define environment variables for jedi.Script and Jedi.names.
		environment = null,  -- string = null - Define environment for jedi.Script and Jedi.names.
	      },
	      jedi_completion = {
		enabled = true,  -- boolean = true - Enable or disable the plugin.
		include_params = true,  -- boolean = true - Auto-completes methods and classes with tabstops for each parameter.
		include_class_objects = false,  -- boolean = false - Adds class objects as a separate completion item.
		include_function_objects = false,  -- boolean = false - Adds function objects as a separate completion item.
		fuzzy = false,  -- boolean = false - Enable fuzzy when requesting autocomp
		eager = false,  -- boolean = false - Resolve documentation and detail eagerly.
		resolve_at_most = 25,  -- integer = 25 - How many labels and snippets (at most) should be resolved?
		cache_for = {"pandas", "numpy", "tensorflow", "matplotlib"},  -- array of string items = ["pandas", "numpy", "tensorflow", "matplotlib"] - Modules for which labels and snippets should be cached.
		enabled = true,  -- boolean = true - Enable or disable the plugin.
		follow_imports = true,  -- boolean = true - The goto call will follow imports.
		follow_builtin_imports = true,  -- boolean = true - If follow_imports is True will decide if it follow builtin imports.
		follow_builtin_definitions = true,  -- boolean = true - Follow builtin and extension definitions to stubs.
	      },
	      jedi_hover = { enabled = true },  -- boolean = true - Enable or disable the plugin.
	      jedi_references = { enabled = true },  -- boolean = true - Enable or disable the plugin.
	      jedi_signature_help = { enabled = true },  -- boolean = true - Enable or disable the plugin.
	      jedi_symbols = {
		enabled = true,  -- boolean = true - Enable or disable the plugin.
		all_scopes = true,  -- boolean = true - If True lists the names of all scopes instead of only the module namespace.
		include_import_symbols = true,  -- boolean = true - If True includes symbols imported from other libraries.
	      },
	      jedi_type_definition = { enabled = true },  -- boolean = true - Enable or disable the plugin.
	    },
	    mccabe = {
	      enabled = true,  -- boolean = true - Enable or disable the plugin.
	      threshold = 15,  -- integer = 15 - The minimum threshold that triggers warnings about cyclomatic complexity.
	    },

	    jedi_completion = { enabled = true },
	    preload = {
	      enabled = true,  -- boolean = true - Enable or disable the plugin.
	      modules = {},  -- array of unique string items = [] - List of modules to import on startup
	    },
	    pycodestyle = {
	      enabled = true,  -- boolean = true - Enable or disable the plugin.

	      addIgnore = {'W391'},  -- array of unique string items = [] - Ignore errors and warnings in addition to the specified convention.
	      addSelect = {},  -- array of unique string items = [] - Select errors and warnings in addition to the specified convention.
	      convention = null,  -- string (one of: 'pep257', 'numpy', 'google', None) = null - Choose the basic list of checked errors by specifying an existing convention.
	      enabled = false,  -- boolean = false - Enable or disable the plugin.
	      exclude = {},  -- array of unique string items = [] - Exclude files or directories which match these patterns.
	      filename = {},  -- array of unique string items = [] - When parsing directories, only check filenames matching these patterns.
	      hangClosing = null,  -- boolean = null - Hang closing bracket instead of matching indentation of opening bracket's line.
	      ignore = {},  -- array of unique string items = [] - Ignore errors and warnings
	      indentSize = null,  -- integer = null - Set indentation spaces.
	      match = "(?!test_).*\\.py",  -- string = "(?!test_).*\\.py" - Check only files that exactly match the given regular expression; default is to match files that don't start with 'test_' but end with '.py'.
	      matchDir = "[^\\.].*",  -- string = "[^\\.].*" - Search only dirs that exactly match the given regular expression; default is to match dirs which do not begin with a dot.
	      maxLineLength = 100,  -- integer = null - Set maximum allowed line length.
	      select = null,  -- array of unique string items = null - Select errors and warnings
	    },
	    pyflakes = { enabled = true },  -- boolean = true - Enable or disable the plugin.
	    pylint = {
	      enabled = false,  -- boolean = false - Enable or disable the plugin.
	      args = {},  -- array of non-unique string items = [] - Arguments to pass to pylint.
	      executable = null,  -- string = null - Executable to run pylint with. Enabling this will run pylint on unsaved files via stdin. Can slow down workflow. Only works with python3.
	    },
	    rope = {
	      rope_autoimport = {
		enabled = false,  -- boolean = false - Enable or disable autoimport. If false, neither completions nor code actions are enabled. If true, the respective features can be enabled or disabled individually.
		completions = { enabled = true },  -- boolean = true - Enable or disable autoimport completions.
		code_actions = { enabled = true },  -- boolean = true - Enable or disable autoimport code actions (e.g. for quick fixes).
		memory = false,  -- boolean = false - Make the autoimport database memory only. Drastically increases startup time.
		enabled = false,  -- boolean = false - Enable or disable the plugin.
		eager = false,  -- boolean = false - Resolve documentation and detail eagerly.
	      }
	    },
	    yapf = { enabled = true },  -- boolean = true - Enable or disable the plugin.
	  }
	}
      },
      lua_ls = {
        -- cmd = { ... },
        -- filetypes = { ... },
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
