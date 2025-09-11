return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      before = "",
      after="",
      keyword="bg",
      pattern = [[<(KEYWORDS)>]],
    },
    search = { pattern = [[\b(KEYWORDS)\b]], },
  }
}
