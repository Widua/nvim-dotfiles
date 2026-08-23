local M = {}

local root_markers = {
  'settings.gradle',
  'settings.gradle.kts',
  'pom.xml',
  'build.gradle',
  'build.gradle.kts',
  'gradlew',
  'mvnw',
  '.git',
}

local function get_bundles(mason)
  local bundles = vim.fn.glob(mason .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true, true)

  for _, jar in ipairs(vim.fn.glob(mason .. '/java-test/extension/server/*.jar', true, true)) do
    local name = vim.fs.basename(jar)
    if name ~= 'com.microsoft.java.test.runner-jar-with-dependencies.jar' and name ~= 'jacocoagent.jar' then
      table.insert(bundles, jar)
    end
  end

  return bundles
end

function M.start()
  local root_dir = vim.fs.root(0, root_markers)
  if not root_dir then
    return
  end

  local mason = vim.fn.stdpath 'data' .. '/mason/packages'

  require('jdtls').start_or_attach {
    cmd = {
      mason .. '/jdtls/jdtls',
      '-data',
      vim.fn.stdpath 'cache' .. '/jdtls/' .. vim.fn.sha256(root_dir),
    },
    root_dir = root_dir,
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    settings = {
      java = {
        completion = {
          favoriteStaticMembers = {
            'org.junit.jupiter.api.Assertions.*',
            'org.mockito.Mockito.*',
          },
        },
        configuration = {
          updateBuildConfiguration = 'interactive',
        },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
      },
    },
    init_options = {
      bundles = get_bundles(mason),
    },
  }
end

return M
