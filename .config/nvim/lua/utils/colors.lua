--- 调色板工具模块
--- 统一管理项目中使用的颜色，便于维护与主题调整。
--- 每个颜色条目都附带使用说明，便于后续检索。

local M = {}

---@class Palette
---@field accent_primary string   # 亮黄色主色，用于强调元素（如 NvimTree 激活、CursorLine 行号）
---@field accent_primary_soft string   # 柔和黄色，用于 LSP rename 目标高亮
---@field accent_blue string   # 浅蓝色，用于 Blink 文档边框
---@field accent_purple string   # 柔紫色，用于 which-key 键位
---@field accent_purple_deep string   # 深紫色，用于 Codeium 补全类型
---@field accent_cyan string   # 青绿色，用于 Illuminate 文本提示
---@field accent_magenta string   # 品红色，用于 Illuminate 只读提示
---@field accent_green string   # 偏绿青色，用于 Illuminate 写提示
---@field accent_green_soft string   # 柔和绿色，用于 which-key 值显示
---@field neutral_white string   # 明亮灰，用于 which-key 描述文本
---@field neutral_light string   # 浅灰，用于 Directory 非激活态
---@field neutral_mid string   # 中性灰，用于 Folded 文本
---@field neutral_muted string   # 暗灰色，用于 Winbar 文件名
---@field neutral_blue_gray string   # 蓝灰色，用于 which-key 分隔符
---@field neutral_graphite string   # 浅石墨色，用于 Bufferline duplicate 文本
---@field neutral_black string   # 纯黑，用于浅色背景上的文字
---@field surface_base string   # 主界面深色背景
---@field surface_panel string   # 侧边栏 / Bufferline 选中背景
---@field surface_cursorline string   # CursorLine 背景
---@field surface_fold string   # Folded 区域背景
---@field surface_float string   # 浮动窗口背景（如 Blink 文档）
---@field surface_overlay string   # 弹窗与 which-key 标题背景

---@type Palette
M.palette = {
  accent_primary = "#FEBC2D",
  accent_primary_soft = "#FFD866",
  accent_blue = "#7aa2f7",
  accent_cyan = "#7fd1ca",
  accent_purple = "#bb9af7",
  accent_purple_deep = "#b67af7",
  accent_purple_light = "#BB97EE",
  accent_magenta = "#bc88ca",
  green = "#00ff00",
  accent_green = "#69cd9e",
  accent_green_soft = "#9ece6a",
  neutral_white = "#ededed",
  neutral_light = "#CCCCCC",
  neutral_gray = "#444444",
  neutral_mid = "#989898",
  neutral_muted = "#7e7e7e",
  neutral_gray_dark = "#404040",
  neutral_blue_gray = "#565f89",
  neutral_graphite = "#E1E3E4",
  neutral_black = "#000000",
  neutral_gray_dark = "#1F1F1F",
  surface_base = "#292929", -- #1F1F1F
  surface_panel = "#333648",
  surface_cursorline = "#292929",
  surface_fold = "#212E3A",
  surface_float = "#34353b",
  surface_overlay = "#363A4E",
}

--- 获取指定名称的颜色值
---@param name string
---@return string
function M.get(name)
  local hex = M.palette[name]
  if not hex then
    error(string.format("未定义的调色板颜色：%s", name), 2)
  end
  return hex
end

return M
