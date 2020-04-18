--[[
    DONE: animation for the ship
    DONE: scaling and zooming in
    TODO: lightspeed button
]]--
backgroundlayer0 = love.graphics.newImage("assets/layers/backgroundlayer0(5).png")

backgroundlayer1 = love.graphics.newImage("assets/layers/backgroundlayer1(8).png")

backgroundlayer3 = love.graphics.newImage("assets/layers/backgroundlayer3(10).png")

backgroundlayer5 = love.graphics.newImage("assets/layers/backgroundlayer5(still).png")

startbutton = love.graphics.newImage("assets/layers/startbutton.png")

restartbutton = love.graphics.newImage("assets/layers/restart.png")


backgroundcolor = love.graphics.newImage("assets/layers/backgroundcolor.png")

asteroid0 = love.graphics.newImage("assets/layers/asteroid(0).png")

planet1 = love.graphics.newImage("assets/layers/planet1.png")
planet1green = love.graphics.newImage("assets/layers/planet1-green.png")


planet2 = love.graphics.newImage("assets/layers/planet2.png")
planet2blue = love.graphics.newImage("assets/layers/planet2-blue.png")

PlayAreaWidth = 896
PlayAreaHeight = 414

WindowScaleFactorY = 1
WindowScaleFactorX = 1

shipanimationframe = 0
shipanimation = {}

punch = love.graphics.newImage("assets/layers/punch.png")

asteroid1 = asteroid0

printstatus = "0"
asteroid2 = asteroid0


shipspritesheet = love.graphics.newImage("assets/layers/shipspritesheet.png")



font = love.graphics.newFont("Montserrat-ExtraBold.ttf", 36)


Start = "START"

fps = 0



function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = true, resizable = true})
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)

    love.window.setFullscreen(true)
    


    WindowWidth = love.graphics.getWidth()
    WindowHeight = love.graphics.getHeight()
    
    WindowScaleFactorY = WindowHeight / PlayAreaHeight
    WindowScaleFactorX = WindowWidth / PlayAreaWidth


    --love.window.setFullscreen(true)
    indexforquads = 0
    for yforquad=0,1980,110
    do
        
        indexforquads = indexforquads+1
        shipanimation[indexforquads] = love.graphics.newQuad(0,yforquad,340,110,shipspritesheet:getDimensions())
        
    end

    resetGame()
    

end

width = 0





