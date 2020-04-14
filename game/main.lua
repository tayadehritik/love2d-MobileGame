--[[
    TODO: animation for the ship
    DONE: scaling and zooming in

]]--
backgroundlayer0 = love.graphics.newImage("assets/layers/backgroundlayer0(5).png")

backgroundlayer1 = love.graphics.newImage("assets/layers/backgroundlayer1(8).png")

backgroundlayer3 = love.graphics.newImage("assets/layers/backgroundlayer3(10).png")

backgroundlayer5 = love.graphics.newImage("assets/layers/backgroundlayer5(still).png")


backgroundcolor = love.graphics.newImage("assets/layers/backgroundcolor.png")

asteroid0 = love.graphics.newImage("assets/layers/asteroid(0).png")


shipanimationframe = 0
shipanimation = {}




asteroid1 = asteroid0


asteroid2 = asteroid0

shipspritesheet = love.graphics.newImage("assets/layers/shipspritesheet.png")



font = love.graphics.newFont("Roboto-Bold.ttf", 25)


Start = "START"

fps = 0

function love.conf(t)
    t.screen.fullscreen = true
end


function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = false, resizable = true})
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    love.window.setFullscreen(true)
    indexforquads = 0
    for yforquad=0,990,55
    do
        
        indexforquads = indexforquads+1
        shipanimation[indexforquads] = love.graphics.newQuad(0,yforquad,182,55,shipspritesheet:getDimensions())
        
    end

    resetGame()
    

end





function love.update(dt)
  

    if(gamestate == "startmenu")
    then

    else
        fps = love.timer.getFPS( )
        shipy2 = shipy + 74
    
        backgroundlayer0x = backgroundlayer0x - (multiplier/7)
        backgroundlayer1x = backgroundlayer1x - (multiplier/6)
        backgroundlayer2x = backgroundlayer2x - (multiplier/5)
        backgroundlayer3x = backgroundlayer3x - (multiplier/4)
        backgroundlayer5x = backgroundlayer5x - (multiplier/2)
        asteroid1x = asteroid1x - (multiplier/3)
        asteroid2x = asteroid2x - (multiplier/3)
        checkIfBackgroundImagesClipped()
        checkShipCollisionWithAsteroids(asteroid1x,asteroid1y,asteroid0width,asteroid0height)
        
        score = score + dt
        
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


        checkIfAsteroidClipped(dt)

        if(activateLightSpeed == true)
        then
            whenLightSpeed(dt)
        end

        if(deactivateLightSpeed == true)
        then
            whenDeactivatingLightSpeed(dt)
        end


        if(shipanimationframe < 18)
        then
            shipanimationframe = shipanimationframe + 1
            shipanimation.image = shipanimation[shipanimationframe]
        else
            shipanimationframe = 1
        end
            


    end

end



function checkIfAsteroidClipped(dt)

    math.randomseed(dt)
    if(asteroid1x <= -50)
    then 
        asteroid1x = 1792
        asteroid1y = math.random(5,414-50)

    end

    if(asteroid2x <= -50)
    then 
        asteroid2x = 1792
        asteroid2y = math.random(5,414-50)
    end

end

function checkIfBackgroundImagesClipped()

    if(backgroundlayer0x <= -896) then
        backgroundlayer0x = 0
    end

    if(backgroundlayer1x <= -896) then
        backgroundlayer1x = 0
    end

    if(backgroundlayer3x <= -896) then
        backgroundlayer3x = 0
    end
    

end
function love.touchpressed( id, x, y, dx, dy, pressure )
    -- test if the touch happened in the upper half of the screen
    shipexpectedy = y
    checkIfClickedOnStart(x,y)
    if(x >= 200 and activateLightSpeed == false)
    then
        activateLightSpeed = true
        multiplier = multiplier + 20
    end
end
    

function love.mousepressed( x, y, button, istouch, presses )
    shipexpectedy = y
    checkIfClickedOnStart(x,y)
    if(x >= 200 and activateLightSpeed == false)
    then
        activateLightSpeed = true
        multiplier = multiplier + 20
    end
end


function checkIfClickedOnStart(x, y)
        
    if(x >= startx and x <= (startx+startwidth) and  y >= starty and y <= (starty+startheight) )
    then
        gamestate = "other"
    end

end


function whenLightSpeed(dt)
    scalefactor = scalefactor + 0.001
    translatefactor = translatefactor - 0.1
    lightSpeedDuration = lightSpeedDuration + dt
    if(lightSpeedDuration >= 3)
    then
        activateLightSpeed = false
        multiplier = 20
        deactivateLightSpeed = true
        lightSpeedDuration = 0
    end
end

function whenDeactivatingLightSpeed(dt)
    scalefactor = scalefactor - 0.001
    translatefactor = translatefactor + 0.1
    deactivateLightSpeedDuration = deactivateLightSpeedDuration + dt
    if(deactivateLightSpeedDuration >= 3)
    then
        deactivateLightSpeed = false
        deactivateLightSpeedDuration = 0
    end
    
end



function checkShipCollisionWithAsteroids(secondObjectX, secondObjectY, secondObjectWidth, secondWidthObjectHeight)

    if(shipx < (secondObjectX+secondObjectWidth) and
       (shipx+shipwidth) > secondObjectX and
        shipy < (secondObjectY+secondWidthObjectHeight) and
        (shipy + shipheight) > secondObjectY)
    then
        resetGame()
    end

end

function resetGame()
    backgroundlayer0x = 0
    backgroundlayer1x = 0
    backgroundlayer2x = 0
    backgroundlayer3x = 0
    backgroundlayer5x = 0
    scalefactor = 1
    translatefactor = 0
    asteroid0width = 30
    asteroid0height = 30
    gamestate = "startmenu"
    asteroid1x = 1792
    asteroid1y = 414/2
    asteroid2x = 1792
    asteroid2y = 414/3
    shipx = 896/6
    shipy = 414/2

    shipx2 = shipx + 180
    shipy2 = shipy + 74
    shipexpectedy = 414/2

    shipwidth = 176
    shipheight = 54

    score = 0
    startwidth = font:getWidth(Start)
    startheight = font:getHeight(Start)
    startx = (896/2) - (startwidth/2)
    starty = (414/2) - (startheight/2)


    activateLightSpeed = false
    deactivateLightSpeed = false
    lightSpeedDuration = 0
    deactivateLightSpeedDuration = 0
    multiplier = 20

    
    shipanimationframe = 1
    shipanimation.image = shipanimation[1]

end

function love.draw()

    if(gamestate == "startmenu")
    then
        love.graphics.draw(backgroundcolor,0,0);
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0);
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
        love.graphics.print(Start,startx,starty)
    else
        love.graphics.scale(scalefactor, scalefactor)
        love.graphics.translate(0, translatefactor)
        love.graphics.draw(backgroundcolor,0,0);
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0);
    
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0);
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
        --love.graphics.print(backgroundlayer1x,0,0)

        if(backgroundlayer5x >= -120)
        then
            love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
        end
        love.graphics.draw(asteroid0,asteroid1x,asteroid1y,0)
        love.graphics.draw(asteroid1,asteroid2x,asteroid2y,90)
        love.graphics.draw(shipspritesheet,shipanimation.image,shipx,shipy)
        love.graphics.print(math.floor(0.5+score),20,20)
        
    end
    
end