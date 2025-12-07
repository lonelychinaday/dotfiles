-- Tailwind CSS Language Server
-- 提供 Tailwind CSS 类名的智能提示、补全、颜色预览等功能

return function(capabilities)
  vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList", "ngClass" },
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning",
        },
        validate = true,
        experimental = {
          classRegex = {
            -- 支持更多的类名匹配模式
            "tw`([^`]*)", -- tw`...`
            "tw\\.[^`]+`([^`]*)`", -- tw.xxx`...`
            "tw\\(.*?\\).*?`([^`]*)", -- tw(...)` ... `
            { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }, -- clsx(...)
            { "classnames\\(([^)]*)\\)", "'([^']*)" }, -- classnames(...)
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" }, -- cva(...)
          },
        },
      },
    },
  })
end