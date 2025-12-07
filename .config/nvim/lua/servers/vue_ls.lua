return function(capabilities)
  vim.lsp.config("vue_ls", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider.full = true
    end,
  })
end