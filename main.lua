function love.load()
    width, height = love.graphics.getDimensions()
    background = love.graphics.newImage("background.png")
    backgroundwidth , backgroundheight = background:getDimensions()
    love.window.setMode(width, height, {resizable=true, vsync=false})
end

function love.update(dt)

end

function love.draw()
    print(backgroundwidth)
    love.graphics.draw(background,0,0)
end