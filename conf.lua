-- this file overwrites the love configurations
-- it get passeed one argument which is a table filled with the defualt values we want to overwrite
function love.conf(t)
    -- set the title of the windowscreen to be "Maze Chase!"
    t.window.title = "Maze Chase!"
    -- set the game icon to be the ghost image
    t.window.icon = "tile_0121.png"

    -- disable the modules that we don't need to reduce the startup time slightly
    t.modules.physics = false
    t.modules.joystick = false
    t.modules.touch = false
    t.modules.video = false
end