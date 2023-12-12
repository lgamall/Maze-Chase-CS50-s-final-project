-- make a wall class
Wall = Object:extend()

function Wall:new(image)
    -- set the image of the wall
    -- it is gonna be ethier a wall or ground image
    self.image = love.graphics.newImage(image)
    -- get the width and height of it
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end
