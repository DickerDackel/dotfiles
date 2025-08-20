return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function(_, opts)
    if opts then require("luasnip").config.setup(opts) end

    vim.tbl_map(
      function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
      { "vscode", "snipmate", "lua" }
    )
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets/" } })

    require("luasnip").filetype_extend("lua", { "luadoc" })
    require("luasnip").filetype_extend("python", { "pydoc" })
    require("luasnip").filetype_extend("c", { "cdoc" })
    require("luasnip").filetype_extend("sh", { "shelldoc" })
  end,
}
