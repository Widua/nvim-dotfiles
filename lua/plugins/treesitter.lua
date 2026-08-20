local treesitter = require 'nvim-treesitter'

treesitter.setup {
  install_dir = vim.fn.stdpath 'data' .. '/site',
}
treesitter.install {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'java',
  'go',
  'javascript',
  'editorconfig',
  'groovy',
  'kotlin',
  'javadoc',
  'json',
  'xml',
  'kotlin',
  'yaml',
  'gitignore',
  'gitcommit',
}
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
  end,
})
