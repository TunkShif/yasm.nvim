local config = require('yasm.config')
local M = {}

local session_dir = config.options.session_dir

function M.file_readable(path)
  return vim.fn.filereadable(vim.fn.expand(path)) == 1
end

function M.get_session_file(name, opts)
  opts = opts or { escaped = true}
  local filename = session_dir .. '/' .. name .. '.session'
  if opts.escaped then
    return vim.fn.fnameescape(filename)
  else
    return filename
  end
end

-- delete unlisted and unmodified buffers
-- usually these are used as utilities like
-- NvimTree, SymbolOutline or something else
function M.delete_unused_buffer()
  local bufs = vim.api.nvim_list_bufs()
  local buf_option = vim.api.nvim_buf_get_option

  for _, buf in ipairs(bufs) do
    if not buf_option(buf, 'buflisted') or not buf_option(buf, 'modifiable') then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

-- delete all buffers except NvimTree
-- because delete NvimTree buffer may raise problem
function M.delete_all_buffers()
  local bufs = vim.api.nvim_list_bufs()
  local buf_option = vim.api.nvim_buf_get_option

  for _, buf in ipairs(bufs) do
    if buf_option(buf, 'filetype') ~= 'NvimTree' then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

-- check if any buffer has unsaved cahnges
function M.check_unsaved_buffer()
  local bufs = vim.api.nvim_list_bufs()
  local buf_option = vim.api.nvim_buf_get_option

  for _, buf in ipairs(bufs) do
    if buf_option(buf, 'modified') then
      return true
    end
  end

  return false
end

return M
