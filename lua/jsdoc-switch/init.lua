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
--- The `setup()` function must be called to create the default keymaps when the plugin
--- loads. This can be overridden by passing your custom config which will be merged with
--- the default configuration
---@brief ]]

local M = {}
local helpers = require("jsdoc-switch.helpers")


--- Sets up the plugin according to provided configuration
---@param user_config? JsdocSwitchConfig
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
---     vim.keymap.set('n', '<leader>jsn', function()
---         switch.stopJsdoc()
---         print('Goodbye JSDoc')
---     end)
---     -- and so on for the other functions
---<
---@usage ]]
function M.setup(user_config)
    local ok, _ = pcall(require, 'lspconfig')
    if not ok then
        print("This plugin requires nvim-lspconfig")
        return
    end

    local config = require("jsdoc-switch.config").make_config(user_config or {})

    if config.auto_set_keys then
        local toggleKey = config.keys.toggle
        local startKey = config.keys.checkStart
        local endKey = config.keys.checkEnd
        helpers.jsdoc_key(startKey, true)
        helpers.jsdoc_key(endKey, false)
        helpers.jsdoc_key(toggleKey)
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
