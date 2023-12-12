-- make a button class out of object form the classic library
Button = Object:extend()

-- the new function of to load the buttons and we pass it the y and the text of the button
function Button:new(y, text)
    -- set the image of the button
    self.image = love.graphics.newImage("grey_button03.png")
    -- set the x and y  and make it centerd
    self.x = love.graphics.getWidth()/2 - 100
    self.y = y
    -- get the width and height of the button
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    -- set the defualt, hover and click images
    self.defualtImage = love.graphics.newImage("grey_button03.png")
    self.hovoerImage = love.graphics.newImage("grey_button15.png")
    self.clickImage = love.graphics.newImage("grey_button00.png")
    -- the default color of the game is already white but we will need it in line 28
    self.defualtColor = {1 , 1, 1}
    -- the text of the button
    self.text = text
    -- self.isClicked = false
    -- the x and y scale of the button
    self.sx = 1
    self.sy = 1
end

-- the function to draw the button
function Button:buttonDraw()
    -- draw the button
    love.graphics.draw(self.image,self.x, self.y,0,self.sx,self.sy)
    -- set the color of the game to black so that the text printed is black 
    love.graphics.setColor(0,0,0)
    -- print the button's text
    love.graphics.print(self.text, self.x + self.width/2, self.y + self.height/2, 0, 1, 1, font:getWidth(self.text)/2, font:getHeight()/2)
    -- reset the color to white again
    love.graphics.setColor(self.defualtColor)
end
