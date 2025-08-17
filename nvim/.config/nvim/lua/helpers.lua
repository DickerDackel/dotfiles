------------------------------------------------------------------------
--- Delete trailing whitespace
------------------------------------------------------------------------
_G.trim_whitespace = function ()
  local current_view = vim.fn.winsaveview()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.fn.winrestview(current_view)
end

vim.keymap.set("n", "<leader>s", trim_whitespace)
