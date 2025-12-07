-- Git 状态显示和操作插件
-- 在行号旁显示 Git 变更状态，支持暂存、撤销、预览等操作

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true, -- 在行号列显示 Git 标记
    numhl = false, -- 高亮行号
    linehl = false, -- 高亮整行
    word_diff = false, -- 单词级别的 diff
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = true, -- 当前行显示 blame 信息
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
      delay = 300,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> · <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end)

    end,
  },
}
