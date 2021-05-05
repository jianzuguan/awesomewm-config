
local awful = require("awful")

local hotkeys_popup = require("awful.hotkeys_popup")

local config = require('config')

local terminal = config.terminal
local editor_cmd = terminal .. " -e " .. config.editor


return {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}
