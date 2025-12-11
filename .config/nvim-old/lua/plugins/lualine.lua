-- 状态栏

-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

-- lualine_a
-- lualine_b
-- lualine_c
-- lualine_x
-- lualine_y
-- lualine_z

local colors = require("utils.colors")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto", -- onelight, auto
      component_separators = { left = "", right = "" }, -- 分隔符
      section_separators = { left = "", right = "" }, -- 分隔符
      disabled_filetypes = { "NvimTree" },
    },
    extensions = { "nvim-tree" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        -- "diff",
      },
      lualine_c = {
        {
          "filename",
          file_status = false,
          newfile_status = false,
          -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          path = 3,
          shorting_target = 40,
          symbols = {
            modified = "[+]",
            readonly = "[-]",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
        "searchcount",
      },
      lualine_x = {
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { { "datetime", style = "%Y/%m/%d %H:%M:%S" } },
    },
    -- winbar = {
    --   lualine_a = {
    --     {
    --       "filename",
    --       color = {
    --         bg = colors.get("surface_base"),
    --         fg = colors.get("neutral_muted"),
    --         gui = "italic",
    --       },
    --       file_status = false,
    --       newfile_status = false,
    --       path = 2,
    --       shorting_target = 40,
    --     },
    --     {
    --       "diagnostics",
    --       sources = { 'nvim_diagnostic' },
    --       symbols = { error = "E", warn = "W", info = "I", hint = "H" },
    --       colored = true,
    --       color = {
    --         bg = colors.get("surface_base"),
    --         gui = "italic",
    --       },
    --     },
    --   },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
  },
}
