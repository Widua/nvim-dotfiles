local intellij = require 'intellij-lsp'

intellij.setup {
  accept_eula = true,
  gradle_annotation_sources = true,
  file_templates = {
    { name = 'Class', path = '~/.config/nvim/templates/intellij/Class.java', language = 'java' },
    { name = 'Interface', path = '~/.config/nvim/templates/intellij/Interface.java', language = 'java' },
    { name = 'Enum', path = '~/.config/nvim/templates/intellij/Enum.java', language = 'java' },
    { name = 'Record', path = '~/.config/nvim/templates/intellij/Record.java', language = 'java' },
    { name = 'Class', path = '~/.config/nvim/templates/intellij/Class.kt', language = 'kotlin' },
    { name = 'Interface', path = '~/.config/nvim/templates/intellij/Interface.kt', language = 'kotlin' },
    { name = 'Enum', path = '~/.config/nvim/templates/intellij/Enum.kt', language = 'kotlin' },
  },
}
