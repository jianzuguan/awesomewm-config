
local gears = require("gears")
local awful = require("awful")


local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")


local config = require('config')
local terminal = config.terminal
local modKey = config.modkey
local altKey = config.altKey

globalkeys = gears.table.join(
    awful.key({modKey},             "s",            hotkeys_popup.show_help,                                { description = "show help", group = "awesome" }), 
    awful.key({modKey},             "Left",         awful.tag.viewprev,                                     { description = "view previous", group = "tag" }), 
    awful.key({modKey},             "Right",        awful.tag.viewnext,                                     { description = "view next", group = "tag" }), 
    awful.key({modKey},             "Escape",       awful.tag.history.restore,                              { description = "go back", group = "tag" }), 
    awful.key({modKey},             "j",            function() awful.client.focus.byidx(1) end,             { description = "focus next by index", group = "client" }), 
    awful.key({modKey},             "k",            function() awful.client.focus.byidx(-1) end,            { description = "focus previous by index", group = "client" }), 
    awful.key({modKey},             "w",            function() mainMenu:show() end,                         { description = "show main menu", group = "awesome" }), 
    awful.key({modKey, "Shift"},    "j",            function() awful.client.swap.byidx(1) end,              { description = "swap with next client by index", group = "client" }), 
    awful.key({modKey, "Shift"},    "k",            function() awful.client.swap.byidx(-1) end,             { description = "swap with previous client by index", group = "client" }), 
    awful.key({modKey, "Control"},  "j",            function() awful.screen.focus_relative(1) end,          { description = "focus the next screen", group = "screen" }), 
    awful.key({modKey, "Control"},  "k",            function() awful.screen.focus_relative(-1) end,         { description = "focus the previous screen", group = "screen" }), 
    awful.key({modKey},             "u",            awful.client.urgent.jumpto,                             { description = "jump to urgent client", group = "client" }), 
    awful.key({modKey},             "Tab", 
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise() 
            end 
        end, 
        { description = "go back", group = "client" }
    ), 
    awful.key({modKey},                 "Return",  function() awful.spawn(terminal) end,                  { description = "open a terminal", group = "launcher" }), 
    awful.key({modKey, "Control"},      "r",       awesome.restart,                                       { description = "reload awesome", group = "awesome" }), 
    awful.key({modKey, "Shift"},        "q",       awesome.quit,                                          { description = "quit awesome", group = "awesome" }), 
    awful.key({modKey},                 "l",       function() awful.tag.incmwfact(0.05) end,              { description = "increase master width factor", group = "layout" }), 
    awful.key({modKey},                 "h",       function() awful.tag.incmwfact(-0.05) end,             { description = "decrease master width factor", group = "layout" }), 
    awful.key({modKey, "Shift"},        "h",       function() awful.tag.incnmaster(1, nil, true) end,     { description = "increase the number of master clients", group = "layout" }), 
    awful.key({modKey, "Shift"},        "l",       function() awful.tag.incnmaster(-1, nil, true) end,    { description = "decrease the number of master clients", group = "layout" }), 
    awful.key({modKey, "Control"},      "h",       function() awful.tag.incncol(1, nil, true) end,        { description = "increase the number of columns", group = "layout" }), 
    awful.key({modKey, "Control"},      "l",       function() awful.tag.incncol(-1, nil, true) end,       { description = "decrease the number of columns", group = "layout" }), 
    awful.key({modKey},                 "space",   function() awful.layout.inc(1) end,                    { description = "select next", group = "layout" }), 
    awful.key({modKey, "Shift"},        "space",   function() awful.layout.inc(-1) end,                   { description = "select previous", group = "layout" }), 
    awful.key({modKey, "Control"},      "n",             
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", {
                    raise = true
                }) 
            end 
        end, { description = "restore minimized", group = "client" }), 
    awful.key({altKey},             "space", function() awful.spawn('rofi -combi-modi window,drun -show combi -modi combi') end,     { description = "run prompt", group = "launcher" }), 
    awful.key({modKey},                 "x", 
        function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval" 
            } 
        end, 
        { description = "lua execute prompt", group = "awesome" }
    ), 
    awful.key({modKey}, "p", function() menubar.show() end, { description = "show the menubar", group = "launcher" })
)


for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modKey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key({ modKey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key({ modKey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key({ modKey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end


root.keys(globalkeys)