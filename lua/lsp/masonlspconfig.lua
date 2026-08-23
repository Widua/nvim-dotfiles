local capabilities = require('blink.cmp').get_lsp_capabilities()

local function kotlin_location_handler(err, result, ctx, config)
  if result then
    local locations = vim.islist(result) and result or { result }
    result = vim.tbl_filter(function(location)
      local uri = location.uri or location.targetUri or ''
      return not vim.startswith(uri, 'jar://') or uri:match '!/.*%.kts?$' or uri:match '!/.*%.java$'
    end, locations)

    if vim.tbl_isempty(result) then
      vim.notify('Kotlin LSP returned a binary location without navigable source', vim.log.levels.INFO)
      return
    end
  end

  vim.lsp.handlers[ctx.method](err, result, ctx, config)
end

local servers = {
  gopls = {},
  lemminx = {},
  dockerls = {},
  pylsp = {},
  vue_ls = {},
  gradle_ls = {},
  kotlin_lsp = {
    handlers = {
      ['textDocument/definition'] = kotlin_location_handler,
      ['textDocument/declaration'] = kotlin_location_handler,
      ['textDocument/implementation'] = kotlin_location_handler,
      ['textDocument/references'] = kotlin_location_handler,
    },
  },
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
  ensure_installed = {
    'stylua',
    'jdtls',
    'java-debug-adapter',
    'java-test',
  },
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
