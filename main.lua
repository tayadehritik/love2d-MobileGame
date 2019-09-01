function love.load()
    width, height = love.graphics.getDimensions()
end

function love.update(dt)

end

function love.draw()
    love.graphics.print("Hello world",width/2,height/2)
end