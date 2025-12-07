return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    filters = {
      dotfiles = true,
    },
    view = {
      adaptive_size = true,
    },
  },
  keys = {
    {
      "<leader>ef",
      function()
        local view = require("nvim-tree.view")
        if view.is_visible() then
          -- 如果文件树可见，检查当前是否在文件树窗口
          local current_win = vim.api.nvim_get_current_win()
          local tree_win = view.get_winnr()

          if current_win == tree_win then
            -- 当前在文件树，跳回上一个编辑窗口
            vim.cmd("wincmd p")
          else
            -- 当前不在文件树，聚焦到文件树
            vim.cmd("NvimTreeFocus")
          end
        else
          -- 文件树不可见，打开并聚焦
          vim.cmd("NvimTreeFocus")
        end
      end,
    },
    { "<leader>ee", ":NvimTreeToggle<CR>" },
  },
}

