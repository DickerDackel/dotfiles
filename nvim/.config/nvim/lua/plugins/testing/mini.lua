return { 'echasnovski/mini.nvim', version = false,
  opts = {

  },
  config = function ()
    require('mini.ai').setup({ n_lines = 500 })
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('mini.tabline').setup()
    -- setting colors here didn't work.  See colors.lua instead
  end
}
