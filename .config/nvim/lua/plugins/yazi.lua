return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>y",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      "<leader>Y",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = true,
    floating_window_scaling_factor = 1.0,
    yazi_floating_window_border = "rounded", -- Options: "none", "single", "double", "rounded", "solid", "shadow"
    keymaps = {
      show_help = "<f1>",
    },
    hooks = {
      yazi_opened = function(preselected_path, yazi_buffer_id, config)
        -- YaziFloatBorder: 边框颜色
        -- YaziFloatNormal: 窗口主体背景色
        vim.api.nvim_set_hl(0, "YaziFloatBorder", { bg = "#1F1F1F" })
        vim.api.nvim_set_hl(0, "YaziFloatNormal", { bg = "#1F1F1F" })

        local win = vim.fn.bufwinid(yazi_buffer_id)
        if win ~= -1 then
          vim.api.nvim_win_set_option(win, "winhl", "Normal:YaziFloatNormal,FloatBorder:YaziFloatBorder")
        end
      end,
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
