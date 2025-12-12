local M = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for visual mode
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = increment and "inc" or "dec"
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func .. "_" .. (g and "g" or "") .. (is_visual and "visual" or "normal")](group)
end

return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-p>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
    { "<C-m>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
    { "g<C-p>", function() return M.dial(true, true) end, expr = true, desc = "Increment", mode = {"n", "x"} },
    { "g<C-m>", function() return M.dial(false, true) end, expr = true, desc = "Decrement", mode = {"n", "x"} },
  }
}