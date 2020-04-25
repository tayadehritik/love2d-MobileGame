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

up = love.graphics.newImage("assets/layers/up.png")
down = love.graphics.newImage("assets/layers/down.png")

restartbutton = love.graphics.newImage("assets/layers/restart.png")

backgroundcolor = love.graphics.newImage("assets/layers/backgroundcolor.png")

asteroid0 = love.graphics.newImage("assets/layers/asteroid(0).png")

ach1 = love.graphics.newImage("assets/layers/ach1.png")
ach2 = love.graphics.newImage("assets/layers/ach2.png")
ach3 = love.graphics.newImage("assets/layers/ach3.png")
ach4 = love.graphics.newImage("assets/layers/ach4.png")
ach5 = love.graphics.newImage("assets/layers/ach5.png")

planet1 = love.graphics.newImage("assets/layers/planet1.png")
planet1green = love.graphics.newImage("assets/layers/planet1-green.png")

particle = love.graphics.newImage("assets/layers/particle.png")


planet2 = love.graphics.newImage("assets/layers/planet2.png")
planet2blue = love.graphics.newImage("assets/layers/planet2-blue.png")

PlayAreaWidth = 896
PlayAreaHeight = 414

WindowScaleFactorY = 1
WindowScaleFactorX = 1

shipanimationframe = 0
shipanimation = {}


achievement = {}
achievementimages = {}
asteroidanimationframe = 0
asteroidanimation = {}

punch = love.graphics.newImage("assets/layers/punch.png")

asteroid1 = asteroid0

printstatus = "0"
asteroid2 = asteroid0

asteroid3 = asteroid0
asteroid4 = asteroid0

shipupdownspeed = 0

shipspritesheet = love.graphics.newImage("assets/layers/shipspritesheet.png")



font = love.graphics.newFont("Montserrat-ExtraBold.ttf", 36)


Start = "START"

fps = 0



function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = true, resizable = true})
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)

    love.window.setFullscreen(true)
    local img = love.graphics.newImage('assets/layers/particle.png')

    local lightspeedparticle = love.graphics.newImage("assets/layers/lightspeedparticle.png")
 
	psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(0, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.


    lightspeedsystem = love.graphics.newParticleSystem(lightspeedparticle,32)
    lightspeedsystem:setParticleLifetime(2)
    lightspeedsystem:setEmissionRate(200)
    lightspeedsystem:setSizeVariation(1)
    lightspeedsystem:setLinearAcceleration(-120,-40,0,40)
    lightspeedsystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) 

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


    
    clicksound = love.audio.newSource("assets/sounds/click.wav","static")
    crashsound = love.audio.newSource("assets/sounds/crash.wav","static")
    shipthrusters = love.audio.newSource("assets/sounds/ship_thrusters.mp3","static")

    shipthrusters:setLooping(true)
    resetGame()
    

end

width = 0





