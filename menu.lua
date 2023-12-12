function menuLoad()
    -- Check if the menu song is not playing already or if it is intialized
    if menuSong == nil or not menuSong:isPlaying() then
        -- if the game song is playing then stop it
        if song then
            song:stop()
        end
        -- Set the menusong
        menuSong = love.audio.newSource("2. Bim Bom Bomp.wav", "stream")
        -- Make it loop 
        menuSong:setLooping(true)
        -- Lower the volume
        menuSong:setVolume(0.3)
        -- Play it
        menuSong:play()
    end

    -- Set a click sound for the buttons
    click = love.audio.newSource("switch_006.ogg", "static")

    -- Set the buttons of the menu
    button = Button(110, "Single player")
    button2 = Button(210, "Multiplayer")
    button3 = Button(310, "Zoom In/Out")
    button4 = Button(410, "Quit")
    -- Pass this button the message to be it's text, it will be winning or losing
    button5 = Button(5, M)
end

function menuDraw()
    -- If the message was escape of if it was empty then draw the main menu
    if M == "escape"  or M == nil then
        love.graphics.print("This is Maze Chase", love.graphics.getWidth()/2, 0, 0, 1, 1, font:getWidth("This is Maze Chase")/2)
        love.graphics.print("Press 'ESC' for menu, 'M' to generate randonm multiplayer maze \n'G' to generate random single player maze, 'F1' to delete players data.", 10, 40, 0, 1, 1)
        love.graphics.print("Chaser moves with 'WASD' keys, Runner with ARROWs.", 10, 80, 0, 1, 1)
        button:buttonDraw()
        button2:buttonDraw()
        button3:buttonDraw()
        button4:buttonDraw()
    else 
        -- This is the menu of winning or losing screen
        button5:buttonDraw()
        button:buttonDraw()
        button2:buttonDraw()
    end
end

-- love callback to listen for mouse movement
function love.mousemoved(x, y)
    -- Check first if the mouse movment is in the menu
    if currentState == "menu" then
        -- check collision of the mouse with each button
        if x > button.x and x < button.x + button.width and y > button.y and y < button.y + button.height then
            -- change the button image displayed to the hover image button
            button.image = button.hovoerImage
        else
            -- restart the image to the default
            button.image = button.defualtImage
        end

        if x > button2.x and x < button2.x + button2.width and y > button2.y and y < button2.y + button2.height then
            -- change the button image displayed to the hover image button
            button2.image = button2.hovoerImage
        else
            -- restart the image to the default
            button2.image = button2.defualtImage
        end

        if x > button3.x and x < button3.x + button3.width and y > button3.y and y < button3.y + button3.height then
            -- change the button image displayed to the hover image button
            button3.image = button3.hovoerImage
        else
            -- restart the image to the default
            button3.image = button3.defualtImage
        end

        if x > button4.x and x < button4.x + button4.width and y > button4.y and y < button4.y + button4.height then
            -- change the button image displayed to the hover image button
            button4.image = button4.hovoerImage
        else
            -- change the button image displayed to the hover image button
            button4.image = button4.defualtImage
        end
    end
end

function love.mousepressed(x, y, buttonclicked)
        -- Check first if the mouse movment is in the menu
    if currentState == "menu" then
        -- if button is clicked and the mouse is on that button 
        if buttonclicked == 1 and x > button.x and x < button.x + button.width and y > button.y and y < button.y + button.height then
            -- change the button image to the clicked button image and set the button scale a little smaller then play the click sound effect
            button.image = button.clickImage
            -- button.isClicked = true
            button.sx = 0.97
            button.sy = 0.97
            click:play()
        end
        if buttonclicked == 1 and x > button2.x and x < button2.x + button2.width and y > button2.y and y < button2.y + button2.height then
            button2.image = button2.clickImage
            -- button2.isClicked = true
            button2.sx = 0.97
            button2.sy = 0.97
            click:play()
        end

        if buttonclicked == 1 and x > button3.x and x < button3.x + button3.width and y > button3.y and y < button3.y + button3.height then
            button3.image = button3.clickImage
            -- button3.isClicked = true

            -- If zoom is not true then the game is zoomed out and when the button is clicked switch it back to zoom in and change zoom to be true
            if zoom ~= true then
                zoom = true
                button3.text = "Zoom In"
            else
                -- if it is true then switch it back 
                zoom = false
                button3.text = "Zoom Out"
            end
            button3.sx = 0.97
            button3.sy = 0.97
            click:play()
        end

        if buttonclicked == 1 and x > button4.x and x < button4.x + button4.width and y > button4.y and y < button4.y + button4.height then
            button4.image = button4.clickImage
            -- button4.isClicked = true
            button4.sx = 0.97
            button4.sy = 0.97
            click:play()
        end

        
    end
end

function love.mousereleased(x, y, buttonReleased)
    -- when the menu is displayed
    if currentState == "menu" then
        -- check for button releases
        if buttonReleased == 1 and x > button.x and x < button.x + button.width and y > button.y and y < button.y + button.height then
            -- switch back from the click image to the hover image 
            button.image = button.hovoerImage
            -- reset the scale of the button size
            button.sx = 1
            button.sy = 1
            -- after the button is released load the game but delay it so that the click animation is visable
            tick.delay(function ()
                currentState = "game"
                gameLoad()
            end, 0.1)
        end
        
        if buttonReleased == 1 and x > button2.x and x < button2.x + button2.width and y > button2.y and y < button2.y + button2.height then
            button2.image = button2.hovoerImage
            button2.sx = 1
            button2.sy = 1
            tick.delay(function ()
                currentState = "multi"
                gameLoad()
            end, 0.1)
        end

        if buttonReleased == 1 and x > button3.x and x < button3.x + button3.width and y > button3.y and y < button3.y + button3.height then
            button3.image = button3.hovoerImage
            button3.sx = 1
            button3.sy = 1
        end

        if buttonReleased == 1 and x > button4.x and x < button4.x + button4.width and y > button4.y and y < button4.y + button4.height then
            button4.image = button4.hovoerImage
            button4.sx = 1
            button4.sy = 1
            -- quit the game
            tick.delay(function ()
                love.event.quit()
            end, 0.1)
        end

    end
end