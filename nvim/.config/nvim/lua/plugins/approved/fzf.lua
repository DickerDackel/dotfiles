-- fzf fuzzy finder
-- return { 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } }
return { "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {
    'fzf-vim',
    files = {
      hidden = false,  -- fzf-lua injects --hidden into finders by default!
      follow = true,  -- follow symlinks
      no_ignore = false,  -- Do not not use .gitignore

      -- cmd = "~/.local/bin/fdwrapper",
      fd_opts = [[--color=never]],
      -- cmd = "fd --color=never --type f --type l --ignore --follow",
      -- fd_opts = [[--color=never --type f --type l --ignore]],
    },
    grep = {
      hidden = false,  -- fzf-lua injects --hidden into finders by default!
      follow = true,  -- follow symlinks
      no_ignore = false,  -- Do not not use .gitignore

      -- cmd = "~/.local/bin/fdwrapper",
      fd_opts = [[--color=never]],
      -- cmd = "fd --color=never --type f --type l --ignore --follow",
      -- fd_opts = [[--color=never --type f --type l --ignore]],
    },
  },
}
