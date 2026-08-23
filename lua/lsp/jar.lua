local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('BufReadCmd', {
    group = vim.api.nvim_create_augroup('lsp-jar-files', { clear = true }),
    pattern = 'jar://*',
    callback = function(event)
      local archive, entry = event.match:match '^jar://(.-)!/(.*)$'
      if not archive or not entry then
        return
      end

      archive = vim.uri_decode(archive)
      entry = vim.uri_decode(entry)

      local result = vim.system({ 'unzip', '-p', archive, entry }, { text = true }):wait()
      if result.code ~= 0 then
        vim.notify(result.stderr or ('Unable to read ' .. event.match), vim.log.levels.ERROR)
        return
      end

      local lines = vim.split(result.stdout, '\n', { plain = true })
      if lines[#lines] == '' then
        table.remove(lines)
      end

      vim.bo[event.buf].modifiable = true
      vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, lines)
      vim.bo[event.buf].buftype = 'nofile'
      vim.bo[event.buf].bufhidden = 'hide'
      vim.bo[event.buf].swapfile = false
      vim.bo[event.buf].modifiable = false

      local filetype = vim.filetype.match { filename = entry }
      if filetype then
        vim.bo[event.buf].filetype = filetype
      end
    end,
  })
end

return M
