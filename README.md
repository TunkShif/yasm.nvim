# Yet Another Session Manager [WIP]
 
The name just says it all, `yasm.nvim` is just another simple session manager plugin which make use of the native vim session.

It is built on top of [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) plugin to make it easier to switch between diffrent sessions.

## Previews

[![asciicast](https://asciinema.org/a/a98ERu7t17FkumiOw2h2olqVl.svg)](https://asciinema.org/a/a98ERu7t17FkumiOw2h2olqVl)

switch between diffrent sessions

[![asciicast](https://asciinema.org/a/sy1v3CX2Gsoa6yru3kup7xR9A.svg)](https://asciinema.org/a/sy1v3CX2Gsoa6yru3kup7xR9A)

create and delete sessions

## Requirements

- Neovim `> 0.5`
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

## Get Started

### Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'TunkShif/yasm.nvim'
```

### Setup

`yasm.nvim` does not come with default key mappings, you have to set it up mannualy.

```lua
require('yasm').setup {
  -- optional session directory settings
  -- default to `stdpath('data')/sessions`
  session_dir = "/path/to/your/session_dir"
}

require('telescope').load_extension('sessions')

vim.cmd [[
nnoremap <Leader>ss <CMD>lua require('yasm').save_session()<CR>
nnoremap <Leader>sl <CMD>Telescope sessions<CR>
]]
```

In the telescope popup window, you can use `d` in NORMAL mode or `C-d` in INSERT mode to delete the selected session.

## Disclaimer

This is my first time trying to write (n)vim plugin. The porject is still under development, so it may be bug-prone.

## Inspritions/Similar Projects

- [neovim-session-manager](https://github.com/Shatur/neovim-session-manager)
- [project.nvim](https://github.com/ahmedkhalf/project.nvim)

