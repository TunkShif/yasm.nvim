local utils = require('yasm.utils')

local M = {}

M.current_session = {
  name = '',
  cwd = '',
}

function M.save_session(name)
  utils.delete_unused_buffer()
  local filename = utils.get_session_file(name)
  vim.api.nvim_command('mksession! ' .. filename)

  print(name .. '.session saved!')
end

function M.load_session(name)
  local filename = utils.get_session_file(name)

  if not utils.file_readable(filename) then
    print('Cannot reach the session file')
    return
  end

  if utils.check_unsaved_buffer() then
    print('You have unsaved changes, loading session cancelled.')
    return
  end

  utils.delete_all_buffers()
  vim.api.nvim_command('silent source ' .. filename)

  M.current_session.name = name
  M.current_session.cwd = vim.fn.getcwd()
end

function M.delete_session(name)
  local filename = utils.get_session_file(name, { escaped = false })
  if utils.file_readable(filename) then
    vim.fn.delete(filename)
    print(name .. '.session deleted!')
    return
  end
  print('Session file not found!')
end

function M.save_prompt()
  local name = vim.fn.input('Session name: ')

  if #name == 0 then
    print('Name cannot be empty!')
    return
  end

  if utils.file_readable(utils.get_session_file(name, { escaped = false })) then
    local choice = vim.fn.input('Session already exists, overwrite it? (y/n) ')
    if not choice:match('^y') then
      return
    end
  end

  M.save_session(name)
end

return M
