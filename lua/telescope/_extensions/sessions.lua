local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local config = require('telescope.config').values
local yasm = require('yasm.yasm')

local function sessions(opts)

  opts = vim.tbl_deep_extend('force', require("telescope.themes").get_dropdown(), opts or {})

  local session_dir = require('yasm.config').options.session_dir

  local cmd = { 'rg', '^cd (.+)', '-r', '$1', '.' }
  local finder = finders.new_oneshot_job(cmd, {
    cwd = session_dir,
    entry_maker = function(entry)
      for name, dir in string.gmatch(entry, '%./(.+)%.session:(.+)') do
        return {
          value = {
            name = name,
            file = name .. '.session',
            cwd = dir,
          },
          display = name .. ' (' .. dir .. ')',
          ordinal = name,
        }
      end
    end,
  })

  pickers.new(opts, {
    prompt_title = 'Sessions',
    finder = finder,
    sorter = config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)

      local delete_session = function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        yasm.delete_session(selection.value.name)
      end

      map('n', 'd', delete_session)
      map('i', '<C-d>', delete_session)

      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        yasm.load_session(selection.value.name)
      end)

      return true
    end,
  }):find()
end

return telescope.register_extension({
  exports = { sessions = sessions }
})
