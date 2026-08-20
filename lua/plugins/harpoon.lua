local harpoon = require('harpoon')
local ui = require('harpoon.ui')
local mark = require('harpoon.mark')

vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Mark file with harpoon' })
vim.keymap.set('n', '<A-w>', ui.nav_next, { desc = 'Go to next harpoon mark' })

vim.keymap.set('n', '<A-1>', function() ui.nav_file(1) end, { desc = 'Go to first harpoon file' })
vim.keymap.set('n', '<A-2>', function() ui.nav_file(2) end, { desc = 'Go to second harpoon file' })
vim.keymap.set('n', '<A-3>', function() ui.nav_file(3) end, { desc = 'Go to third harpoon file' })
vim.keymap.set('n', '<A-4>', function() ui.nav_file(4) end, { desc = 'Go to fourth harpoon file' })

vim.keymap.set('n', '<A-Tab>', ui.nav_prev, { desc = 'Go to previous harpoon mark' })
vim.keymap.set('n', '<A-e>', ui.toggle_quick_menu, { desc = 'Show harpoon marks' })

