require 'widua.keybinds'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local builtin = require 'telescope.builtin'
    local test_navigation = require 'lsp.test_navigation'

    map('<leader>rr', vim.lsp.buf.rename, 'Rename')
    map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gO', builtin.lsp_document_symbols, 'Open Document Symbols')
    map('gW', builtin.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

    map('gt', function()
      test_navigation.goto_test(event.buf, builtin.lsp_type_definitions)
    end, '[G]oto [T]est')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})
