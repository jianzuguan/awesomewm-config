
local awful = require("awful")
local beautiful = require("beautiful")

local mainMenu = require('menu.mainMenu')

return awful.widget.launcher({ image = beautiful.awesome_icon, menu = mainMenu })