function love.update(dt)
    
    width = love.graphics.getDimensions()

    if(gamestate == "startmenu")
    then
        backgroundlayer0x = backgroundlayer0x - (multiplier/7)
        planet1x = planet1x - (multiplier/7)
        planet1greenx = planet1greenx - (multiplier/7)
        backgroundlayer1x = backgroundlayer1x - (multiplier/6)
        planet2x = planet2x -(multiplier/6)
        planet2bluex = planet2bluex - (multiplier/6)
        backgroundlayer2x = backgroundlayer2x - (multiplier/5)
        backgroundlayer3x = backgroundlayer3x - (multiplier/4)
        backgroundlayer5x = backgroundlayer5x - (multiplier/2)
        checkIfPlanetsClipped(dt)
        checkIfBackgroundImagesClipped()

    elseif(gamestate == "play")
    then
        fps = love.timer.getFPS( )
        shipy2 = shipy + 74
    
        
        backgroundlayer0x = backgroundlayer0x - (multiplier/7)
        planet1x = planet1x - (multiplier/7)
        planet1greenx = planet1greenx - (multiplier/7)
        backgroundlayer1x = backgroundlayer1x - (multiplier/6)
        planet2x = planet2x -(multiplier/6)
        planet2bluex = planet2bluex - (multiplier/6)
        backgroundlayer2x = backgroundlayer2x - (multiplier/5)
        backgroundlayer3x = backgroundlayer3x - (multiplier/4)
        backgroundlayer5x = backgroundlayer5x - (multiplier/2)
        asteroid1x = asteroid1x - (multiplier/3)
        asteroid2x = asteroid2x - (multiplier/3)
        checkIfPlanetsClipped(dt)
        checkIfBackgroundImagesClipped()
        
        checkCollisionBetweenTwoObjects(shipx+100,shipy+2,70,22,asteroid1x,asteroid1y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid1x,asteroid1y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid1x,asteroid1y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid1x,asteroid1y,asteroid0width,asteroid0height);



        checkCollisionBetweenTwoObjects(shipx+100,shipy+2,70,22,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        
        
        score = score + dt
        

        scorex = (PlayAreaWidth/2) - ((font:getWidth("SCORE : "..math.floor(0.5+score))*0.5)/2)
        scorey = (PlayAreaHeight/2)- ((font:getHeight("SCORE : "..math.floor(0.5+score))*0.5)/2)
        restartbuttony = scorey + 10 +(font:getHeight("SCORE : "..math.floor(0.5+score))*0.5)
        
        

        if(mouseTouchStatus == true)
        then
            if(shipexpectedy > getScaledY(shipy+shipheight))
            then
                shipy = shipy + 1.5
            else
                if(getScaledY(shipy) >= shipexpectedy)
                then
                    shipy = shipy - 1.5
                end
                        
            end
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
        asteroid1x = math.random(896,1792)
        asteroid1y = math.random(5,414-50)

    end

    if(asteroid2x <= -50)
    then 
        asteroid2x = math.random(896,1792)
        asteroid2y = math.random(5,414-50)
    end 
end

function checkIfPlanetsClipped(dt)
    math.randomseed(dt)

    if(planet1x <= -896)
    then
        planet1x = 896
        planet1y = math.random(6,414-6)
        planet1angle = math.random(-0.9,0.9)
    end

    if(planet1greenx <= -896)
    then
        planet1greenx = 896
        planet1greeny = math.random(6,414-6)
        planet1greenangle = math.random(-0.9,0.9)
    end

    if(planet2x <= -896)
    then
        planet2x = 896
        planet2y = math.random(11,414-11)
        planet2angle = math.random(-0.9,0.9)
    end

    if(planet2bluex <= -896)
    then
        planet2bluex = 896
        planet2bluey = math.random(11,414-11)
        planet2blueangle = math.random(-0.9,0.9)
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
    
 
    
end
    

function love.mousepressed( x, y, button, istouch, presses )
    
    mouseTouchStatus = true
    punchStatusMouse = checkIfClickedOnPunch(x,y)
    if(punchStatusMouse ~= true)
    then
        --shipexpectedy = y

        if(y > getScaledY(shipy + shipheight))
        then
            shipexpectedy = getScaledY(414-5)
        else
            shipexpectedy = getScaledY(5)
        end

    end
    checkIfClickedOnStart(x,y)
    checkIfClickedOnRestart(x,y)
  
end



function love.mousereleased( x, y, button, istouch, presses )

    mouseTouchStatus = false

end

function checkIfClickedOnStart(x, y)
        
    if(x >= getScaledX(startx) and x <= (getScaledX(startx+startwidth)) and  y >= getScaledY(starty) and y <= (getScaledY(starty+startheight)) and gamestate == "startmenu")
    then
        gamestate = "play"
    end

end

function checkIfClickedOnRestart(x,y)
    if(x >= getScaledX(restartbuttonx) and x <= (getScaledX(restartbuttonx+50)) and  y >= getScaledY(restartbuttony) and y <= (getScaledY(restartbuttony+50)) and gamestate == "pause")
    then
        resetGame()
        gamestate = "play"
    end

end

function checkIfClickedOnPunch(x,y)

    if(x >= getScaledX(punchx) and x <= (getScaledX(punchx+50)) and  y >= getScaledY(punchy) and y <= (getScaledY(punchy+50)) )
    then
       

        if(activateLightSpeed == false and gamestate ~= "startmenu" and deactivateLightSpeed == false)
        then
            activateLightSpeed = true
            multiplier = multiplier + 20
            return true   
        else
            return false
        end

    else
        return false
         
    end
end


function whenLightSpeed(dt)
    scalefactor = scalefactor + 0.001
    translatefactory = translatefactory - 0.1
   
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
    translatefactory = translatefactory + 0.1
   
    deactivateLightSpeedDuration = deactivateLightSpeedDuration + dt
    if(deactivateLightSpeedDuration >= 3)
    then
        deactivateLightSpeed = false
        deactivateLightSpeedDuration = 0
    end
    
end





function checkCollisionBetweenTwoObjects(object1X,object1Y,object1Width,object1Height,object2X,object2Y,object2Width,object2Height)

    if(getScaledX(object1X) < getScaledX(object2X+object2Width) and
       getScaledX((object1X)+object1Width) > getScaledX(object2X) and
        getScaledY(object1Y) < getScaledY(object2Y+object2Height) and
        getScaledY((object1Y) + object1Height) > getScaledY(object2Y))
    then
        gamestate = "pause"
    end


end

function resetGame()
    backgroundlayer0x = 0
    backgroundlayer1x = 0
    backgroundlayer2x = 0
    backgroundlayer3x = 0
    backgroundlayer5x = 0
    scalefactor = 1
    translatefactory = 0
    translatefactorx = 0
    asteroid0width = 30
    asteroid0height = 30
    
    gamestate = "startmenu"
    asteroid1x = 1792
    asteroid1y = 414/2
    asteroid2x = 1792
    asteroid2y = 414/3
    shipx = 896/6
    shipy = 414/2

    shipx2 = shipx + 182
    shipy2 = shipy + 54
    shipexpectedy = 414/2

    shipwidth = 170-5
    shipheight = 55-5

    score = 0
    scorex = 0
    scorey = 0


    startwidth = 122
    startheight = 50
    startx = PlayAreaWidth/2 - (122/2)
    starty = PlayAreaHeight/2 - (50/2)
    

    restartbuttonx = PlayAreaWidth/2 - (50/2)
    restartbuttony = 0

    activateLightSpeed = false
    deactivateLightSpeed = false
    lightSpeedDuration = 0
    deactivateLightSpeedDuration = 0
    multiplier = 20

    
    shipanimationframe = 1
    shipanimation.image = shipanimation[1]


    mouseTouchStatus = false

    planet1x = PlayAreaWidth/2
    planet1y = PlayAreaHeight/2
    planet1angle = math.random(-0.9,0.9)

    planet1greenx = 896
    planet1greeny = math.random(6,414-6)
    planet1greenangle = math.random(-0.9,0.9)

    planet2x = PlayAreaWidth/2
    planet2y = PlayAreaHeight/3
    planet2angle = math.random(-0.9,0.9)


    planet2bluex = 896
    planet2bluey = math.random(11,414-11)
    planet2greenangle = math.random(-0.9,0.9)
    punchx = 20
    punchy = 414-50-20

    

end



function getScaledX(x)
    x = WindowScaleFactorX * x
    return x
end

function getScaledY(y)
    y = WindowScaleFactorY * y
    return y
end



function love.draw()
    love.graphics.scale(WindowScaleFactorX,WindowScaleFactorY)
    if(gamestate == "startmenu")
    then
        love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0,0,0.5,0.5);
        love.graphics.draw(startbutton,startx,starty,0,0.5,0.5)
    
    elseif(gamestate == "play")
    then
        love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        love.graphics.print(math.floor(0.5+score),20,20,0,0.5,0.5)
        love.graphics.scale(scalefactor, scalefactor)
        love.graphics.translate(translatefactorx, translatefactory)
        
        

        love.graphics.draw(planet2,planet2x,planet2y,planet2angle,24/(24*3),11/(11*3))
        love.graphics.draw(planet2blue,planet2bluex,planet2bluey,planet2blueangle,24/(24*3),11/(11*3))
        love.graphics.draw(planet1,planet1x,planet1y,planet1angle,16/(16*3),6/(6*3))
        love.graphics.draw(planet1green,planet1greenx,planet1greeny,planet1greenangle,16/(16*3),6/(5*3))
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0,0,0.5,0.5);
        
        --love.graphics.print(backgroundlayer1x,0,0)

        if(backgroundlayer5x >= -120)
        then
            love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
        end
        love.graphics.draw(asteroid0,asteroid1x,asteroid1y,0,0.5,0.5)
        love.graphics.draw(asteroid1,asteroid2x,asteroid2y,90,0.5,0.5)
        love.graphics.draw(shipspritesheet,shipanimation.image,shipx,shipy,0,0.5,0.5)
        
        if(activateLightSpeed == false and deactivateLightSpeed == false)
        then
            love.graphics.draw(punch,punchx,punchy,0,0.5,0.5)
        end

    elseif(gamestate == "pause")
    then
        love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0,0,0.5,0.5);
        love.graphics.print("SCORE : "..math.floor(0.5+score),scorex,scorey,0,0.5,0.5)
        love.graphics.draw(restartbutton,restartbuttonx,restartbuttony,0,0.5,0.5)

    end
    
end