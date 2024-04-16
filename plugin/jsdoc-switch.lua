local user_cmd = vim.api.nvim_create_user_command
local switch = require("jsdoc-switch")

---@mod jsdoc-switch.usercmds UserCommands
---@brief [[
--- jsdoc-switch provides you with the following commands
--->
---     'JsdocSwitchToggle' - Toggles the current state of JSDoc checking
---     'JsdocSwitchStart'  - Turns JSDoc checking on
---     'JsdocSwitchStop'   - Turns JSDoc checking off
---<
---@brief ]]

user_cmd("JsdocSwitchToggle", switch.toggle, {})
user_cmd("JsdocSwitchStart", switch.startJsdoc, {})
user_cmd("JsdocSwitchStop", switch.stopJsdoc, {})
