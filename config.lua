
local terminal = "x-terminal-emulator"
local editor = os.getenv("EDITOR") or "editor"
local editor_cmd = terminal .. " -e " .. editor

local modkey = "Mod4"

return {
    terminal = terminal,
    editor = editor, 
    editor_cmd = editor_cmd,
    modkey = modkey
}