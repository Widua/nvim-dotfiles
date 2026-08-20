local opencode = require 'opencode'

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
  opencode.ask '@this: '
end, { desc = 'Ask OpenCode…' })

vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
  opencode.select()
end, { desc = 'Select OpenCode…' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
  return opencode.operator '@this '
end, { desc = 'Append range to OpenCode', expr = true })

vim.keymap.set({ 'n' }, 'goo', function()
  return opencode.operator '@this ' .. '_'
end, { desc = 'Append line to OpenCode', expr = true })

vim.keymap.set({ 'n' }, '<S-C-u>', function()
  opencode.command 'session.half.page.up'
end, { desc = 'Scroll OpenCode up' })

vim.keymap.set({ 'n' }, '<S-C-d>', function()
  opencode.command 'session.half.page.down'
end, { desc = 'Scroll OpenCode down' })
