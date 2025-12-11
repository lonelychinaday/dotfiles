-- 高亮光标下的相同单词
-- 将光标移动到变量/函数名上，会自动高亮所有相同的引用

local color = require("utils.colors")

return {
  "RRethy/vim-illuminate",
  event = "BufReadPost",
  opts = {
    delay = 100,
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
    filetypes_denylist = {
      "dirbuf",
      "dirvish",
      "fugitive",
      "NvimTree",
      "snacks_dashboard",
    },
    min_count_to_highlight = 1,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { underdouble = true, sp = color.get("accent_purple_deep") })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underdouble = true, sp = color.get("accent_purple_deep") })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underdouble = true, sp = color.get("accent_purple_deep") })
  end,
  keys = {
    { "]]", function() require("illuminate").goto_next_reference(false) end },
    { "[[", function() require("illuminate").goto_prev_reference(false) end },
  },
}