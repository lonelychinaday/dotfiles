-- typst
return function(capabilities)
  vim.lsp.config("tinymist", {
    capabilities = capabilities,
    settings = {
      formatterMode = "typstyle",
    },
  })
end

