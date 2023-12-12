-- make a player class
Player = Object:extend()

function Player:new(tileX, tileY, image)
    -- set the image
    self.image = love.graphics.newImage(image)
    -- set the width and height
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    -- set the x and y location in the tilemap "the index in the map array"
    self.tileX = tileX
    self.tileY = tileY

    -- set the x and y on the screen itself
    self.xposition =  self.width * self.tileX
    self.yposition =  self.height * self.tileY
end

-- handels the key presses of the players
function Player:keypressed(key, state)
    -- if the movement is present
    if run == true then
        -- will use these temp variables just to check if the player is moving in an empty space
        local x = self.tileX
        local y = self.tileY
        -- if the runner who is moveing set only move him with the arrow keys
        if state == "player" then
            if key == "up" then
                y = y - 1
            elseif key == "down" then
                y = y + 1
            elseif key == "left" then
                x = x - 1
            elseif key == "right" then 
                x = x + 1
            end
        end

        -- if the player is the chaser set the movement keys to be the 'wasd'
        if state == "chaser" then
            if key == "w" then
                y = y - 1
            elseif key == "s" then
                y = y + 1
            elseif key == "a" then
                x = x - 1
            elseif key == "d" then 
                x = x + 1
            end
        end

        -- if the location was empty then set the players position to it
        if self:isEmpty(x,y) then
            -- set the new index of the player in the map
            self.tileX = x
            self.tileY = y
            -- update the players real x and y positions
            self.xposition =  self.width * self.tileX
            self.yposition =  self.height * self.tileY
        end
    end
end

-- function that checkes if the location is empty or not
function Player:isEmpty(x,y)
    -- this is to make sure the player won't move outside the maze and at the same time the location is empty
    if #map >= y and y > 0 then
        if #map[y] >= x and x > 0 then
            -- return true
            return map[y][x] == 0
        end
    else 
        return false
    end
end

function Player:checkCollision(player)
    -- checks collision type aabb 
    return self.xposition + self.width > player.xposition 
    and self.xposition < player.xposition + player.width 
    and self.yposition < player.yposition + player.height 
    and self.yposition + self.height > player.yposition 
end