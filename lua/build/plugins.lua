local githubPlugin = 'https://github.com/'
local localGradle = vim.fn.expand '~/NeovimLuaProjects/gradle-nvim'
local localIntellij = vim.fn.expand '~/NeovimLuaProjects/nvim-intellij-lsp'

local plugins = {
  { src = githubPlugin .. 'NMAC427/guess-indent.nvim' },
  { src = githubPlugin .. 'nvim-lua/plenary.nvim' },
  { src = githubPlugin .. 'chomosuke/typst-preview.nvim' },
  { src = githubPlugin .. 'L3MON4D3/LuaSnip' },
  { src = githubPlugin .. 'nvim-telescope/telescope.nvim' },
  { src = githubPlugin .. 'nvim-telescope/telescope-fzf-native.nvim' },
  { src = githubPlugin .. 'nvim-telescope/telescope-ui-select.nvim' },
  { src = githubPlugin .. 'nvim-treesitter/nvim-treesitter' },
  { src = githubPlugin .. 'saghen/blink.lib' },
  { src = githubPlugin .. 'saghen/blink.cmp' },
  { src = githubPlugin .. 'folke/tokyonight.nvim' },
  { src = githubPlugin .. 'folke/lazydev.nvim' },
  { src = githubPlugin .. 'folke/which-key.nvim' },
  { src = githubPlugin .. 'folke/todo-comments.nvim' },
  { src = githubPlugin .. 'nvim-mini/mini.nvim' },
  { src = githubPlugin .. 'nvim-tree/nvim-web-devicons' },
  { src = githubPlugin .. 'stevearc/conform.nvim' },
  { src = githubPlugin .. 'lewis6991/gitsigns.nvim' },
  { src = githubPlugin .. 'ThePrimeagen/harpoon' },
  { src = githubPlugin .. 'neovim/nvim-lspconfig' },
  { src = githubPlugin .. 'mason-org/mason.nvim' },
  { src = githubPlugin .. 'mason-org/mason-lspconfig.nvim' },
  { src = githubPlugin .. 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = githubPlugin .. 'j-hui/fidget.nvim' },
  { src = githubPlugin .. 'nickjvandyke/opencode.nvim' },
  { src = githubPlugin .. 'folke/snacks.nvim' },
}

if vim.uv.fs_stat(localIntellij) then
  vim.opt.rtp:prepend(localIntellij)
else
  table.insert(plugins, { src = githubPlugin .. 'widua/nvim-intellij-lsp' })
end

if vim.uv.fs_stat(localGradle) then
  vim.opt.rtp:prepend(localGradle)
  vim.cmd 'runtime plugin/gradle.lua'
else
  table.insert(plugins, { src = githubPlugin .. 'widua/gradle-nvim' })
end

vim.pack.add(plugins)
