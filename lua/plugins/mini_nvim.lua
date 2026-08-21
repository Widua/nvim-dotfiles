require('mini.ai').setup { n_lines = 500 }
require('mini.pairs').setup {}
require('mini.surround').setup {}
require('mini.icons').setup {}

local statusline = require 'mini.statusline'

local function java_context()
  local filetype = vim.bo.filetype
  if filetype ~= 'java' and filetype ~= 'kotlin' then
    return ''
  end

  local package_name
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    package_name = line:match '^%s*package%s+([%w_%.]+)'
    if package_name then
      break
    end
  end

  local filename = vim.api.nvim_buf_get_name(0)
  local directory = vim.fs.dirname(filename)
  local build_file = vim.fs.find({ 'build.gradle', 'build.gradle.kts' }, {
    path = directory,
    upward = true,
    type = 'file',
    limit = 1,
  })[1]
  local module = build_file and vim.fs.basename(vim.fs.dirname(build_file))

  local context = {}
  local icons = vim.g.have_nerd_font and { module = '󰉋 ', package = '󰏗 ' } or { module = 'module ', package = 'package ' }
  if module then
    table.insert(context, icons.module .. module)
  end
  if package_name then
    table.insert(context, icons.package .. package_name)
  end

  return #context > 0 and table.concat(context, '  ') or ''
end

statusline.section_location = function()
  return '%2l:%-2v'
end

statusline.setup {
  use_icons = vim.g.have_nerd_font,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
      local git = statusline.section_git { trunc_width = 40 }
      local diff = statusline.section_diff { trunc_width = 75 }
      local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
      local lsp = statusline.section_lsp { trunc_width = 75 }
      local filename = statusline.section_filename { trunc_width = 140 }
      local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
      local location = statusline.section_location { trunc_width = 75 }
      local search = statusline.section_searchcount { trunc_width = 75 }
      local context = java_context()

      return statusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { context } },
        { hl = mode_hl, strings = { fileinfo, search, location } },
      }
    end,
  },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' }, {
  callback = function()
    vim.cmd.redrawstatus()
  end,
})
