---@class JsdocKeys
---@field toggle? string
---@field checkStart? string
---@field checkEnd? string

---@class JsdocSwitchConfig
---@field keys JsdocKeys?
---@field auto_set_keys boolean?

local C = {
    keys = {
        toggle = "<leader>jsd",
        checkStart = "<leader>jss",
        checkEnd = "<leader>jse",
    },
    auto_set_keys = true,
    notify = true
}


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
---         notify = true
---     }
---<
---@brief ]]

--- Creates the configuration by merging user_config the default jsdoc-switch config
---@param user_opts JsdocSwitchConfig
---@see jsdoc-switch.setup
---@usage `require('jsdoc-switch.config').merge_user_opts()`
function C.merge_user_opts(user_opts)
    for k, v in pairs(user_opts) do
        if k == "keys" then
            for kk, kv in pairs(v) do
                C[k][kk] = kv
            end
        else
            C[k] = v
        end
    end
end

return C
