local root_markers = {
  ".git",
  ".hg",
  ".svn",
  ".bzr",
  "_darcs",
  "package.json",
  "pyproject.toml",
  "Pipfile",
  "poetry.lock",
  "poetry.toml",
  "Cargo.toml",
  "go.mod",
  "Makefile",
  "CMakeLists.txt",
  "build.gradle",
  "gradlew",
  "pom.xml",
  "composer.json",
  "mix.exs",
  "stack.yaml",
}

local function project_root(buf, win)
  win = win or 0
  buf = buf or 0

  if buf == 0 then
    if win ~= 0 and vim.api.nvim_win_is_valid(win) then
      buf = vim.api.nvim_win_get_buf(win)
    else
      buf = vim.api.nvim_get_current_buf()
    end
  end

  if not vim.api.nvim_buf_is_valid(buf) then
    local ok, cwd = pcall(vim.fn.getcwd, win)
    return vim.fs.normalize(ok and cwd or vim.fn.getcwd())
  end

  local filepath = vim.api.nvim_buf_get_name(buf)
  if filepath == "" then
    local ok, cwd = pcall(vim.fn.getcwd, win)
    return vim.fs.normalize(ok and cwd or vim.fn.getcwd())
  end

  local dir = vim.fs.dirname(filepath)
  local match = vim.fs.find(root_markers, { path = dir, upward = true })[1]
  if match then
    return vim.fs.normalize(vim.fs.dirname(match))
  end

  local ok, cwd = pcall(vim.fn.getcwd, win)
  if ok then
    return vim.fs.normalize(cwd)
  end

  local uv = vim.uv or vim.loop
  return vim.fs.normalize(uv.cwd())
end

return {
  -- "Bekaboo/dropbar.nvim",
  -- dependencies = {
  --   "nvim-tree/nvim-web-devicons",
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   build = "make",
  -- },
  -- event = { "BufReadPost", "BufNewFile", "WinNew" },
  -- opts = {
  --   bar = {
  --     padding = {
  --       left = 1,
  --       right = 0,
  --     },
  --     pick = {
  --       pivots = "asdfghjkl;", -- 左手友好
  --     },
  --   },
  --   menu = {
  --     entry = {
  --       padding = {
  --         left = 1,
  --         right = 1,
  --       },
  --     },
  --     win_configs = {
  --       border = "rounded",
  --     },
  --   },
  --   icons = {
  --     enable = true,
  --   },
  --   sources = {
  --     path = {
  --       relative_to = project_root,
  --     },
  --   },
  -- },
  -- keys = {
  --   {
  --     "<leader>wb",
  --     function()
  --       require("dropbar.api").pick()
  --     end,
  --   },
  -- },
}