function love.update(dt)
    
    width = love.graphics.getDimensions()
    
    psystem:update(dt)
    lightspeedsystem:update(dt)

    if(gamestate == "startmenu")
    then
        
        backgroundlayer0x = backgroundlayer0x - (multiplier/9)
        planet1x = planet1x - (multiplier/9)
        planet1greenx = planet1greenx - (multiplier/9)
        backgroundlayer1x = backgroundlayer1x - (multiplier/8)
        planet2x = planet2x -(multiplier/8)
        planet2bluex = planet2bluex - (multiplier/8)
        backgroundlayer2x = backgroundlayer2x - (multiplier/6)
        backgroundlayer3x = backgroundlayer3x - (multiplier/5)
        backgroundlayer5x = backgroundlayer5x - (multiplier/4)
        checkIfPlanetsClipped(dt)
        checkIfBackgroundImagesClipped()

    elseif(gamestate == "play")
    then
        fps = love.timer.getFPS( )
        shipy2 = shipy + 74
    
        
        backgroundlayer0x = backgroundlayer0x - (multiplier/9)
        planet1x = planet1x - (multiplier/9)
        planet1greenx = planet1greenx - (multiplier/9)
        backgroundlayer1x = backgroundlayer1x - (multiplier/8)
        planet2x = planet2x -(multiplier/8)
        planet2bluex = planet2bluex - (multiplier/8)
        backgroundlayer2x = backgroundlayer2x - (multiplier/6)
        backgroundlayer3x = backgroundlayer3x - (multiplier/5)
        backgroundlayer5x = backgroundlayer5x - (multiplier/4)

        checkAchievementUnlocked()
        checkAchievementClipped(dt)

        if(achievement.status == true)
        then
            achievement.x = achievement.x - (multiplier/4)
        end
        asteroid1x = asteroid1x - (multiplier/2)
        asteroid2x = asteroid2x - (multiplier/2)
        asteroid3x = asteroid3x - (multiplier/2)
        asteroid4x = asteroid4x - (multiplier/2)
        checkIfPlanetsClipped(dt)
        checkIfBackgroundImagesClipped()

        if(activateLightSpeed == false)
        then
            
            checkCollisionBetweenTwoObjects(shipx+110,shipy+8,50,22-8,asteroid1x,asteroid1y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid1x,asteroid1y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid1x,asteroid1y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid1x,asteroid1y,asteroid0width,asteroid0height);



            checkCollisionBetweenTwoObjects(shipx+110,shipy+8,50,22-8,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
            
            

            checkCollisionBetweenTwoObjects(shipx+110,shipy+8,50,22-8,asteroid3x,asteroid3y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid3x,asteroid3y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid3x,asteroid3y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid3x,asteroid3y,asteroid0width,asteroid0height);


            checkCollisionBetweenTwoObjects(shipx+110,shipy+8,50,22-8,asteroid4x,asteroid4y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid4x,asteroid4y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid4x,asteroid4y,asteroid0width,asteroid0height);
            checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid4x,asteroid4y,asteroid0width,asteroid0height);

        end


        score = score + dt
        

        scorex = (PlayAreaWidth/2) - ((font:getWidth("SCORE : "..math.floor(0.5+score))*0.5)/2)
        scorey = (PlayAreaHeight/2)- ((font:getHeight("SCORE : "..math.floor(0.5+score))*0.5)/2)
        restartbuttony = scorey + 10 +(font:getHeight("SCORE : "..math.floor(0.5+score))*0.5)
        
        

        if(keyPressedStatus == true or mouseTouchStatus == true)
        then
            
            x,y = love.mouse.getPosition()
            shipexpectedy = y - 27.5
            
            --[[
            local touches = love.touch.getTouches()
            
            for i, id in ipairs(touches) do
                local x, y = love.touch.getPosition(id)
                punchStatus = checkIfClickedOnPunch(x,y)
                if(punchStatus == false)
                then
                    alltouches = 'false'
                    shipexpectedy = y - 27.5
                else
                    alltouches = 'true'
                    break
                end
                
            end
            

            ]]--
            if(shipthrusterplaying == false)
            then
                --shipthrusters:play()
                shipthrusterplaying = true
            end

            shipy = (lerppos((shipy),getReverseScaledY(shipexpectedy),0.1))  
            
            
           --[[
            if(shipexpectedy > getScaledY(shipy+shipheight))
            then

                shipy = lerppos(shipy,shipy+(10+shipupdownspeed),0.2)
                --shipy = shipy + 2 + shipupdownspeed--shipy + ((shipy+20+shipupdownspeed)-shipy) * 0.2
            else
                if(getScaledY(shipy) >= shipexpectedy)
                then
                    
                    shipy = lerppos(shipy,shipy-(10+shipupdownspeed),0.2)
                    --shipy = shipy - 2 - shipupdownspeed--shipy - ((shipy+20+shipupdownspeed)-shipy)*0.2
                end
                        
            end
            ]]--

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


        if(score % 100 == 0)
        then
            multiplier = multiplier + 1
            shipupdownspeed = shipupdownspeed + 0.5
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




function checkAchievementUnlocked()

    if(math.floor(0.5+score) == 10)
    then
        achievement.status = true
    end

    if(math.floor(0.5+score) == 100)
    then
        achievement.status = true
    end

    if(math.floor(0.5+score) == 500)
    then
        achievement.status = true
    end

    if(math.floor(0.5+score) == 1000)
    then
        achievement.status = true
    end

    if(math.floor(0.5+score) == 2000)
    then
        achievement.status = true
    end
    
    
    


end


function checkAchievementClipped(dt)
    math.randomseed(dt)
    if(achievement.x <= -95)
    then
        achievement.x = 896+95
        achievement.y = math.random(95,414-95)
        if(achievementindex < maxindexforarchievement)
        then
            achievementindex = achievementindex + 1
            achievement.image = achievementimages[achievementindex]
        end
        achievement.status = false   
    end

end

