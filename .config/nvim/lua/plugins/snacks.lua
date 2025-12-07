-- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = {},
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = "", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = "", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { icon = "", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      },
    },
    explorer = { enabled = true, replace_netrw = true, trash = true },
    lazygit = { enabled = true, configure = true, win = {
      style = "lazygit",
    } },
    indent = {
      enabled = true,
      only_scope = false,
      only_current = false,
      indent = {
        hl = {
          "SnacksIndentLevel1",
          "SnacksIndentLevel2",
          "SnacksIndentLevel3",
          "SnacksIndentLevel4",
          "SnacksIndentLevel5",
          "SnacksIndentLevel6",
          "SnacksIndentLevel7",
          "SnacksIndentLevel8",
        },
      },
      scope = {
        hl = "SnacksIndentScope",
      },
    },
    input = {
      enabled = true,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    notifier = {
      enabled = true,
      timeout = 5000,
      width = { min = 30, max = 0.6 },
    },
    picker = {
      enabled = true,
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = true, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      sources = {
        explorer = {
          finder = "explorer",
          supports_live = true,
          ui_select = true,
          tree = true,
          watch = true,
          auto_close = true,
          layout = {
            preset = "vertical", -- sidebar vertical vscode select ivy
            preview = false,
          },
          matcher = { sort_empty = false, fuzzy = true },
          win = {
            list = {
              keys = {
                ["<BS>"] = "explorer_up", -- back to parent directory

                ["h"] = "explorer_close", -- close directory
                ["l"] = "confirm", -- confirm selection

                ["a"] = "explorer_add", -- add new file
                ["d"] = "explorer_del", -- delete file
                ["r"] = "explorer_rename", -- rename file

                ["y"] = { "explorer_yank", mode = { "n", "x" } }, -- yank file
                ["p"] = "explorer_paste", -- paste file
                ["c"] = "explorer_copy", -- copy file
                ["m"] = "explorer_move", -- move file

                ["o"] = "explorer_open", -- open with system application
                ["P"] = "toggle_preview",

                ["Z"] = "explorer_close_all", -- fold all directories

                ["<c-c>"] = "tcd",

                ["u"] = "explorer_update",

                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["]g"] = "explorer_git_next",
                ["[g"] = "explorer_git_prev",
                ["]d"] = "explorer_diagnostic_next",
                ["[d"] = "explorer_diagnostic_prev",
                ["]w"] = "explorer_warn_next",
                ["[w"] = "explorer_warn_prev",
                ["]e"] = "explorer_error_next",
                ["[e"] = "explorer_error_prev",
              },
            },
          },
        },
      },
      debug = {
        scores = false,
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true, priority = 200, underline = true, only_current = false },
    scroll = { enabled = true },
    terminal = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },

    -- Zen 模式
    zen = {
      enabled = true,
      toggle = {
        dim = { -- 聚焦当前活动区域，调暗其他区域
          enabled = true,
          scope = {
            min_size = 5,
            max_size = 20,
            siblings = true,
          },
          animate = {
            enabled = vim.fn.has("nvim-0.10") == 1,
            easing = "outQuad",
            duration = {
              step = 20, -- ms per step
              total = 300, -- maximum duration
            },
          },
          filter = function()
            -- return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
            return false
          end,
        },
      },
    },

    styles = {
      notification = {
        wo = { wrap = true },
      },
      terminal = {
        keys = {
          term_normal = {
            "<esc>",
            function(self)
              ---@diagnostic disable-next-line: undefined-field
              self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
              if self.esc_timer:is_active() then
                self.esc_timer:stop()
                vim.cmd("stopinsert")
              else
                self.esc_timer:start(200, 0, function() end)
                return "<esc>"
              end
            end,
            mode = "t",
            expr = true,
          },
        },
      },
    },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)

    -- LSP progress
    vim.api.nvim_create_autocmd("LspProgress", {
      group = vim.api.nvim_create_augroup("SnacksLspProgress", { clear = true }),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
          return
        end
        local value = ev.data.params.value
        if type(value) ~= "table" or value.kind ~= "end" then
          return
        end

        local title = value.title or client.name
        local message = value.message or ""

        snacks.notifier.notify(
          string.format("%s", message ~= "" and message or (title .. " ")),
          vim.log.levels.INFO,
          {
            id = "lsp_progress_" .. client.id,
            title = client.name,
            timeout = 5000,
            icon = " ",
          }
        )
      end,
    })

    -- Save file notify
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("SnacksSaveNotify", { clear = true }),
      callback = function(ev)
        if ev.match == "" then
          return
        end
        snacks.notifier.notify(
          string.format("保存成功：%s", vim.fn.fnamemodify(ev.match, ":~")),
          vim.log.levels.INFO,
          {
            title = "文件已保存",
            icon = " ",
            timeout = 3000,
          }
        )
      end,
    })
  end,
  keys = {
    -- Picker
    {
      "<leader>fp",
      function()
        require("snacks").picker.projects()
      end,
    },
    {
      "<leader>ff",
      function()
        require("snacks").picker.files()
      end,
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.recent()
      end,
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers({
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
        })
      end,
    },
    {
      "<leader>fh",
      function()
        require("snacks").picker.highlights()
      end,
    },
    {
      "<leader>fl",
      function()
        require("snacks").picker.lsp_symbols()
      end,
    },
    {
      "<leader>fd",
      function()
        require("snacks").picker.diagnostics_buffer()
      end,
    },
    {
      "<leader>fa",
      function()
        require("snacks").picker.autocmds()
      end,
    },
    {
      "<leader>fk",
      function()
        require("snacks").picker.keymaps()
      end,
    },
    {
      "<leader>fc",
      function()
        require("snacks").picker.command_history()
      end,
    },
    {
      "<leader>fn",
      function()
        require("snacks").picker.notifications()
      end,
    },
    {
      "<leader>fs",
      function()
        require("snacks").picker.grep({
          -- exclude = { "dictionaries/words.txt" },
        })
      end,
    },

    {
      "<leader>gg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Lazygit",
    },

    {
      "<leader>ep",
      function()
        require("snacks").explorer()
      end,
    },
    {
      "<leader>uc",
      function()
        require("snacks").picker.colorschemes()
      end,
    },
    {
      "<leader>rf",
      function()
        require("snacks").rename.rename_file()
      end,
    },
    {
      "<leader>z",
      function()
        require("snacks").zen()
      end,
    },
    {
      "<c-`>",
      function()
        require("snacks").terminal.toggle()
      end,
    },

    {
      "<leader>N",
      desc = "Neovim News",
      function()
        require("snacks").win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
}
