local config = require('yasm.config')
local yasm = require('yasm.yasm')

local M = {
  setup = config.setup,
  save_session = yasm.save_prompt,
  delete_session = yasm.delete_session
}

return M
