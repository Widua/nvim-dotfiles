local gradle = require 'gradle'

gradle.setup {
  sync = {
    enabled = true,
    clients = {
      intellij = true,
      jdtls = false,
      kotlin_lsp = true,
    },
  },
}
