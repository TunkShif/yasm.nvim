local M = {}

local data_path = vim.fn.stdpath('data')

M.options = {
  session_dir = data_path .. '/sessions',
  auto_save = true
}

function M.setup(options)
  M.options = vim.tbl_deep_extend('force', M.options, options or {})

  if vim.fn.isdirectory(M.options.session_dir) ~= 1 then
    vim.fn.mkdir(M.options.session_dir)
  end

end

return M

