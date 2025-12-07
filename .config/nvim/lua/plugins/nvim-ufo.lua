-- lua/plugins/nvim-ufo.lua
return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  opts = {
    provider_selector = function()
      return { "lsp", "indent" }
    end,
  },
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  keys = {
    { "zR", function() require("ufo").openAllFolds() end },
    { "zM", function() require("ufo").closeAllFolds() end },
    { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end },
  },
}