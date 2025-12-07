-- Neovim 基础选项配置模块

local M = {}

--- 设置语言环境相关命令
local function setup_language()
  vim.cmd("language zh_CN.UTF-8")
end

--- 配置界面展示相关选项
local function setup_ui()
  local opt, o = vim.opt, vim.o

  opt.number = true -- 显示绝对行号
  opt.relativenumber = true -- 显示相对行号
  opt.title = true -- 将窗口标题设置为文件名
  opt.showcmd = true -- 状态栏展示当前输入命令
  opt.showmode = false -- 禁用模式提示（由 lualine 承担）

  opt.wrap = true -- 启用软换行
  opt.textwidth = 80 -- 建议文本宽度
  opt.linebreak = true -- 在单词边界换行，避免将单词拆断
  opt.showbreak = "↪ " -- 换行指示符
  opt.breakat = " \t!@*-+;:,./?" -- 允许换行的字符集合
  opt.backspace = { "start", "eol", "indent" } -- 扩展退格可删除范围

  opt.mouse = "" -- 禁用鼠标，保持键盘驱动的编辑体验
  o.cursorline = true -- 高亮当前行，便于定位
end

--- 配置缩进与格式化行为
local function setup_indentation()
  local opt = vim.opt

  opt.autoindent = true -- 新行继承当前行缩进
  opt.smartindent = true -- 基于语法自动调整缩进
  opt.expandtab = true -- Tab 键转换为空格
  opt.smarttab = true -- 在缩进位置插入 shiftwidth 数量的空格
  opt.breakindent = true -- 换行时保持视觉缩进
  opt.tabstop = 2 -- Tab 显示宽度
  opt.shiftwidth = 2 -- 自动缩进宽度
end

--- 配置搜索体验
local function setup_search()
  local opt = vim.opt

  opt.hlsearch = true -- 保留搜索高亮
  opt.ignorecase = true -- 默认忽略大小写
  opt.smartcase = true -- 搜索词包含大写时启用大小写敏感
  -- 若需实时预览替换效果，可启用：
  opt.inccommand = "split"
end

--- 配置编码与数字处理选项
local function setup_encoding()
  local opt = vim.opt

  vim.scriptencoding = "utf-8" -- Neovim 运行脚本的编码
  opt.encoding = "utf-8" -- 内部编码
  opt.fileencoding = "utf-8" -- 写入文件的默认编码
  opt.fileencodings = "utf-8,gbk,gb2312,gb18030" -- 读取文件时的检测顺序
  opt.nrformats = "bin,hex,alpha" -- <C-a>/<C-x> 支持的数字格式
end

--- 配置窗口行为，优化分屏体验
local function setup_windows()
  local opt = vim.opt

  opt.splitbelow = true -- 水平分割新窗口位于下方
  opt.splitright = true -- 垂直分割新窗口位于右侧
  opt.splitkeep = "cursor" -- 分屏后保持光标位置稳定
end

--- 配置文件系统相关选项
local function setup_files()
  local opt = vim.opt

  opt.autoread = true -- 文件外部变更时自动重新载入
  opt.backup = false -- 禁止创建备份文件
  opt.path:append({ "**" }) -- 文件搜索支持递归子目录
  opt.wildignore:append({ "*/node_modules/" }) -- 补全时忽略 node_modules
  opt.clipboard = "unnamedplus" -- 使用系统剪贴板
end

--- 主入口：按模块顺序执行所有配置
function M.setup()
  setup_language()
  setup_ui()
  setup_indentation()
  setup_search()
  setup_encoding()
  setup_windows()
  setup_files()
end

M.setup()

return M