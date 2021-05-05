
local awful = require("awful")
local beautiful = require("beautiful")

local awesomeMenu = require('menu.awesomeMenu')

local terminal = require('config').terminal


return awful.menu({ 
    items = { 
        { "awesome", awesomeMenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})
