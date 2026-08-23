local blink = require 'blink.cmp'

blink.setup {
  keymap = {
    preset = 'super-tab',
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      treesitter_highlighting = true,
      window = {
        max_width = 80,
        max_height = 20,
        border = 'rounded',
        winblend = 5,
        scrollbar = true,
      },
    },
  },

  sources = {
    per_filetype = {
      opencode_ask = { 'lsp', 'buffer' },
    },
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      lsp = { fallbacks = {} },
    },
  },

  snippets = { preset = 'luasnip' },

  fuzzy = { implementation = 'prefer_rust_with_warning' },

  signature = { enabled = true },
}
