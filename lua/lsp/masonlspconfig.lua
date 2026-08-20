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

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
})

require('mason-tool-installer').setup {
  ensure_installed = ensure_installed,
}

require('mason-lspconfig').setup {
  automatic_enable = {
    exclude = {
      'jdtls',
    },
  },
  ensure_installed = {},
  automatic_installation = false,

  handlers = {
    function(server_name)
      local server = servers[server_name] or {}

      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

      if not vim.lsp.get_config(server_name) then
        vim.lsp.config(server_name, server)
      end

      vim.lsp.enable(server_name)
    end,
  },
}
