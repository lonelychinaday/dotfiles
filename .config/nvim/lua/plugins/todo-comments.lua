return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local todo_comments = require("todo-comments")

    vim.keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "上一个 TODO" })

    vim.keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "下一个 TODO" })

    todo_comments.setup()
  end,
  keys = {
    { "<leader>ft", function() require("snacks").picker.todo_comments() end }
  },
}