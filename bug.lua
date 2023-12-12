-- make a bug class 
Bug = Object:extend()

-- set the propereties of the instance
function Bug:new(x,y, image)
    -- set the image of the bug
    self.image = love.graphics.newImage(image)
    -- get width and height
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    -- the x position
    self.x = x  
    -- the y position will be more than the passed by two blocks becuase i wanted to be away from the player when the game starts
    self.y = y + (2 * self.height)
end


function Bug:update(dt, player)
    -- set the angle between the bug and the player
    angle = math.atan2(player.yposition - self.y, player.xposition - self.x)
    -- get the cosin and sin
    cos = math.cos(angle)
    sin = math.sin(angle)

    -- update the x position of hte bug by 35 pixle in seconde but in the direction of the player ad horizontal direction eq cos
    self.x = self.x + 35 * cos * dt
    -- vertical direction eq sin
    self.y = self.y + 35 * sin * dt

    -- if the bug catches the player
    if self:checkCollision(player) then
        -- the player's lives is decreased
        lives = lives - 1 
        -- if the player loses the game
        if lives <= 0 then
            -- reset the data
            lives = 10
            p1Score = 0
            -- save the new data
            savegame()
            -- set the message of the menu to be "you lost"
            M = "YOU LOST!"
            -- call love.load to load the menu and draw it
            love.load()
        else
            -- if the game is still going save the data and load another round
            savegame()
            gameLoad()
        end
    end
end


function Bug:draw()
    -- draw the bug
    love.graphics.draw(self.image, self.x, self.y)
end

-- check if the instans of the bug collides with the player
function Bug:checkCollision(player)
    -- i did not want to check collision by just the edges so i add a 5 pixels to he statment
    -- this is collision type aabb
    return self.x + self.width > player.xposition + 5
    and self.x < player.xposition + player.width - 5
    and self.y < player.yposition + player.height - 5
    and self.y + self.height > player.yposition + 5
end