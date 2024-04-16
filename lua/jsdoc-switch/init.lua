---@brief [[
---                                 *jsdoc-switch*
---                     Toggle JSDoc checking on and off at will
---@brief ]]

---@toc jsdoc-switch.contents

---@mod jsdoc-switch-nvim Introduction
---@brief [[
--- JSDoc is a solid alternative to typescript when you want to avoid an additional
--- build step and write regular javascript. However, you might not want to use this
--- this all the time. While your program still runs, the lsp warnings tend to get
--- annoying when checking isnt even required. Manually changing the settings in the
--- config file is also not a viable option. This was the motivation behind this
--- plugin. It lets you turn on or off and toggle the current JSDoc config while
--- preserving the rest of your server config.
---@brief ]]

---@mod jsdoc-switch.setup Setup
---@brief [[
--- The `setup()` function must be called to create the default keymaps (unless specified
--- otherwise) when the plugin loads. This can be overridden by passing your custom config
--- which will be merged with the default configuration
---@brief ]]

local M = {}
local helpers = require("jsdoc-switch.helpers")

--- Sets up the plugin according to provided configuration
---@param opts? JsdocSwitchConfig
---@see jsdoc-switch.config
---@usage [[
--- To use the default config, simply call the setup function
--- require('jsdoc-switch').setup()
---
--- In case you want to pass custom config, there are two options
--- `1. Custom keymaps`
--- Send your own choice of keymaps to the setup function
--->
---     require('jsdoc-switch').setup({
---         keys = {
---             toggle = '<leader>jsm',
---             checkStart = '<leader>jso',
---             checkEnd = '<leader>jsn'
---         }
---     })
---<
---
--- This will override the default keymaps with the ones provided by you. If a keymap
--- isnt provided the default keymap for that function will be used
---
--- `2. Custom functions`
--- You can use the toggle(), startJsdoc() and stopJsdoc() functions to write your own
--- custom functions to further modify any behaviour when the state is toggled. To do
--- this, set auto_set_keys to false. Note that in this case all keymaps have to be set
--- manually
--->
---     local switch = require('jsdoc-switch')
---     switch.setup({
---         auto_set_keys = false
---     })
---     vim.keymap.set('n', '<leader>jsn', function()
---         switch.stopJsdoc()
---         print('Goodbye JSDoc')
---     end)
---     --------------- OR -----------------------
---     -- use the commands provided
---     vim.keymap.set('n', '<leader>jdt', '<cmd>JsdocSwitchToggle<CR>')
---     -- see |jsdoc-switch.usercmds|
---     -- and so on for the other functions
---<
---@usage ]]
function M.setup(opts)
    local config = require("jsdoc-switch.config")
    config.merge_user_opts(opts or {});

    if config.auto_set_keys then
        helpers.jsdoc_key(config.keys.checkStart, true)
        helpers.jsdoc_key(config.keys.checkEnd, false)
        helpers.jsdoc_key(config.keys.toggle)
    end
end

--- This stops JSDoc checking
---@usage `require('jsdoc-switch').stopJsdoc()`
function M.stopJsdoc()
    helpers.switch(false)
end

--- This starts JSDoc checking
---@usage `require('jsdoc-switch').startJsdoc()`
function M.startJsdoc()
    helpers.switch(true)
end

--- This toggles the current state of JSDoc checking
---@usage `require('jsdoc-switch').toggle()`
function M.toggle()
    helpers.switch()
end

return M
