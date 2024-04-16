local user_cmd = vim.api.nvim_create_user_command
local switch = require("jsdoc-switch")

user_cmd("JsdocSwitchToggle", switch.toggle, {})
user_cmd("JsdocSwitchStart", switch.startJsdoc, {})
user_cmd("JsdocSwitchStop", switch.stopJsdoc, {})
