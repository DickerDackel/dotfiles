return { "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    'fzf-vim',
    files = {
      hidden = false,  -- fzf-lua injects --hidden into finders by default!
      follow = true,  -- follow symlinks
      no_ignore = false,  -- Do not not use .gitignore

      -- NOTE: --type f will disable .gitignore.  Must be reenabled with
      -- --ignore
      fd_opts = [[--color=never --type f --type l --ignore]],
    },
    grep = {
      hidden = false,
      follow = true,
      no_ignore = false,

      fd_opts = [[--color=never]],
    },
  },
}
