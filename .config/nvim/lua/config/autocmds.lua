local colors = require("utils.colors")

-------------------------------------------------------------------------------
-- 工具函数
-------------------------------------------------------------------------------

--- 批量设置高亮，避免在不同位置重复调用 set_hl。
---@param definitions table<string, table>
local function set_highlights(definitions)
  for group, opts in pairs(definitions) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

--- 安全获取 buffer 的 filetype，防止临时 buffer 报错。
---@param buf number
---@return string|nil
local function safe_filetype(buf)
  local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
  return ok and ft or nil
end

-------------------------------------------------------------------------------
-- NvimTree 目录高亮控制
-------------------------------------------------------------------------------

local directory_highlighter = {
  active = false,
  styles = {
    active = {
      fg = colors.get("accent_primary"),
      bg = colors.get("surface_panel"),
      bold = true,
      italic = true,
    },
    inactive = {
      fg = colors.get("neutral_light"),
      bg = colors.get("surface_base"),
    },
  },
}

--- 根据是否聚焦 NvimTree 切换目录高亮。
---@param is_active boolean
function directory_highlighter:update(is_active)
  if self.active == is_active then
    return
  end
  self.active = is_active
  vim.api.nvim_set_hl(0, "Directory", is_active and self.styles.active or self.styles.inactive)
end

-------------------------------------------------------------------------------
-- 颜色方案切换后同步自定义高亮
-------------------------------------------------------------------------------

local function apply_colorscheme_highlights()
  set_highlights({
    -- 高亮当前行
    CursorLine = { bg = colors.get("surface_cursorline") },
    -- 渲染 markdown 代码块背景
    RenderMarkdownCodeBlock = { bg = colors.get("surface_float") },
    RenderMarkdownCodeBorder = { bg = colors.get("surface_float") },
    RenderMarkdownCodeInline = { bg = colors.get("surface_float") },
    -- 高亮当前行的行号
    CursorLineNr = { fg = colors.get("accent_primary"), bold = true },
    -- 补全菜单
    BlinkCmpMenu = { bg = colors.get("neutral_gray_dark") },
    BlinkCmpMenuBorder = { bg = colors.get("neutral_gray_dark"), fg = colors.get("neutral_blue_gray") },
    -- 补全文档
    BlinkCmpDoc = { bg = colors.get("surface_float") },
    -- 补全文档边框
    BlinkCmpDocBorder = {
      bg = colors.get("surface_float"),
      fg = colors.get("neutral_blue_gray"),
    },
    -- Codeium补全颜色
    BlinkCmpKindCodeium = { fg = colors.get("accent_purple_deep") },
    LspRenameTarget = {
      bg = colors.get("accent_primary_soft"),
      fg = colors.get("neutral_black"),
    },
    -- 折叠区域
    Folded = {
      bg = colors.get("surface_fold"),
      fg = colors.get("neutral_mid"),
    },
    -- 窗口栏
    WinBar = { bg = colors.get("neutral_gray_dark") },
    WinBarNC = { bg = colors.get("neutral_gray_dark") },
    -- Snacks 终端浮窗背景
    SnacksNormalFloat = { bg = colors.get("surface_float") },
    SnacksFloatBorder = { bg = colors.get("surface_float") },
    -- 缩进线颜色
    SnacksIndentLevel1 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel2 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel3 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel4 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel5 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel6 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel7 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentLevel8 = { fg = colors.get("neutral_gray_dark") },
    SnacksIndentScope = { fg = colors.get("accent_purple_light") },
  })

  directory_highlighter:update(directory_highlighter.active)
end

-------------------------------------------------------------------------------
-- 自动命令统一注册
-------------------------------------------------------------------------------

local augroups = {
  DirectoryHighlight = vim.api.nvim_create_augroup("DirectoryHighlightForNvimTree", { clear = true }),
  LastCursor = vim.api.nvim_create_augroup("LastCursorGroup", { clear = true }),
  HighlightYank = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  LspMappings = vim.api.nvim_create_augroup("LspMappings", { clear = true }),
  ColorSync = vim.api.nvim_create_augroup("LocalColorSchemeSync", { clear = true }),
}

local autocmds = {
  {
    event = "ColorScheme",
    group = augroups.ColorSync,
    desc = "颜色方案切换时同步自定义高亮",
    callback = apply_colorscheme_highlights,
  },
  {
    event = "BufEnter",
    group = augroups.DirectoryHighlight,
    desc = "进入/离开 NvimTree 时切换目录高亮",
    callback = function(ev)
      directory_highlighter:update(safe_filetype(ev.buf) == "NvimTree")
    end,
  },
  {
    event = "BufReadPost",
    group = augroups.LastCursor,
    desc = "重新打开文件时恢复上次光标位置",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local line_count = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= line_count then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  },
  {
    event = "TextYankPost",
    group = augroups.HighlightYank,
    desc = "复制后短暂高亮选区",
    callback = function()
      vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
  },
  {
    event = "LspAttach",
    group = augroups.LspMappings,
    desc = "LSP 初始化后绑定快捷键",
    callback = require("utils.lsp").on_attach,
  },
  {
    event = "FileType",
    pattern = "sagarename",
    desc = "Lspsaga 重命名界面禁用补全",
    callback = function(ev)
      vim.b[ev.buf].completion = false
    end,
  },
  {
    event = "FileType",
    pattern = "python",
    desc = "为 Python 设置统一缩进与参考线",
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 0
      vim.wo.colorcolumn = "120"
    end,
  },
  {
    event = "FileType",
    pattern = "markdown",
    desc = "为 Markdown 禁用换行相关设置",
    callback = function()
      local opt_local = vim.opt_local
      opt_local.textwidth = 0
      opt_local.linebreak = false
      opt_local.showbreak = ""
      opt_local.breakat = " \t!@*-+;:,./?^I"
      opt_local.backspace = { "indent", "eol", "start" }
    end,
  },
}

for _, cfg in ipairs(autocmds) do
  local events = cfg.event
  local opts = vim.tbl_deep_extend("force", {}, cfg)
  opts.event = nil
  vim.api.nvim_create_autocmd(events, opts)
end

-- 初始化时同步一次高亮，避免启动后颜色缺失
apply_colorscheme_highlights()

