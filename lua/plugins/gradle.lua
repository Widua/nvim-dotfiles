local gradle = require 'gradle'

gradle.setup {
  sync = {
    enabled = true,
    clients = {
      jdtls = true,
      kotlin_lsp = true,
    },
  },
}
