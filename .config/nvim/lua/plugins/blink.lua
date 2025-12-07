return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    -- "Exafunction/codeium.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "VeryLazy",
  opts = {
    -- 外观配置
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    -- 补全行为配置
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
        },
        border = "single",
        auto_show = true,
        auto_show_delay_ms = 0,
        scrollbar = false,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        treesitter_highlighting = false,
        window = {
          border = "single",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
          scrollbar = false,
        },
      },
    },
    -- 快捷键配置
    keymap = {
      preset = "none", -- 完全自定义
      ["<Tab>"] = { "accept", "fallback" }, -- Tab 接受补全
      ["<C-k>"] = { "select_prev", "fallback" }, -- 上一项
      ["<C-j>"] = { "select_next", "fallback" }, -- 下一项
      ["<C-h>"] = {
        function(cmp)
          local max_height = require("blink.cmp.config").completion.menu.max_height or 10
          return cmp.select_prev({ count = max_height })
        end,
        "fallback",
      }, -- 补全列表上一页
      ["<C-l>"] = {
        function(cmp)
          local max_height = require("blink.cmp.config").completion.menu.max_height or 10
          return cmp.select_next({ count = max_height })
        end,
        "fallback",
      }, -- 补全列表下一页
      ["<C-b>"] = { "scroll_documentation_up", "fallback" }, -- 文档向上滚动
      ["<C-f>"] = { "scroll_documentation_down", "fallback" }, -- 文档向下滚动
      ["<CR>"] = { "cancel", "fallback" }, -- Enter 取消补全并恢复原始文本
      ["<C-Space>"] = { "show", "fallback" }, -- 手动触发补全
    },

    -- 源配置
    sources = {
      default = {
        "lsp", -- LSP 补全（对应 nvim-cmp 的 nvim_lsp）
        -- "codeium", -- Codeium AI 补全（对应 nvim-cmp 的 codeium）
        "path", -- 路径补全
        "snippets", -- 代码片段补全
        "buffer", -- 缓冲区补全
      },
      providers = {
        -- codeium = {
        --   name = "Codeium",
        --   module = "codeium.blink", -- 使用 codeium.nvim 自带的 blink 模块
        --   score_offset = 20, -- 降低排序优先级，排在 LSP 之后
        --   async = true,
        --   transform_items = function(_, items)
        --     for _, item in ipairs(items) do
        --       item.kind_icon = "" -- Codeium 专属图标
        --       item.kind_hl = "BlinkCmpKindCodeium"
        --     end
        --     return items
        --   end,
        -- },
      },
    },

    -- 命令行补全配置
    cmdline = {
      sources = function()
        local cmd_type = vim.fn.getcmdtype()
        if cmd_type == "/" then
          return { "buffer" }
        end
        if cmd_type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
      keymap = {
        ["<Tab>"] = { "accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
  },
}
