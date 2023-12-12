function gameLoad()
    -- stop any audio that is playing
    love.audio.stop()
    -- set the game's song 
    song = love.audio.newSource("Epic-Chase(chosic.com).mp3", "stream")
    -- make it loop
    song:setLooping(true)
    -- lower the volume
    song:setVolume(0.3)
    -- play the song
    song:play()

    -- load a new canvas with width 400 and height 600  for the multiplayer
    if currentState == "multi" then
        screenCanvas = love.graphics.newCanvas(400,600)
    end
    
    -- set the wall and ground
    wall = Wall("obsidian.jpg")
    ground = Wall("tile_0034.png")

    -- will use it to execute a block of code only once later in the file
    codeExecuted = false
    -- a delay for the game so that the treasure animation is displayed
    delay = 0.5

    -- check if there is a save file and if so load it
    if love.filesystem.getInfo("savedata.txt") then
        -- read the file
        file = love.filesystem.read("savedata.txt")
        -- the data is string so deserialize it so that the programe understands it
        data = lume.deserialize(file)
        
        -- load player one and two scores
        p1Score = data.p1Score
        -- the lives and highscore of player1
        HighScore = data.HighScore
        lives = data.lives
        
        -- load the multiplayer data
        -- player one lives, score and lives  for multi 
        p1MultiScore = data.p1MultiScore
        MultiLives = data.MultiLives
        MultiHighScore = data.MultiHighScore
        -- player two lives, score and high score
        p2Score = data.p2Score
        p2Lives = data.p2Lives
        p2HighScore = data.p2HighScore

    -- if there was no file  
    else
        -- set the lives to 10 and the rest is zero by default
        p1Score = 0
        p2Score = 0
        HighScore = 0
        lives = 10

        p1MultiScore = 0
        MultiLives = 10
        MultiHighScore = 0
        p2Lives = 10
        p2HighScore = 0
    end

    -- this was the first maze that i made by hand but left if out and made the random generated maze
    -- map = {
    --     {1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1},
    --     {1,1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,0,1},
    --     {1,1,0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,1,0,1},
    --     {1,1,0,1,1,1,1,1,0,1,0,1,1,0,0,0,0,0,0,1},
    --     {1,0,0,0,0,1,1,1,0,1,0,1,1,1,1,1,1,0,0,1},
    --     {1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1},
    --     {1,0,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
    --     {1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,0,0,1,1},
    --     {1,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,1,0,0,1},
    --     {1,0,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,0,1,1},
    --     {1,0,1,1,1,1,1,0,1,0,1,1,1,0,0,1,1,0,0,1},
    --     {1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,1},
    --     {1,0,0,0,0,1,1,1,1,0,1,0,1,1,1,1,1,1,1,1},
    --     {1,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
    --     {1,0,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,0,0,1},
    --     {1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1},
    --     {1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,1},
    --     {1,0,0,0,1,1,0,0,0,0,1,1,0,1,1,0,0,0,0,1},
    --     {1,0,1,1,1,1,0,1,1,1,1,1,0,0,0,0,1,1,1,1},
    --     {1,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1},
    --     {1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,1,0,1,1,1},
    --     {1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1}
    -- }

    -- the map table and made it so that 1 is wall and will set 0 to be a path
    map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    -- set the index that the finish of the maze will be at to be a random number from 2 to the length of the map -1 so that that it is not a border
    index = love.math.random(2,#map[1]-1)
    -- set the location of the spider that chases you on the finsh
    bugx = index
    bugy = 1
    -- set the finsh block to be 0 
    map[1][index] = 0
    -- get down one row in the maze which is row 2  and start from there
    i= 2
    -- set a previous location so that we don't go back and forth
    -- previndex = index
    -- previ = 2

    -- the function that generates the maze randomly every time it is called
    mazeGenerate(i, index, previ)
    
    -- check if the game is single player 
    if currentState == "game" then
        -- initialize the player and set his position to the start of the maze from the mazegenerate fn
        player = Player(playerx, playery, "tile_0111.png")
        -- make the bugs that chase the player and set one close to the player
        bug = Bug(player.xposition, player.yposition, "tile_0121.png")
        -- the other one set it to the location of the finish but  when it comes to the hight i substituted two blocks from the bug class adds two blocks heiht to make the first bug away from the player 
        bug2 = Bug(bugx * wall.width, (bugy * wall.height) - (2*bug.height), "tile_0122.png")
    -- if the game is multiplayer
    elseif currentState == "multi" then
        -- make two players, a chaser and runnner
        -- make the runner ahead of the chaser by one block height
        player = Player(playerx, playery - 1, "tile_0111.png")
        player2 = Player(playerx, playery, "tile_0121.png")
    end

    -- make the treasure and set it at the end of the maze
    treasure = Bug(bugx * wall.width, (bugy * wall.height)-2*wall.height, "tile_0089.png")

    -- a frames table to store the animation of opening the chest
    frames = {}
    -- add the four frames to the frames table
    for i = 1, 4 do
        table.insert(frames, love.graphics.newImage("tile_00"..88+i..".png"))
    end
    -- set the current frame to be the first which is the closed one
    currentFrame = 1
    
    -- a delay timer for the bug that chases the player 
    delayTimer = 1

    -- a boolean variable to make the entities move or stop depending on the winning or losing
    run = true
end

function gameUpdate(dt)
    -- if it is true update the delay var 
    if codeExecuted == true then
        -- if the delay is more that 0
        if delay > 0 then
            -- substract the dt from it 
            delay = delay - dt
        end
    end

    -- update the delay of the bug so that it starts moving
    if delayTimer > 0 then
        delayTimer = delayTimer - dt
    end
    
    -- only if run is true update the movement of the bugs
    -- if the run is false which will be when the player wins, the bugs will stop moving
    if run == true then
        if delayTimer <= 0 then
            -- update the bugs if the game is single
            if currentState == "game" then
                bug:update(dt, player)
                bug2:update(dt, player)
            end
        end
    end

    -- if the palyer reaches the treasure then start updating it's animation frames
    if treasure:checkCollision(player) then
        -- update the frames of the treasure by 6 frames per second
        currentFrame = currentFrame + 6 * dt 
        -- if the frame is more than 5 reset it to 1 so that we one
        -- the reson why i set the condition to be more than 5 and not 4 is when i use math.floor ont he frame table the value needs to be more than 4 to set it  
        if currentFrame > 5 then
            currentFrame = 1
        end
    end
end

function gameDraw()
    -- if the game is multi draw the two players and make the canvas of the runner start x 400 to be on the right half of the screen
    if currentState == "multi" then
        draw(player, 400)
        draw(player2)
    -- else draw the single player game
    elseif currentState == "game" then
        -- push the upcoming graphics until the pop()
        love.graphics.push()

        --if the zoom is true  
        if zoom == true then
            -- scale the game by 4 and devide the translation by 4 
            love.graphics.scale(4)
            -- make the player in the middle of the screen
            love.graphics.translate(-(player.xposition)+ 100, -(player.yposition)+ 75)
        end
    
        -- iterate through the map
        for i,v in ipairs(map) do
            for j,k in ipairs(v) do
                -- if the current position is 1 then draw a wall
                if k == 1 then
                    love.graphics.draw(wall.image, wall.width * (j), wall.height * (i))
                else
                    -- if it is 0 then draw a ground
                    love.graphics.draw(ground.image, ground.width * j, ground.height * i)
                end
            end
        end

        -- draw the player at the start of the game
        love.graphics.draw(player.image, player.width * player.tileX, player.height * player.tileY)
        
        if currentState == "game" then
            -- draw the bugs
            bug:draw()

            bug2:draw()
        end

        -- draw treasure
        treasure:draw()
        
        -- if the player reaches the treasure 
        if treasure:checkCollision(player) then
            -- start playing the treasure frames 
            love.graphics.draw(frames[math.floor(currentFrame)], treasure.x, treasure.y)
            -- stop any movment of the game
            run = false
            -- set this block of code to be executed and start to coundown the delay until the treasure animation is played
            codeExecuted = true
            -- if the delay is finished
            if delay < 0 then
                -- increase the player score by 1
                p1Score = p1Score + 1
                -- if the current score is higher than the high score 
                if HighScore < p1Score then
                    -- set the new high score
                    HighScore = p1Score
                end
                -- save the new data
                savegame()
                -- this is not important
                M = "YOU WON!"
                -- love.audio.stop()
                -- load the game again to change the maze
                gameLoad()
            end
        end
        -- pop the graphics and set it back to normal
        love.graphics.pop()
        -- draw the status of the game
        love.graphics.print("Score:"..p1Score,5,510)
        love.graphics.print("Lives:"..lives,5,530)
        love.graphics.print("High Score:"..HighScore, 5, 550)
    end
end

-- called when any key is pressed in the game 
function gameKeypressed(key)
    -- a players method to move him
    player:keypressed(key, "player")

    -- if the game is multi then activate the movment of the chaser
    if currentState == "multi" then
        -- same as the bug
        if delayTimer <=0 then
            -- we pass the identity of the player because one moves with arrows and one with wasd keys
            player2:keypressed(key, "chaser")
        end
    end
end


function mazeGenerate(i, index, previ)
    -- the previous index and i lines were to make sure we don't go back and forth in the same direction but i deleted them as the maze looked better and more unpredictable without it 
    -- execute this until you reach the last row of the maze
    while i <= #map  do
        -- set where you are in the map table right now to be a 0 which is the path
        map[i][index] = 0
        -- this is random values to decied which direction the next step will be from 1 to 4 and the 5, 6 is to encrease the probability of going left or right
        rand = love.math.random(1,6)
        -- if the random number i 1 or 6 and the column we are at is more than 4 "cuase we add 1  for the border" walk left 3 steps
        if (rand == 1 or rand == 6) and index > 4 then
            -- if (index - 1) ~= previndex then
            --  set the previous (left) three locations to be 0
            map[i][index - 1] = 0
            map[i][index - 2] = 0
            index = index - 3
            --     previndex = index
            -- end

        -- if the random number is 2 then go up one step and the row we are at is more than 2 to leave space for the border
        elseif rand == 2 and i > 2 then
            -- if (i-1) ~= previ then
            i = i - 1
            -- previ = i
            -- end

        -- if the random number is 3 or 5 and the column we are at is less than the edge by 4 so we do not touch the border
        elseif (rand == 3 or rand == 5) and index < #map[1] - 4 then
            -- if (index + 1) ~= previndex then
            -- set the upcoming three right locations to 0
            map[i][index + 1] = 0
            map[i][index + 2] = 0
            index = index + 3
            --     previndex = index
            -- end

        -- if the random number is 4 and the row is less than the map height - 1
        elseif rand == 4 and i < #map -1 then
            -- if (i + 1) ~= previ  then
            -- walk down two steps
            map[i + 1][index] = 0
            i = i + 2
            --     previ = i
            -- -- end
            --  if you reached the bottom of the map then set it to 0 and set the location of the player there and quit the loop
            if i == #map then
                map[i][index] = 0
                playerx = index
                playery = i
                break
            end
        end

        -- i made this at first to make sure that the loop will quit but now we don't need it as i the valye of i won't go lower than one of more than the height 
        -- but will leave it to be safe
        if i < 1 or i > #map then
            break
        end
    end

    -- we only made the path from start to finish
    -- now this nested loop to go through the maze and randomly set each block to a wall or path 
    -- for each row in the map starting from the second row and to the one before the last row to avoid the border
    for row = 2, #map-1, 1 do
        -- for each colmun of that row and avoid the border
        for column = 2, #map[1]-1, 1 do
            -- if the location was 1 
            if map[row][column] == 1 then
                -- set it randomly to 1 or 0 means empty '0' or not empty '1'
                map[row][column] = love.math.random(0,1)
            end
        end
    end
end

-- the function that draws the multi game and i pass it the player i want the canvas to be transelated with and the focus
function draw(p, f)
    -- check if the game is multi one more time becuase this funciton will be called two times in a row so if in the first function the game ends this will be called again
    if currentState == "multi" then
        -- set the canvas for the drawing operations to be drawn on it
        love.graphics.setCanvas(screenCanvas)
        -- clear the previuos drawing on it
        love.graphics.clear()
        -- push the new graphics settings
        love.graphics.push()
        -- if the game is zoomed scale it but the screen now is width 200 not 400 
        if zoom == true then
            love.graphics.scale(4)
            -- transelate the canvas depending on the passed player to the function
            love.graphics.translate(-(p.xposition)+ 50, -(p.yposition)+ 75)
        else
            -- same here just devide 200 by 1.5
            love.graphics.scale(1.5)
            love.graphics.translate(-p.xposition + 135, -p.yposition + 200)
        end

        -- draw the maze
            for i,v in ipairs(map) do
            for j,k in ipairs(v) do
                if k == 1 then
                    love.graphics.draw(wall.image, wall.width * (j), wall.height * (i))
                else
                    love.graphics.draw(ground.image, ground.width * j, ground.height * i)
                end
            end
        end
        
        
        -- draw the runner
        love.graphics.draw(player.image, player.width * player.tileX, player.height * player.tileY)

        -- draw the chaser           
        love.graphics.draw(player2.image, player2.width * player2.tileX, player2.height * player2.tileY)

        -- draw the treasure
        treasure:draw()
        
        -- if the runner reached the treasure
        if treasure:checkCollision(player) then
            -- draw the animation of the treasure 
            love.graphics.draw(frames[math.floor(currentFrame)], treasure.x, treasure.y)
            -- stop the game movement
            run = false
            -- set that this code is executed 
            codeExecuted = true
            -- wait till the delay is less than 0
            if delay < 0 then
                -- increase the runner score 
                p1MultiScore = p1MultiScore + 1
                -- set the new highscore if any
                if MultiHighScore < p1MultiScore then
                    MultiHighScore = p1MultiScore
                end
                -- decrease the chaser lives
                p2Lives = p2Lives - 1
                -- if the chaser lost then reset the data
                if p2Lives <= 0 then
                    p2Lives = 10
                    p2Score = 0
                    MultiLives = 10
                    p1MultiScore = 0
                    -- save the game and set
                    savegame()
                    -- set the message of the menu to be you won
                    M = "YOU WON!"
                    love.load()
                else
                    -- if the game is still save it and load another round
                    savegame()
                    gameLoad()
                end
            end
        end

        -- check if the chaser catches the runner
        if player2:checkCollision(player) then
            -- the same as the single player game
            codeExecuted = true
            -- stop movement
            run = false
            -- delay the code so that the user sees that the chaser catched the runner
            if delay < 0 then
                -- decrease the runner's lives by one 
                MultiLives = MultiLives - 1 
                -- love.audio.stop
                -- increase the chaser's score by one
                p2Score = p2Score + 1
                -- set the new high score if any
                if p2HighScore < p2Score then
                    p2HighScore = p2Score
                end
                -- if runner loses and his lives is 0
                if MultiLives <= 0 then
                    -- reset the data 
                    MultiLives = 10
                    p1MultiScore = 0
                    p2Score = 0
                    p2Lives = 10
                    -- save the game and set the message to the menu to be "you lost" then call love.load to load the menu
                    savegame()
                    M = "YOU LOST!"
                    love.load()
                else
                    -- if the runner lost only a round then save the data and load a new round
                    savegame()
                    gameLoad()
                end
            end
        end
        
        
        -- reset the graphics to normal
        love.graphics.pop()
        -- set the canvas to the defualt one which is the screen itself
        love.graphics.setCanvas()
        -- draw on the defualt canvas the screencanvas we used
        love.graphics.draw(screenCanvas, f)
        -- draw a line in the middle of the screen to seperate the two canvases
        love.graphics.line(400, 0, 400, 600)

        -- display the game data
        love.graphics.print("Chaser Score:"..p2Score,5,510)
        love.graphics.print("Chaser Lives:"..p2Lives,5,530)
        love.graphics.print("Chaser High Score:"..p2HighScore, 5, 550)

        love.graphics.print("Runner Score:"..p1MultiScore,410,510)
        love.graphics.print("Runner Lives:"..MultiLives,410,530)
        love.graphics.print("Runner High Score:"..MultiHighScore, 410, 550)


    end
end

function savegame()
    -- set a data table to store the variables in it
    data = {}
    -- store the current games's data in the data table
    data.lives = lives
    data.p1Score = p1Score
    data.p2Score = p2Score
    data.HighScore = HighScore

    data.p1MultiScore = p1MultiScore
    data.MultiLives = MultiLives
    data.MultiHighScore = MultiHighScore
    data.p2Lives = p2Lives
    data.p2HighScore = p2HighScore
    -- now the data table is stored as address so seialize it with lume library 
    serialized = lume.serialize(data)
    -- write the serialized data  to the dacedata file
    love.filesystem.write("savedata.txt", serialized)
end