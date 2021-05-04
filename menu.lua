
local awful = require("awful")
local beautiful = require("beautiful")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local config = require('config')

local terminal = config.terminal
local editor_cmd = terminal .. " -e " .. config.editor

local modkey = config.modkey

myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                    menu = mymainmenu })

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

mykeyboardlayout = awful.widget.keyboardlayout()

