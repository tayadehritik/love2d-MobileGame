backgroundlayer0 = love.graphics.newImage("assets/layers/backgroundlayer0(5).png")
backgroundlayer0x = 0

backgroundlayer1 = love.graphics.newImage("assets/layers/backgroundlayer1(8).png")
backgroundlayer1x = 0

backgroundlayer2 = love.graphics.newImage("assets/layers/backgroundlayer2(10).png")
backgroundlayer2x = 0

backgroundlayer3 = love.graphics.newImage("assets/layers/backgroundlayer3(16).png")
backgroundlayer3x = 0



backgroundlayer5 = love.graphics.newImage("assets/layers/backgroundlayer5(still).png")
backgroundlayer5x = 0

backgroundcolor = love.graphics.newImage("assets/layers/backgroundcolor.png")

function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = false, resizable = true})

end

function love.update(dt)

    backgroundlayer3x = backgroundlayer3x - (1/3);
    backgroundlayer2x = backgroundlayer2x - (1/4);
    backgroundlayer1x = backgroundlayer1x - (1/5);
    backgroundlayer0x = backgroundlayer0x - (1/6);

    backgroundlayer5x = backgroundlayer5x - (1/2);

    checkIfBackgroundImagesClipped()
    


end


function checkIfBackgroundImagesClipped()

    if(backgroundlayer1x <= -896) then
        backgroundlayer1x = 0
    elseif(backgroundlayer2x <= -896) then
        backgroundlayer2x = 0
    elseif(backgroundlayer3x <= -896) then
        backgroundlayer3x = 0
    elseif(backgroundlayer0x <= -896) then
        backgroundlayer0x = 0
    end

end

function love.draw()
    love.graphics.draw(backgroundcolor,0,0);
    love.graphics.draw(backgroundlayer0,backgroundlayer0x,0);
    love.graphics.draw(backgroundlayer1,backgroundlayer1x,0);
    love.graphics.draw(backgroundlayer2,backgroundlayer2x,0);
    love.graphics.draw(backgroundlayer3,backgroundlayer3x,0);
    if(backgroundlayer5x >= -896-120)
    then
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
    end
end