function love.load()
    -- Require the library classic for classes 
    Object = require "classic"
    -- Tick library for delays
    tick = require "tick"
    -- Lume library for saving and loading the game
    lume = require "lume"
    -- Require the files of the game
    require "wall"
    require "player"
    require "bug"
    require "menu"
    require "game"
    require "button"

    -- Load the font of the game to a new font from kenny.nl 
    font = love.graphics.newFont("kenvector_future.ttf", 15)
    -- Set the font to be used
    love.graphics.setFont(font)
    -- The Menu background
    background = love.graphics.newImage("background2.jpeg")
    -- The game background
    gameBackground = love.graphics.newImage("hannah-oates-brick-wall-wip.jpg")
    -- Set the current state of the game to be menu when loading the game
    currentState = "menu"
    -- Load the menu
    menuLoad()
end

function love.update(dt)
    -- Update the tick with the delta time
    tick.update(dt)

    -- Check if the the state of the game is multi or single before updating
    if currentState == "game" or currentState == "multi" then
        gameUpdate(dt)
    end
end

function love.draw()
    -- Check if the state is single or multi then draw the game background and the game itself
    if currentState == "game"  or currentState == "multi" then
        love.graphics.draw(gameBackground, 0, 0,0,1.5,1.5)
        gameDraw()
    -- If the state is menu draw it
    elseif currentState == "menu" then
        love.graphics.draw(background, 0, 0)
        menuDraw()
    end

end

-- Listen for keypresses
function love.keypressed(key)
    -- Check if the key pressed is ESC 
    if key == "escape" then
        -- Change the state to menu and load it again to play the theme song and stop the game's one
        currentState = "menu"
        menuLoad()
        -- Set the message to "escape so the menuDraw fn knows to draw the main menu"
        M = "escape"
    elseif key == "g" then
        -- Change the state to single player mood and load the game to be drawn in love.draw
        currentState = "game"
        gameLoad()
    elseif key == "m" then
        -- Change the state to multiplayer and load the game
        currentState = "multi"
        gameLoad()
    -- Check if any movement key is pressed and the game mode is in multi or single and call the gameKeypressed with the key pressed 
    elseif (key == "up" or key == "down" or key == "right" or key == "left" or key == "w" or key == "s" or key == "a" or key == "d") and (currentState == "game" or currentState == "multi") then
        gameKeypressed(key) 
    end

    -- If F1  is pressed delete the savedata file that contains the high score and the scores
    if key == "f1" then
        love.filesystem.remove("savedata.txt")
    end
end