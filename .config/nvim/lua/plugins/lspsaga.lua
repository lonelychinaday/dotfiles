return {
  "nvimdev/lspsaga.nvim",
  cmd = "Lspsaga",
  event = { "BufReadPre", "BufNewFile", "LspAttach" },
  opts = {
    finder = {
      keys = {
        toggle_or_open = "<CR>",
      },
    },
    ui = {
      code_action = "󰚑 ",
    },
    symbol_in_winbar = {
      enable = false,
      separator = " › ",
      hide_keyword = false,
      show_file = true,
    },
  },
  keys = {
    { "<leader>lc", ":Lspsaga code_action<CR>" },
    { "<leader>lR", ":Lspsaga finder<CR>" },
    { "<leader>lo", ":Lspsaga outline<CR>" },

    { "K", ":Lspsaga hover_doc<CR>" },
    { "gd", ":Lspsaga goto_definition<CR>" },
    { "[d", ":Lspsaga diagnostic_jump_prev<CR>" },
    { "]d", ":Lspsaga diagnostic_jump_next<CR>" },
  },
}
