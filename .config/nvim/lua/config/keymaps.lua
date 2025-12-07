-- 键位配置模块
--
-- 本模块集中管理 Neovim 的键位映射，强调可读性与可维护性：
--   1. 统一通过 apply_mappings 批量注册键位，避免散落在文件各处；
--   2. 为每个映射提供 desc 描述，便于 which-key 等工具展示；
--   3. 通过 setup_* 系列函数按功能模块划分，后续扩展时更直观。
--
-- 使用方式：require("config.keymaps") 时会自动执行 M.setup() 并返回模块表。

local rename_highlight = require("utils.rename-highlight")

-- 默认键位选项，silent 可减少命令回显噪声
local default_opts = { silent = true }

--- 合并默认选项与自定义选项
---@param opts table|nil 来自映射定义的额外选项
---@return table
local function with_default_opts(opts)
  return vim.tbl_deep_extend("force", {}, default_opts, opts or {})
end

--- 批量注册键位映射
---@param definitions table[] { mode, lhs, rhs, opts }
local function apply_mappings(definitions)
  for _, map_def in ipairs(definitions) do
    local mode, lhs, rhs, opts = map_def[1], map_def[2], map_def[3], map_def[4]
    vim.keymap.set(mode, lhs, rhs, with_default_opts(opts))
  end
end

local M = {}

--- 基础编辑类映射
--- 主要聚焦通用编辑体验，适用于所有缓冲区
function M.setup_basic()
  local mappings = {
    { { "n", "i" }, "<C-z>", "<Cmd>undo<CR>" },
    { "n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>" },
  }

  apply_mappings(mappings)
end

--- LSP 功能类映射
--- 依赖内置 LSP，提供更智能的代码编辑体验
function M.setup_lsp()
  local mappings = {
    {
      "n",
      "<leader>rr",
      rename_highlight.rename_with_highlight,
    },
  }

  apply_mappings(mappings)
end

--- 入口函数：按模块顺序执行所有键位配置
function M.setup()
  M.setup_basic()
  M.setup_lsp()
end

-- 直接执行 setup，确保 require 后立即生效
M.setup()

return M