function lerppos(initial_value, target_value, speed)
	local result = (1-speed) * initial_value + speed*target_value
	return result
end

function lerpneg(initial_value, target_value, speed)
	local result = (1-speed) * initial_value - speed*target_value
	return result
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

    if(asteroid3x <= -50)
    then 
        asteroid3x = math.random(896,1792)
        asteroid3y = math.random(5,414-50)

    end

    if(asteroid4x <= -50)
    then 
        asteroid4x = math.random(896,1792)
        asteroid4y = math.random(5,414-50)

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

function love.keypressed( key, scancode, isrepeat )
    
    if key == "escape" then
        love.event.quit()
     end


    if(key == "return" and (gamestate == "startmenu" or gamestate == "pause"))
    then
        if(gamestate == "pause")
        then
            resetGame()
        end
        
        clicksound:play()
        gamestate = "play"

    end

    
    if(key == "space")
    then
        if(activateLightSpeed == false and gamestate ~= "startmenu" and deactivateLightSpeed == false)
        then
            activateLightSpeed = true
            multiplier = multiplier + 40
              
        end
    end

    if(key == "up")
    then
        keyPressedStatus = true
        shipexpectedy = getScaledY(5)
    end

    if(key == "down")
    then
        keyPressedStatus = true
        shipexpectedy = getScaledY(414-5)
    end

end
    

function love.mousepressed( x, y, button, istouch, presses )
    
    mouseTouchStatus = true
    
    punchStatusMouse = checkIfClickedOnPunch(x,y)
    --[[
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
    ]]--
    checkIfClickedOnStart(x,y)
    checkIfClickedOnRestart(x,y)
    --checkIfClickedOnUp(x,y)
    --checkIfClickedOnDown(x,y)
  
end

function love.keyreleased( key, scancode )
    keyPressedStatus = false
    shipthrusters:stop()
    shipthrusterplaying = false
end

function love.mousereleased( x, y, button, istouch, presses )

    mouseTouchStatus = false
    keyPressedStatus = false
    shipthrusters:stop()
    shipthrusterplaying = false
end

function checkIfClickedOnStart(x, y)
        
    if(x >= getScaledX(startx) and x <= (getScaledX(startx+startwidth)) and  y >= getScaledY(starty) and y <= (getScaledY(starty+startheight)) and gamestate == "startmenu")
    then
        gamestate = "play"
        clicksound:play()
        
    end

end

function checkIfClickedOnRestart(x,y)
    if(x >= getScaledX(restartbuttonx) and x <= (getScaledX(restartbuttonx+50)) and  y >= getScaledY(restartbuttony) and y <= (getScaledY(restartbuttony+50)) and gamestate == "pause")
    then
        resetGame()
        clicksound:play()
        gamestate = "play"
        
    end

end


function checkIfClickedOnUp(x,y)
    if(x >= getScaledX(upx) and x <= (getScaledX(upx+50)) and  y >= getScaledY(upy) and y <= (getScaledY(upy+50)) and gamestate == "play")
    then
        keyPressedStatus = true
        --clicksound:play()
        shipexpectedy = getScaledY(5)
    end
end

function checkIfClickedOnDown(x,y)

    if(x >= getScaledX(downx) and x <= (getScaledX(downx+50)) and  y >= getScaledY(downy) and y <= (getScaledY(downy+50)) and gamestate == "play")
    then
        keyPressedStatus = true
        --clicksound:play()
        shipexpectedy = getScaledY(414-5)
    end

end

function checkIfClickedOnPunch(x,y)

    if(x >= getScaledX(punchx) and x <= (getScaledX(punchx+50)) and  y >= getScaledY(punchy) and y <= (getScaledY(punchy+50)) )
    then
       

        if(activateLightSpeed == false and gamestate ~= "startmenu" and deactivateLightSpeed == false)
        then
            activateLightSpeed = true
            multiplier = multiplier + 40
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
    score = score + 0.1
    shipupdownspeed = shipupdownspeed + 0.01
    lightSpeedDuration = lightSpeedDuration + dt
    if(lightSpeedDuration >= 3)
    then
        activateLightSpeed = false
        multiplier = multiplier - 40
        deactivateLightSpeed = true
        lightSpeedDuration = 0
    end
end

