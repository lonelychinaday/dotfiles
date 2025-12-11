-- vtsls
return function(capabilities)
  local vue_language_server_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

  local fs = vim.uv or vim.loop
  local has_vue_plugin = fs and fs.fs_stat and fs.fs_stat(vue_language_server_path) ~= nil
  local vue_plugin = has_vue_plugin and {
    name = "@vue/typescript-plugin",
    location = vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
  } or nil

  local shared_config = {
    suggest = { completeFunctionCalls = true },
    inlayHints = {
      parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
      parameterTypes = { enabled = true },
      variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      enumMemberValues = { enabled = true },
    },
  }

  vim.lsp.config("vtsls", {
    capabilities = capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    settings = {
      vtsls = {
        tsserver = has_vue_plugin and {
          globalPlugins = { vue_plugin },
        } or {},
        experimental = {
          completion = { enableServerSideFuzzyMatch = true },
        },
      },
      javascript = shared_config,
      typescript = shared_config,
    },
    on_attach = function(client, bufnr)
      if vim.bo[bufnr].filetype == 'vue' then
        client.server_capabilities.semanticTokensProvider.full = false
      end
    end,
  })
end