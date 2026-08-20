vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      vim.notify('Compiled telescope-fzf-native!', vim.log.levels.INFO)
    end

    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      vim.schedule(function()
        vim.cmd 'TSUpdate'
      end)
    end

    if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
      vim.system({ 'cargo', 'build', '--release' }, { cwd = ev.data.path }):wait()
      vim.notify('Compiled blink.cmp!', vim.log.levels.INFO)
    end
  end,
})
