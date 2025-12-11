-- which-key 插件配置模块

---@class WhichKeyKeyDef 描述 which-key 键位提示的数据结构
---@field label string? 分组说明，仅用于提高可读性
---@field mappings table[] 交由 which-key 注册的按键描述列表

local KEY_GROUPS = {
  {
    label = "[] 系列: 导航",
    mappings = {
      { "[B", desc = "第一个缓冲区" },
      { "[b", desc = "上一个缓冲区" },
      { "]b", desc = "下一个缓冲区" },
      { "]B", desc = "最后一个缓冲区" },

      { "[D", desc = "第一个诊断" },
      { "[d", desc = "上一个诊断(lspsaga)" },
      { "]d", desc = "下一个诊断(lspsaga)" },
      { "]D", desc = "最后一个诊断" },

      { "[q", desc = "上一个 quickfix" },
      { "]q", desc = "下一个 quickfix" },
      { "[Q", desc = "第一个 quickfix" },
      { "]Q", desc = "最后一个 quickfix" },

      { "[t", desc = "上一个TODO(todo-comments)", icon = { icon = "", color = "green" } },
      { "]t", desc = "下一个TODO(todo-comments)", icon = { icon = "", color = "green" } },

      { "[(", desc = "上一个未匹配的 (" },
      { "])", desc = "下一个未匹配的 )" },
      { "[{", desc = "上一个未匹配的 {" },
      { "]}", desc = "下一个未匹配的 }" },

      { "[m", desc = "上一个方法开始" },
      { "]m", desc = "下一个方法开始" },
      { "[M", desc = "上一个方法结束" },
      { "]M", desc = "下一个方法结束" },

      { "[[", desc = "上一个引用(vim-illuminate)", icon = { icon = "", color = "yellow" } },
      { "]]", desc = "下一个引用(vim-illuminate)", icon = { icon = "", color = "yellow" } },
    },
  },
  {
    label = "g 系列: 跳转和操作",
    mappings = {
      { "gcc", desc = "(取消)注释选区(mini.comment)" },
      { "gc", desc = "选区(取消)注释(mini.comment)" },
      { "gd", desc = "去往定义(lspsaga)" },
      { "gD", desc = "去往声明" },
      { "ge", desc = "去往上一个单词末尾" },
      { "gE", desc = "去往上一个 WORD 末尾" },
      { "gf", desc = "去往光标下的文件" },
      { "gF", desc = "去往文件:行号" },
      { "gg", desc = "去往文件顶部" },
      { "gI", desc = "在行首插入" },
      { "gi", desc = "去往上次插入位置" },
      { "gj", desc = "向下移动（屏幕行）" },
      { "gk", desc = "向上移动（屏幕行）" },
      { "gn", desc = "向前搜索并选择" },
      { "gN", desc = "向后搜索并选择" },
      { "go", desc = "去往字节偏移" },
      { "gr", desc = "查找引用" },
      { "gv", desc = "重新选择上次选区" },
      { "gx", desc = "打开光标下的 URL" },
      { "g~", desc = "切换大小写" },
      { "gu", desc = "转为小写" },
      { "gU", desc = "转为大写" },
      { "g&", desc = "重复上次替换" },
      { "g;", desc = "去往上次修改位置" },
      { "g,", desc = "去往下次修改位置" },
      { "gt", desc = "下一个标签页" },
      { "gT", desc = "上一个标签页" },
      { "1gt", desc = "去往第 1 个标签页" },
      { "2gt", desc = "去往第 2 个标签页" },
      { "3gt", desc = "去往第 3 个标签页" },
      { "4gt", desc = "去往第 4 个标签页" },
      { "5gt", desc = "去往第 5 个标签页" },
    },
  },
  {
    label = "z 系列: 折叠与滚动",
    mappings = {
      { "za", desc = "切换折叠" },
      { "zA", desc = "递归切换折叠" },
      { "zc", desc = "关闭折叠" },
      { "zC", desc = "递归关闭折叠" },
      { "zo", desc = "打开折叠" },
      { "zO", desc = "递归打开折叠" },
      { "zm", desc = "折叠更多" },
      { "zM", desc = "折叠所有" },
      { "zr", desc = "减少折叠" },
      { "zR", desc = "打开所有折叠(nvim-ufo)" },
      { "zK", desc = "预览折叠内容(nvim-ufo)" },
      { "zz", desc = "光标居中" },
      { "zt", desc = "光标置顶" },
      { "zb", desc = "光标置底" },
    },
  },
  {
    label = "Ctrl 系列",
    mappings = {
      { "<C-r>", desc = "重做" },
      { "<C-o>", desc = "跳转到上一个位置" },
      { "<C-i>", desc = "跳转到下一个位置" },
      { "<C-]>", desc = "跳转到标签" },
      { "<C-t>", desc = "返回标签栈" },
      { "<C-a>", desc = "数字加 1" },
      { "<C-x>", desc = "数字减 1" },
      { "<C-d>", desc = "向下滚动半屏" },
      { "<C-u>", desc = "向上滚动半屏" },
      { "<C-f>", desc = "向下滚动一屏" },
      { "<C-b>", desc = "向上滚动一屏" },
      { "<C-e>", desc = "向下滚动一行" },
      { "<C-y>", desc = "向上滚动一行" },

      -- 补全操作
      { "<C-j>", desc = "下一个补全项(blink.cmp)", mode = "c" },
      { "<C-k>", desc = "上一个补全项(blink.cmp)", mode = "c" },
      { "<C-h>", desc = "补全列表上一页(blink.cmp)", mode = "i" },
      { "<C-j>", desc = "下一个补全项(blink.cmp)", mode = "i" },
      { "<C-k>", desc = "上一个补全项(blink.cmp)", mode = "i" },
      { "<C-l>", desc = "补全列表下一页(blink.cmp)", mode = "i" },
      { "<C-b>", desc = "补全文档向上滚动(blink.cmp)", mode = "i" },
      { "<C-f>", desc = "补全文档向下滚动(blink.cmp)", mode = "i" },
      { "<C-Space>", desc = "显示补全菜单(blink.cmp)", mode = "i" },

      -- 窗口操作
      { "<C-w>s", desc = "上下分割窗口" },
      { "<C-w>v", desc = "左右分割窗口" },
      { "<C-w>q", desc = "关闭窗口" },
      { "<C-w>o", desc = "只保留当前窗口" },
      { "<C-w>h", desc = "移动到左边窗口" },
      { "<C-w>j", desc = "移动到下边窗口" },
      { "<C-w>k", desc = "移动到上边窗口" },
      { "<C-w>l", desc = "移动到右边窗口" },
      { "<C-w>w", desc = "切换到下一个窗口" },
      { "<C-w>p", desc = "切换到上一个窗口" },
      { "<C-w>H", desc = "移动窗口到最左" },
      { "<C-w>J", desc = "移动窗口到最下" },
      { "<C-w>K", desc = "移动窗口到最上" },
      { "<C-w>L", desc = "移动窗口到最右" },
      { "<C-w>=", desc = "平均窗口大小" },
      { "<C-w>+", desc = "增加窗口高度" },
      { "<C-w>-", desc = "减少窗口高度" },
      { "<C-w>>", desc = "增加窗口宽度" },
      { "<C-w><", desc = "减少窗口宽度" },
    },
  },
  {
    label = "leader 系列",
    mappings = {
      { "<leader>r", group = "重命名/替换", icon = { icon = "", color = "purple" } },
      { "<leader>rf", desc = "重命名文件(snacks rename)", icon = { icon = "󰑕", color = "purple" } },
      { "<leader>rr", desc = "重命名(rename-highlight)", icon = { icon = "", color = "purple" } },
      { "<leader>rs", desc = "搜索并替换(nvim-spectre)", icon = { icon = "", color = "purple" } },
      { "<leader>rS", desc = "全局搜索并替换(nvim-spectre)", icon = { icon = "", color = "purple" } },
      { "<leader>rw", desc = "搜索并替换当前单词(nvim-spectre)", icon = { icon = "", color = "purple" } },

      { "<leader>f", group = "查找/搜索", icon = { icon = "", color = "purple" } },
      { "<leader>fp", desc = "项目(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>ff", desc = "文件(snacks picker)", icon = { icon = "󰈔", color = "purple" } },
      { "<leader>fr", desc = "最近文件(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>ft", desc = "TODO(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>fb", desc = "缓冲区(snacks picker)", icon = { icon = "󰓩", color = "purple" } },
      { "<leader>fh", desc = "高亮组(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>fl", desc = "LSP 符号(snacks picker)", icon = { icon = "󰫧", color = "purple" } },
      { "<leader>fd", desc = "诊断(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>fa", desc = "自动命令(snacks picker)", icon = { icon = "󰘳", color = "purple" } },
      { "<leader>fk", desc = "快捷键列表(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>fc", desc = "命令行历史(snacks picker)", icon = { icon = "", color = "purple" } },
      { "<leader>fn", desc = "通知历史(snacks picker)", icon = { icon = "󰂞", color = "purple" } },
      { "<leader>fs", desc = "全局搜索(snacks picker)", icon = { icon = "󰥨", color = "purple" } },

      { "<leader>g", group = "Git", icon = { icon = "", color = "orange" } },
      { "<leader>gb", desc = "blame(gitsigns)", icon = { icon = "", color = "orange" } },
      { "<leader>gg", desc = "Lazygit(snacks)", icon = { icon = "", color = "orange" } },

      { "<leader>h", desc = "快速跳转(flash)", icon = { icon = "", color = "yellow" } },

      { "<leader>b", group = "缓冲区", icon = { icon = "󰓩", color = "purple" } },
      { "<leader>bh", desc = "前一个缓冲区(bufferline)", icon = { icon = "󰓩", color = "purple" } },
      { "<leader>bl", desc = "后一个缓冲区(bufferline)", icon = { icon = "󰓩", color = "purple" } },
      { "<leader>bp", desc = "选择缓冲区(bufferline)", icon = { icon = "󰓩", color = "purple" } },
      { "<leader>bd", desc = "关闭当前缓冲区(bufferline)", icon = { icon = "󰓩", color = "purple" } },
      { "<leader>bo", desc = "关闭其他缓冲区(bufferline)", icon = { icon = "󰓩", color = "purple" } },

      { "<leader>l", group = "LSP", icon = { icon = "󰡱", color = "purple" } },
      { "<leader>lc", desc = "代码操作(lspsaga)", icon = { icon = "󰘦", color = "purple" } },
      { "<leader>lf", desc = "格式化(stylua/eslint/prettier)", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>lR", desc = "finder(lspsaga)", icon = { icon = "󰀶", color = "purple" } },
      { "<leader>lo", desc = "大纲视图(lspsaga)", icon = { icon = "", color = "purple" } },

      { "<leader>e", group = "文件浏览器", icon = "󰙅" },
      { "<leader>ee", desc = "切换文件浏览器(nvim-tree)", icon = { icon = "󰙅", color = "purple" } },
      { "<leader>ef", desc = "聚焦文件树/编辑区(nvim-tree)", icon = { icon = "", color = "purple" } },
      { "<leader>ep", desc = "项目浏览(snacks explorer)", icon = { icon = "󱧶", color = "purple" } },


      { "<leader>s", group = "字符包裹(nvim-surround)", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sa", desc = "添加包裹{motion}{char}", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sA", desc = "行模式添加包裹{motion}{char}(换行)", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>saa", desc = "行模式当前行添加包裹{char}", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sAA", desc = "行模式当前行添加包裹{char}(换行)", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sd", desc = "删除包裹{char}", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sc", desc = "替换包裹{old}{new}", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sC", desc = "行模式当前行替换包裹{old}{new}(换行)", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sct", desc = "替换HTML标签{new}", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sdt", desc = "删除HTML标签", icon = { icon = "󰛖", color = "purple" } },
      { "<leader>sdf", desc = "删除函数调用", icon = { icon = "󰛖", color = "purple" } },

      { "<leader>u", group = "UI", icon = "" },
      { "<leader>uc", desc = "颜色主题(snacks picker)", icon = { icon = "󰔎", color = "purple" } },

      { "<leader>w", group = "winbar", icon = "" },
      { "<leader>wb", desc = "面包屑(dropbar)", icon = { icon = "󰖰", color = "purple" } },

      { "<leader>z", desc = "切换Zen模式(snacks zen)", icon = { icon = "󱅻", color = "purple" } },
      { "<leader>N", desc = "Neovim新闻(snacks win)", icon = { icon = "󱀄", color = "purple" } },
    },
  },
  {
    label = "Alt 系列",
    mappings = {
      { "<M>", group = "其他", icon = { icon = "󰆾", color = "blue" } },
      { "<M-`>", desc = "切换终端(snacks terminal)", icon = { icon = "", color = "orange" } },
      { "<M-Left>", desc = "向左移动", icon = { icon = "", color = "blue" } },
      { "<M-Right>", desc = "向右移动", icon = { icon = "", color = "blue" } },
      { "<M-Down>", desc = "向下移动", icon = { icon = "", color = "blue" } },
      { "<M-Up>", desc = "向上移动", icon = { icon = "", color = "blue" } },
    },
  },
  {
    label = "其他常用快捷键",
    mappings = {
      { "<Tab>", desc = "接受补全(blink.cmp)", mode = "i" },
      { "<Tab>", desc = "接受补全(blink.cmp)", mode = "c" },
      { "<CR>", desc = "取消补全(blink.cmp)", mode = "i" },

      { "K", desc = "悬停文档(lspsaga)" },
      { "J", desc = "合并行" },
      { "u", desc = "撤销" },
      { ".", desc = "重复上次操作" },
      { "@:", desc = "重复上次命令" },
      { "@@", desc = "重复上次宏" },
      { "*", desc = "向前搜索光标下的单词" },
      { "#", desc = "向后搜索光标下的单词" },
      { "n", desc = "下一个搜索结果" },
      { "N", desc = "上一个搜索结果" },
      { "%", desc = "跳转到匹配的括号" },

      { "<esc>", desc = "双击 esc 回到普通模式(snacks terminal); 退出搜索高亮" },
    },
  },
}

local colors = require("utils.colors")

---@class WhichKeyHighlightRule which-key 高亮配置项
---@field group string 目标高亮组
---@field spec table 高亮参数
local HIGHLIGHT_RULES = {
  { group = "WhichKeyNormal", spec = { bg = colors.get("neutral_gray_dark") } },
  { group = "WhichKeyBorder", spec = { fg = colors.get("neutral_blue_gray"), bg = colors.get("neutral_gray_dark") } },
  { group = "WhichKey", spec = { fg = "#bb9af7" } },
  { group = "WhichKeyDesc", spec = { fg = "#ded7d7" } },
  { group = "WhichKeyGroup", spec = { fg = "#ded7d7" } },
  { group = "WhichKeySeparator", spec = { fg = "#565f89" } },
  { group = "WhichKeyValue", spec = { fg = "#9ece6a" } },
  { group = "WhichKeyTitle", spec = { fg = "#BB9AF7" } },
}

--- 注册 which-key 的高亮配色
local function configure_highlights()
  for _, rule in ipairs(HIGHLIGHT_RULES) do
    vim.api.nvim_set_hl(0, rule.group, rule.spec)
  end
end

--- 向 which-key 注册所有按键分组
---@param wk table which-key 模块实例
local function register_key_groups(wk)
  for _, group in ipairs(KEY_GROUPS) do
    -- label 字段用于阅读提示，不参与调用逻辑
    wk.add(group.mappings)
  end
end

--- 构造 which-key 插件配置项
---@return table
local function build_options()
  return {
    preset = "helix",
    icons = {
      -- 为特定插件添加图标
      rules = {
        -- `azure`, `blue`, `cyan`, `green`, `grey`, `orange`, `purple`, `red`, `yellow`
        { plugin = "hop.nvim", icon = "󰉂", color = "blue" },
        { plugin = "nvim-tree.lua", icon = "󰙅", color = "blue" },
        { plugin = "lspsaga.nvim", icon = "󰡱", color = "blue" },
        { plugin = "conform.nvim", icon = "󱉯", color = "blue" },
      },
      breadcrumb = "+",
      group = "",
    },
    win = {
      title_pos = "center",
    },
    keys = {
      scroll_down = "<c-j>",
      scroll_up = "<c-k>",
    },
    replace = {
      key = {
        function(key)
          return require("which-key.view").format(key)
        end,
      },
    },
  }
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = build_options(),
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    configure_highlights()
    register_key_groups(wk)
  end,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
}
