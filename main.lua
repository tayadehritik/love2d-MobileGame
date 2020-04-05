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

ship = love.graphics.newImage("assets/layers/ship.png")
shipx = 896/4
shipy = 414/2

shipx2 = shipx + 180
shipy2 = shipy + 74

shipexpectedy = 414/2

function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = false, resizable = true})

end



multiplier = 1

function love.update(dt)

    shipy2 = shipy + 74
    backgroundlayer0x = backgroundlayer0x - (multiplier/6)
    backgroundlayer1x = backgroundlayer1x - (multiplier/5)
    backgroundlayer2x = backgroundlayer2x - (multiplier/4)
    backgroundlayer3x = backgroundlayer3x - (multiplier/3)
    backgroundlayer5x = backgroundlayer5x - (multiplier/2)
    
    checkIfBackgroundImagesClipped()

    differenceShipY = shipy - shipexpectedy

    if(shipexpectedy > shipy)
    then
        if(shipy2 <= shipexpectedy)
        then
            shipy = shipy + 1
        end
    else
        shipy = shipy - 1        
    end

end

x = 0
globaly = 0

function checkIfBackgroundImagesClipped()

    if(backgroundlayer0x <= -896) then
        backgroundlayer0x = 0
    end

    if(backgroundlayer1x <= -896) then
        backgroundlayer1x = 0
    end

    if(backgroundlayer2x <= -896) then
        backgroundlayer2x = 0
    end

    if(backgroundlayer3x <= -896) then
        backgroundlayer3x = 0
    end


    

end
function love.touchpressed( id, x, y, dx, dy, pressure )
    -- test if the touch happened in the upper half of the screen
    shipexpectedy = y
end


function love.mousepressed( x, y, button, istouch, presses )
    shipexpectedy = y
end


function love.draw()
    love.graphics.draw(backgroundcolor,0,0);
    love.graphics.draw(backgroundlayer0,backgroundlayer0x,0);
    love.graphics.draw(backgroundlayer1,backgroundlayer1x,0);
    love.graphics.draw(backgroundlayer2,backgroundlayer2x,0);
    love.graphics.draw(backgroundlayer3,backgroundlayer3x,0);
    love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
    --love.graphics.print(backgroundlayer1x,0,0)

    if(backgroundlayer5x >= -896-120)
    then
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
    end

    love.graphics.draw(ship,shipx,shipy);

    
end