function whenDeactivatingLightSpeed(dt)
    scalefactor = scalefactor - 0.001
    translatefactory = translatefactory + 0.1
    shipupdownspeed = shipupdownspeed - 0.01
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
        crashsound:play()
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
    asteroid1x = math.random(896+30,1792-30)
    asteroid1y = math.random(30,414-30)
    asteroid2x = math.random(896+30,1792-30)
    asteroid2y = math.random(30,414-30)
    asteroid3x = math.random(896+30,1792-30)
    asteroid3y = math.random(30,414-30)
    asteroid4x = math.random(896+30,1792-30)
    asteroid4y = math.random(30,414-30)

    shipupdownspeed = 0

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
    multiplier = 10

    
    shipanimationframe = 0
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

    achievementimages[1] = ach1
    achievementimages[2] = ach2
    achievementimages[3] = ach3
    achievementimages[4] = ach4
    achievementimages[5] = ach5
    maxindexforarchievement = 5
    achievementindex = 1
    achievement.x = 1792-95
    achievement.y = math.random(95,414-95)
    achievement.image = achievementimages[achievementindex]
    achievement.status = false


    upx = 20
    upy = PlayAreaHeight-50-20

    downx = PlayAreaWidth-50-20
    downy = PlayAreaHeight-50-20

    shipthrusterplaying = false

    alltouches = 0

end



function getScaledX(x)
    x = WindowScaleFactorX * x
    return x
end

function getScaledY(y)
    y = WindowScaleFactorY * y
    return y
end

function getReverseScaledX(x)
    x = WindowScaleFactorX / x
    return x
end

function getReverseScaledY(y)
    y = y / WindowScaleFactorY 
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
        
        love.graphics.draw(achievement.image,achievement.x,achievement.y,0,0.5,0.5)
        --love.graphics.print(backgroundlayer1x,0,0)

        
        love.graphics.draw(psystem,asteroid1x+(asteroid0width/2), asteroid1y+(asteroid0height/2))
        love.graphics.draw(psystem,asteroid2x+(asteroid0width/2), asteroid2y+(asteroid0height/2))
        love.graphics.draw(psystem,asteroid4x+(asteroid0width/2), asteroid4y+(asteroid0height/2))
        love.graphics.draw(psystem,asteroid3x+(asteroid0width/2), asteroid3y+(asteroid0height/2))

        
        love.graphics.draw(asteroid0,asteroid1x,asteroid1y,0,30/(30*4),30/(30*4))
        
        love.graphics.draw(asteroid1,asteroid2x,asteroid2y,0,30/(30*4),30/(30*4))
        
        love.graphics.draw(asteroid3,asteroid3x,asteroid3y,0,30/(30*4),30/(30*4))
      
        love.graphics.draw(asteroid4,asteroid4x,asteroid4y,0,30/(30*4),30/(30*4))
        love.graphics.draw(lightspeedsystem,shipx+shipwidth,shipy-10)
        love.graphics.draw(shipspritesheet,shipanimation.image,shipx,shipy,0,0.52,0.5)
        
       
        --love.graphics.draw(up,upx,upy,0,0.5,0.5)
        --love.graphics.draw(down,downx,downy,0,0.5,0.5)
        if(activateLightSpeed == false and deactivateLightSpeed == false)
        then
            
            love.graphics.draw(punch,punchx,punchy,0,0.5,0.5)
            --love.graphics.draw(achievement.image,punchx+50+10,punchy,0,95/(95*4),95/(95*4))
        end
 
           --[[  
        love.graphics.rectangle("line",shipx+110,shipy+8,50,22-8)
        love.graphics.rectangle("line",shipx+99,shipy+39,36,15)
        love.graphics.rectangle("line",shipx+48,shipy+39,49,6)
        love.graphics.rectangle("line",shipx+24,shipy+13,70,15)
        
        love.graphics.rectangle("line",asteroid1x,asteroid1y,asteroid0width,asteroid0height)
        love.graphics.rectangle("line",asteroid2x,asteroid2y,asteroid0width,asteroid0height)
        love.graphics.rectangle("line",asteroid3x,asteroid3y,asteroid0width,asteroid0height)
        love.graphics.rectangle("line",asteroid4x,asteroid4y,asteroid0width,asteroid0height)
    
        checkCollisionBetweenTwoObjects(shipx+100,shipy+2,70,22,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        ]]--
        


    elseif(gamestate == "pause")
    then
        love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);
        
        love.graphics.print("SCORE : "..math.floor(0.5+score),scorex,scorey,0,0.5,0.5)
        love.graphics.draw(restartbutton,restartbuttonx,restartbuttony,0,0.5,0.5)

    end
    
end