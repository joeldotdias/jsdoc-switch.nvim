# jsdoc-switch.nvim

A tiny plugin for toggling jsdoc checking while preserving the rest of your configuration (pretty sure about the latter part)

## Why
I like JSDoc but not all the time. Needed a way to quickly turn it on or off based on the task I was doing.

## Table of Contents
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Configuration](#configuration)

## Getting Started
- Requires [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig). `tsserver` must be installed and setup
- With [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    'joeldotdias/jsdoc-switch.nvim',
    ft = { -- Add or remove filetypes from this section depending on your requirements
        'javascript',
        'javascriptreact'
    },
    config = function()
        require('jsdoc-switch').setup() -- setup() must be called to create default keymaps
    end
}
```

<details>
<summary>With <a href="https://github.com/wbthomason/packer.nvim">packer.nvim</a></summary>

```lua
use {
    'joeldotdias/jsdoc-switch.nvim',
    ft = { -- Add or remove filetypes from this section depending on your requirements
        'javascript',
        'javascriptreact'
    },
    config = function()
        require('jsdoc-switch').setup() -- setup() must be called to create default keymaps
    end
}
```
</details>

## Usage
The plugin provides you with the following default keymaps
```lua
`<leader>jsd` => Toggles JSDoc checking on or off based on the current state
`<leader>jss` => Turns on JSDoc checking
`<leader>jse` => Turns off JSDoc checking
```

## Configuration
- jsdoc-switch comes with the following defaults
```lua
{
    --
    keys = {
        toggle = "<leader>jsd",
        checkStart = "<leader>jss",
        checkEnd = "<leader>jse"
    },
    auto_set_keys = true -- Creates keymaps automatically when plugin is loaded
}
```

- Keymaps can be modified by passing them to the setup function
```lua
require('jsdoc-switch').setup({
    keys = {
        checkEnd = "<leader>jse
        -- Change the keymaps as you please
    }
})
```

- If you wish to create functions for yourself, set auto_set_keys to false and use the following functions
- toggle()
- startJsdoc()
- stopJsdoc()

**Example config**
```lua
local switch = require('jsdoc-switch')
vim.keymap.set('n', '<leader>jsh', function()
    switch.startJsdoc()
    print("Well, hello JSDoc")
end)
-- In this case, keymaps will have to be manually set for other functions as well
```

**P.S.** This is not an elegant plugin in any way but it works. Could be helpful for anyone not wanting to use JSDoc all the time or wanting to try out how it feels.

If this plugin helped you, give it a ⭐ so my grandma thinks I'm cool
