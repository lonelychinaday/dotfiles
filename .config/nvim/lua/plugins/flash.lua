return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  keys = {
    -- 快速跳转到任意位置
    { "<leader>h", mode = { "n", "x", "o" }, function() require("flash").jump() end },
    -- -- 使用 Treesitter 进行智能跳转（基于语法树）
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
    -- -- 远程操作：在 operator-pending 模式下跳转到远程位置
    -- { "r", mode = "o", function() require("flash").remote() end },
    -- -- 使用 Treesitter 进行搜索选择
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end },
    -- -- 在命令行模式下切换 Flash 搜索
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end },
  },
}