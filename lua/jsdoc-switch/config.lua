local C = {}

---@class JsdocKeys
---@field toggle? string
---@field checkStart? string
---@field checkEnd? string

---@class JsdocSwitchConfig
---@field keys JsdocKeys?
---@field auto_set_keys boolean?

---@mod jsdoc-switch.config Configuration
---@brief [[
--- Given below is the default config for |jsdoc-switch.setup|. To modify this with
--- your custom config, change the options according to your needs and send it to
--- the `setup()` function.
--->
---     {
---         keys = {
---             toggle = "<leader>jsd",
---             checkStart = "<leader>jss",
---             checkEnd = "<leader>jse",
---         },
---         auto_set_keys = true,
---     }
---<
---@brief ]]


--- Returns the default jsdoc-switch config
---@usage `require('jsdoc-switch.config').get_default_config()`
function C.get_default_config()
    return {
        keys = {
            toggle = "<leader>jsd",
            checkStart = "<leader>jss",
            checkEnd = "<leader>jse",
        },
        auto_set_keys = true,
    }
end

--- Creates the configuration by merging user_config the default jsdoc-switch config
---@see jsdoc-switch.setup
---@usage `require('jsdoc-switch.config').make_config()`
function C.make_config(user_config)
    local default_config = C.get_default_config()
    for k, v in pairs(user_config) do
        if k == "keys" then
            for kk, kv in pairs(v) do
                default_config[k][kk] = kv
            end
        else
            default_config[k] = v
        end
    end

    return default_config
end

return C
