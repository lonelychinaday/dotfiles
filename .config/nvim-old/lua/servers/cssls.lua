-- CSS Language Server
-- 提供 CSS/SCSS/Less 的智能提示、验证、补全等功能

return function(capabilities)
  vim.lsp.config("cssls", {
    capabilities = capabilities,
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore", -- 忽略未知的 @规则（如 Tailwind 的 @apply）
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  })
end