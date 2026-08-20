local intellij = require 'intellij-lsp'

intellij.setup {
  server_dir = '~/.local/share/intellij-server',
  accept_eula = true,
  jdk = '~/.sdkman/candidates/java/26.0.1-librca/',
  gradle_annotation_sources = true,
}
