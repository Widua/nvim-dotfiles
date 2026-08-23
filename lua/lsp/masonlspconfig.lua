local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = {
  gopls = {},
  lemminx = {},
  dockerls = {},
  pylsp = {},
  vue_ls = {},
  gradle_ls = {},
  kotlin_lsp = {},
  ts_ls = {},
  qmlls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}

require('mason-tool-installer').setup {
  ensure_installed = { 'stylua' },
}

for server_name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  vim.lsp.config(server_name, server)
end

local ensure_installed = vim.tbl_keys(servers)

require('mason-lspconfig').setup {
  ensure_installed = ensure_installed,
  automatic_enable = ensure_installed,
}
