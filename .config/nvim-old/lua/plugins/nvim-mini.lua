return {
  {
    "nvim-mini/mini.nvim",
    version = "*",
    config = function()
      -- 图标
      require("mini.icons").setup()

      -- 文本对齐
      require("mini.align").setup({
        mappings = {
          start = "ga",
          start_with_preview = "gA",
        },
        options = {
          split_pattern = "",
          justify_side = "left",
          merge_delimiter = "",
        },
      })
      -- 如需额外快捷键可在此处添加，例如：
      -- vim.keymap.set("x", "ga=", function()
      --   require("mini.align").operator({ split_pattern = "=", justify_side = "right" })
      -- end, { desc = "按 = 对齐" })

      
      -- 注释
      require("mini.comment").setup()

      -- 移动行/选区
      require("mini.move").setup({
        mappings = {
          left = "<M-Left>",
          right = "<M-Right>",
          down = "<M-Down>",
          up = "<M-Up>",
          line_left = "<M-Left>",
          line_right = "<M-Right>",
          line_down = "<M-Down>",
          line_up = "<M-Up>",
        },
        options = {
          reindent_linewise = true,
        },
      })

      -- 颜色高亮（如十六进制颜色值）
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color({ priority = 2000 }),
        },
      })

      -- 代码片段
      local minisnip = require("mini.snippets")
      local gen_loader = minisnip.gen_loader
      minisnip.setup({
        snippets = {
          gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
          gen_loader.from_lang(),
        },
      })
    end,
  },
}
