local M = {}

local function create_test(test_dir, filetype, extension, default_name)
  vim.ui.input({ prompt = 'Test file name: ', default = default_name .. 'Test' }, function(name)
    if not name or name == '' then
      return
    end

    local class_name = name:gsub('%.' .. vim.pesc(extension) .. '$', '')
    local filename = class_name .. '.' .. extension
    vim.fn.mkdir(test_dir, 'p')
    vim.cmd.edit(vim.fn.fnameescape(test_dir .. '/' .. filename))

    local package_path = test_dir:match '/src/test/[^/]+/(.*)$'
    local package_name = package_path and package_path:gsub('/', '.')
    local lines = {}
    if package_name and package_name ~= '' then
      table.insert(lines, 'package ' .. package_name .. (filetype == 'java' and ';' or ''))
      table.insert(lines, '')
    end
    if filetype == 'java' then
      vim.list_extend(lines, { 'public class ' .. class_name .. ' {', '}', '' })
    else
      vim.list_extend(lines, { 'class ' .. class_name .. ' {', '}', '' })
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.cmd.write()
  end)
end

function M.goto_test(bufnr, fallback)
  local filetype = vim.bo[bufnr].filetype
  if filetype ~= 'java' and filetype ~= 'kotlin' then
    return fallback()
  end

  local source = vim.api.nvim_buf_get_name(bufnr)
  local is_test = source:find '/src/test/' ~= nil
  local basename = vim.fn.fnamemodify(source, ':t:r')
  local extension = vim.fn.fnamemodify(source, ':e')

  if is_test then
    local production_dir = source:gsub('/src/test/', '/src/main/', 1)
    production_dir = vim.fn.fnamemodify(production_dir, ':h')
    local test_markers = { 'IntegrationTest', 'Tests', 'Test', 'IT', 'Spec' }
    local production_names = {}
    for _, marker in ipairs(test_markers) do
      local marker_start = basename:find(marker, 1, true)
      if marker_start and marker_start > 1 then
        production_names[basename:sub(1, marker_start - 1)] = true
      end
    end

    local matches = vim.fs.find(function(path)
      local production_name = vim.fn.fnamemodify(path, ':t:r')
      return vim.tbl_contains(vim.tbl_keys(production_names), production_name)
        and vim.fn.fnamemodify(path, ':e') == extension
    end, { path = production_dir, type = 'file', limit = math.huge })

    if #matches == 1 then
      return vim.cmd.edit(vim.fn.fnameescape(matches[1]))
    elseif #matches > 1 then
      return vim.ui.select(matches, { prompt = 'Production file: ' }, function(choice)
        if choice then
          vim.cmd.edit(vim.fn.fnameescape(choice))
        end
      end)
    end
    vim.notify('No production file found for ' .. basename, vim.log.levels.INFO)
    return
  end

  local test_dir = source:gsub('/src/main/', '/src/test/', 1)
  test_dir = vim.fn.fnamemodify(test_dir, ':h')
  local pattern = '^' .. vim.pesc(basename) .. '.*%.' .. vim.pesc(extension) .. '$'
  local matches = vim.fs.find(function(path)
    return vim.fs.basename(path):match(pattern) ~= nil
  end, { path = test_dir, type = 'file', limit = math.huge })
  table.insert(matches, 'Create New Test')

  vim.ui.select(matches, {
    prompt = 'Test file: ',
    format_item = function(path)
      return path == 'Create New Test' and path or vim.fn.fnamemodify(path, ':~:.')
    end,
  }, function(choice)
    if not choice then
      return
    end
    if choice == 'Create New Test' then
      return create_test(test_dir, filetype, extension, basename)
    end
    vim.cmd.edit(vim.fn.fnameescape(choice))
  end)
end

return M
