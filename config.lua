
local terminal = "konsole"
local editor = os.getenv("EDITOR") or "editor"
local editor_cmd = terminal .. " -e " .. editor

local modkey = "Mod4"
local altKey = 'Mod1'

return {
    terminal = terminal,
    editor = editor, 
    editor_cmd = editor_cmd,
    modkey = modkey,
    altKey = altKey
}