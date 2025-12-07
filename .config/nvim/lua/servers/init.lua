-- 使用 blink.cmp 的 LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.vtsls")(capabilities)
require("servers.vue_ls")(capabilities)
require("servers.cssls")(capabilities)
require("servers.tailwindcss")(capabilities)

vim.lsp.enable({
  'lua_ls',
  'vtsls',
  'vue_ls',
  'cssls',
  'tailwindcss',
})
