--[[
    DONE: animation for the ship
    DONE: scaling and zooming in
    TODO: lightspeed button
]]--
require "animation/main"
require "planet"
require "loadresourcepacks"
require "blinkingstar"
require "shootingstar"


font = love.graphics.newFont("Montserrat-ExtraBold.ttf", 36)


Start = "START"

fps = 0



function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = true, resizable = true})
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    
    love.graphics.setBackgroundColor(20/255, 26/255, 31/255, 1/100)

    love.window.setFullscreen(true)
    
    PlayAreaWidth = 896
    PlayAreaHeight = 414

    WindowScaleFactorY = 1
    WindowScaleFactorX = 1

   

    WindowWidth = love.graphics.getWidth()
    WindowHeight = love.graphics.getHeight()
    
    WindowScaleFactorY = WindowHeight / PlayAreaHeight
    WindowScaleFactorX = WindowWidth / PlayAreaWidth


    loadresource1 = false
    loadresource2 = false
    loadresource3 = false
    loadresource4 = false
    loadresource5 = false
    loadresource6 = false
    loadresource7 = false
    loadresource8 = false
    loadresource9 = false
    loadresource10 = false
    loadresource11 = false
    loadresource12 = false
    loadresource13 = false
    loadresource14 = false
    loadresource15 = false

    splashicon = love.graphics.newImage("assets/layers/splashicon.png")
    LOADING = love.graphics.newImage("assets/layers/LOADING.png")
    
    gamestate = "loading1"

    
    --resetGame()
    

end









function olivineanimationcreate (x,y)
    local animation = {}
    
    animation.frame = 0
    animation.width = 16
    animation.height = 28
    animation.x = x--math.random(896,1792-olivineanimation.width)
    animation.y = y--math.random(0,414-olivineanimation.height)
    animation.scaleFactorX = 79 / (79 * 5)
    animation.scaleFactorY = 139 / (139 * 5) 
    animation.currentTime = 0
    animation.duration = 1
    for i=0,12,1
    do 
        animation[i] = love.graphics.newImage("assets/ahieveme/ahieveme-olivine-"..i..".png")
    end

    animation.image = animation[animation.frame]

    planetLoad()

    return animation
end

function olivineanimationupdate(localolivine,dt)

    localolivine.currentTime = localolivine.currentTime + dt

    if(localolivine.currentTime > localolivine.duration)
    then
        localolivine.currentTime = localolivine.currentTime - localolivine.duration
    end

    localolivine.frame = math.floor(localolivine.currentTime / localolivine.duration * 12) 
    

    localolivine.image = localolivine[localolivine.frame]


    localolivine.x =  localolivine.x - (multiplier/4)


    if(localolivine.x < -16)
    then
        math.randomseed(dt)
        localolivine.x = math.random(896,1792)
        localolivine.y = math.random(0+localolivine.height,414-28-localolivine.height)
    end


end


function loadandSetupOlivine()

    olivineanimation1 = olivineanimationcreate(math.random(896,1792),math.random(0,414))
    olivineanimation2 = olivineanimationcreate(math.random(896,1792),math.random(0,414))
end



function playOlivineAnimation(dt, temp2Olivine)

   

end



function updateOlivine(dt)

   olivineanimationupdate(olivineanimation1,dt)
   olivineanimationupdate(olivineanimation2,dt)
   checkIfCrashedWithOlivine(olivineanimation1,shipx,shipy,dt,fadingparticleAchievementSystem1)
   checkIfCrashedWithOlivine(olivineanimation2,shipx,shipy,dt,fadingparticleAchievementSystem2)
   
end



function checkIfCrashedWithOlivine(localolivine,shipx,shipy,dt,localfadingparticlesystem)


    if(localfadingparticlesystem.particleSystem:isActive() == true)
    then
        localfadingparticlesystem.currentTime = localfadingparticlesystem.currentTime + dt
        
        if(localfadingparticlesystem.currentTime >= localfadingparticlesystem.particleSystem:getParticleLifetime())
        then
            localfadingparticlesystem.particleSystem:pause()
            localfadingparticlesystem.currentTime = 0
        end

    end

    localfadingparticlesystem.x = localfadingparticlesystem.x - (multiplier/4)

    if(localfadingparticlesystem.x < -10)
    then
        localfadingparticlesystem.particleSystem:pause()
        localfadingparticlesystem.x = localolivine.x + (localolivine.width/2)
        localfadingparticlesystem.y = localolivine.y + (localolivine.height/2)
    end

    if(returnCollisionBetweenTwoObjects(localolivine.x,localolivine.y,localolivine.width,localolivine.height,shipx,shipy,shipwidth,shipheight) ==  true)
    then
        --  print("crashed")
        --playanimation
        OlivinesCollected = OlivinesCollected + 1
        localfadingparticlesystem.x = localolivine.x + (localolivine.width/2)
        localfadingparticlesystem.y = localolivine.y + (localolivine.height/2)
        
        --resetolivine
        math.randomseed(dt)
        localolivine.x = math.random(896,1792)
        localolivine.y = math.random(0+localolivine.height,414-28-localolivine.height)

        localfadingparticlesystem.particleSystem:setParticleLifetime(1)
        localfadingparticlesystem.particleSystem:setEmissionRate(6)
        --localfadingparticlesystem.particleSystem:setSpeed(100)
        --localfadingparticlesystem.particleSystem:setRadialAcceleration(200)
        localfadingparticlesystem.particleSystem:setEmissionArea('uniform',10,10,0,true)
        localfadingparticlesystem.particleSystem:start()

        
        

    end
end

function resetOlivineAndItsParticleSystems()
   
    resetIndividualItems(olivineanimation1,fadingparticleAchievementSystem1)
    resetIndividualItems(olivineanimation2,fadingparticleAchievementSystem2)
end

function resetIndividualItems(localolivineanimation, localfadinganimationparticlesystem)

    localolivineanimation.x = math.random(896,1792)
    localolivineanimation.y = math.random(0+localolivineanimation.height,414-28-localolivineanimation.height)

    localfadinganimationparticlesystem.x = localolivineanimation.x + (localolivineanimation.width/2)
    localfadinganimationparticlesystem.y = localolivineanimation.y + (localolivineanimation.height/2)

end

function loadAchievementParticleSystem()

    particleAchievementSystem1 = createParticleSyste(particleAchievementImage,6,olivineanimation1.x+(olivineanimation1.width/2),olivineanimation1.y + (olivineanimation1.height/2))
    particleAchievementSystem2 = createParticleSyste(particleAchievementImage,6,olivineanimation2.x+(olivineanimation2.width/2),olivineanimation2.y + (olivineanimation2.height/2))

    fadingparticleAchievementSystem1 = createParticleSyste(particleAchievementImage,6,olivineanimation1.x+(olivineanimation1.width/2),olivineanimation1.y + (olivineanimation1.height/2))
    fadingparticleAchievementSystem2 = createParticleSyste(particleAchievementImage,6,olivineanimation2.x+(olivineanimation2.width/2),olivineanimation2.y + (olivineanimation2.height/2))

    fadingparticleAchievementSystem1.particleSystem:stop()
    fadingparticleAchievementSystem2.particleSystem:stop()

end


function createParticleSyste(image,buffer,x,y)
    local particleSystemTable = {}
    particleSystemTable.x = x
    particleSystemTable.y = y
    particleSystemTable.particleSystem = love.graphics.newParticleSystem(image,buffer)

    particleSystemTable.particleSystem:setSizes(0.3,0.2,0.5)

    particleSystemTable.particleSystem:setParticleLifetime(2) -- Particles live at least 2s and at most 5s.
    --particleSystemTable.particleSystem:setSpeed(3)
    particleSystemTable.particleSystem:setEmissionRate(buffer)
	particleSystemTable.particleSystem:setSizeVariation(1)
	particleSystemTable.particleSystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	particleSystemTable.particleSystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
    particleSystemTable.currentTime = 0
    return particleSystemTable
end

function updateParticleSystem(dt)

    updateIndividualParticleSystem(particleAchievementSystem1,dt,fadingparticleAchievementSystem1)

    particleAchievementSystem1.x = olivineanimation1.x + (olivineanimation1.width/2)
    particleAchievementSystem1.y = olivineanimation1.y + (olivineanimation1.height/2)


    updateIndividualParticleSystem(particleAchievementSystem2,dt,fadingparticleAchievementSystem2)

    particleAchievementSystem2.x = olivineanimation2.x + (olivineanimation2.width/2)
    particleAchievementSystem2.y = olivineanimation2.y + (olivineanimation2.height/2)


end


function updateIndividualParticleSystem(tempParticleSystem,dt,templocalParticleSystem)
    tempParticleSystem.particleSystem:update(dt)
    templocalParticleSystem.particleSystem:update(dt)
    
end

function love.update(dt)
    
   
    
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
        planetUpdate(dt)
        updateblinkingstars(dt)
        updateshootingstars(dt)

    elseif(gamestate == "play")
    then
        fps = love.timer.getFPS( )
        shipy2 = shipy + 74
    
        
        backgroundlayer0x = backgroundlayer0x - (multiplier/7)
        planet1x = planet1x - (multiplier/9)
        planet1greenx = planet1greenx - (multiplier/9)
        backgroundlayer1x = backgroundlayer1x - (multiplier/6)
        planet2x = planet2x -(multiplier/8)
        planet2bluex = planet2bluex - (multiplier/8)
        backgroundlayer2x = backgroundlayer2x - (multiplier/5)
        backgroundlayer3x = backgroundlayer3x - (multiplier/4)
        backgroundlayer5x = backgroundlayer5x - (multiplier/3)

        

        if(achievement.status == true)
        then
            achievement.x = achievement.x - (multiplier/4)
        end

        if(asteroid1Status == true)
        then
            asteroid1x = asteroid1x - (multiplier/2)
        end
        if(asteroid2Status == true)
        then
            asteroid2x = asteroid2x - (multiplier/2)
        end
        if(asteroid3Status == true)
        then
            asteroid3x = asteroid3x - (multiplier/2)
        end
        if(asteroid4Status == true)
        then
            asteroid4x = asteroid4x - (multiplier/2)
        end


        if(math.floor(score) == 100)
        then
            asteroid2Status = true
        end


        if(math.floor(score) == 200)
        then
            asteroid3Status = true
        end


        if(math.floor(score) == 300)
        then
            asteroid4Status = true
        end


        
        


        checkIfPlanetsClipped(dt)
        checkIfBackgroundImagesClipped()

        
         
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
          
          

            

       
        score = score + dt 
        

        scorex = (PlayAreaWidth/2) - ((font:getWidth("SCORE : "..math.floor(0.5+score))*0.5)/2)
        scorey = (PlayAreaHeight/2)- ((font:getHeight("SCORE : "..math.floor(0.5+score))*0.5)/2)
        restartbuttony = scorey + 10 +(font:getHeight("SCORE : "..math.floor(0.5+score))*0.5)
        
        

        
             --[[
            x,y = love.mouse.getPosition()
            shipexpectedy = y - 27.5
            ]]--
           
            
           

            
            
            if(shipthrusterplaying == false)
            then
                --shipthrusters:play()
                shipthrusterplaying = true
            end

            
                shipy = (lerppos((shipy),getReverseScaledY(shipexpectedy),0.1))
                
                if(getScaledY(shipy+shipheight) > WindowHeight)
                then
                      shipy = getReverseScaledY(WindowHeight) - shipheight
                end 
            
            
           
                --shipy = lerppos(shipy,shipexpectedy,0.1) --shipy+(20+shipupdownspeed)
                --shipy = shipy + 2 + shipupdownspeed--shipy + ((shipy+20+shipupdownspeed)-shipy) * 0.2
            
            

        

        checkIfAsteroidClipped(dt)

        if(activateLightSpeed == true)
        then
            whenLightSpeed(dt)
        end

        if(deactivateLightSpeed == true)
        then
            whenDeactivatingLightSpeed(dt)
        end

        --print(multiplier.." "..score)
        --[[
        if(math.floor(score) % 50 == 0)
        then
            multiplier = multiplier + 0.1
            shipupdownspeed = shipupdownspeed + 0.5
        end]]--
        multiplier = multiplier + 0.0001

        if(shipanimationframe < 18)
        then
            shipanimationframe = shipanimationframe + 1
            shipanimation.image = shipanimation[shipanimationframe]

        else
            shipanimationframe = 1
        end
        width = love.graphics.getDimensions()
    
        psystem:update(dt)
        lightsystem:update(dt)
        
        
        animateLightSpeedIcon(dt)
        checkCollisionBetweenShipAndLightSpeedIcon(dt)
        updateOlivine(dt)
        updateParticleSystem(dt)
        planetUpdate(dt)
        updateblinkingstars(dt)
        updateshootingstars(dt)
        --print(score)




        
    elseif(gamestate == "pause")
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
        if(multiplier >= 10)
        then
            multiplier = multiplier - 1
        end
        planetUpdate(dt)
        updateblinkingstars(dt)
        updateshootingstars(dt)
    elseif(gamestate == "loading1")
    then
        
        loadresourcepack1()
        gamestate = "loading2"
        
    elseif(gamestate == "loading2")
    then
        loadresourcepack2()
        gamestate = "loading3"

    elseif(gamestate == "loading3")
    then
        loadresourcepack3()
        gamestate = "loading4"

    elseif(gamestate == "loading4")
    then
        loadresourcepack4()
        gamestate = "loading5"

    elseif(gamestate == "loading5")
    then
        loadresourcepack5()
        gamestate = "loading6"

    elseif(gamestate == "loading6")
    then
        loadresourcepack6()
        gamestate = "loading7"

    elseif(gamestate == "loading7")
    then
        loadresourcepack7()
        gamestate = "loading8"

    elseif(gamestate == "loading8")
    then
        loadresourcepack8()
        gamestate = "loading9"

    elseif(gamestate == "loading9")
    then
        loadresourcepack9()
        gamestate = "loading10"

    elseif(gamestate == "loading10")
    then
        loadresourcepack10()
        gamestate = "loading11"

    elseif(gamestate == "loading11")
    then
        loadresourcepack11()
        gamestate = "loading12"

        
    elseif(gamestate == "loading12")
    then
        loadresourcepack12()
        gamestate = "loading13"

    elseif(gamestate == "loading13")
    then
        loadresourcepack13()
        gamestate = "loading14"

    elseif(gamestate == "loading14")
    then
        loadresourcepack14()
        gamestate = "loading15" 

    elseif(gamestate == "loading15")
    then        
        loadresourcepack15() 
        gamestate = "startmenu"
        
        

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
        
        if(returnIfCurrentlyInLightSpeedOrDeactivatingLightSpeed() == true)
        then
            asteroid1x = -40

        else

            asteroid1x = math.random(896,896+100)
            asteroid1y = math.random(5,414-50)
        end

    end

    if(asteroid2x <= -50)
    then 
         
        if(returnIfCurrentlyInLightSpeedOrDeactivatingLightSpeed() == true)
        then
            asteroid2x = -40

        else

            asteroid2x = math.random(896+200,896+300)
            asteroid2y = math.random(5,414-50)
        end
    end 

    if(asteroid3x <= -50)
    then 
        if(returnIfCurrentlyInLightSpeedOrDeactivatingLightSpeed() == true)
        then
            asteroid3x = -40

        else

            asteroid3x = math.random(896+300,896+400)
            asteroid3y = math.random(5,414-50)
        end
    end

    if(asteroid4x <= -50)
    then 
        if(returnIfCurrentlyInLightSpeedOrDeactivatingLightSpeed() == true)
        then
            asteroid4x = -40

        else

            asteroid4x = math.random(896+400,896+500)
            asteroid4y = math.random(5,414-50)
        end
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
    if(gamestate == "startmenu" or gamestate == "pause" or gamestate == "play")
    then
        touchStatus = true
        
        puncStatus = checkIfClickedOnPunch(x,y)

        if(punchStatus == false)
        then
            shipexpectedy = y 
        end
    end
    
end
function love.touchmoved( id, x, y, dx, dy, pressure )

    if(gamestate == "startmenu" or gamestate == "pause" or gamestate == "play")
    then
        shipexpectedy = y 
    end
end
function love.touchreleased( id, x, y, dx, dy, pressure )
    if(gamestate == "startmenu" or gamestate == "pause" or gamestate == "play")
    then
        touchStatus = false
    end
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
            --shipexpectedy = (414/2)+shipheight
              
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

    if(gamestate == "startmenu" or gamestate == "pause" or gamestate == "play")
    then
    
        mouseTouchStatus = true
        
        --shipexpectedy = y
    
        
        --punchStatusMouse = checkIfClickedOnPunch(x,y)
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
end

function love.keyreleased( key, scancode )
    keyPressedStatus = false
    shipthrusters:stop()
    shipthrusterplaying = false
end

function love.mousereleased( x, y, button, istouch, presses )

    if(gamestate == "startmenu" or gamestate == "pause" or gamestate == "play")
    then    
        mouseTouchStatus = false
        keyPressedStatus = false
        shipthrusters:stop()
        shipthrusterplaying = false
    end
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
       

        if(activateLightSpeed == false and gamestate ~= "startmenu" and deactivateLightSpeed == false and lightSpeedGameIconActive == true)
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
        lightSpeedGameIconActive = false
        
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

function returnCollisionBetweenTwoObjects(object1X,object1Y,object1Width,object1Height,object2X,object2Y,object2Width,object2Height)

    if(getScaledX(object1X) < getScaledX(object2X+object2Width) and
       getScaledX((object1X)+object1Width) > getScaledX(object2X) and
        getScaledY(object1Y) < getScaledY(object2Y+object2Height) and
        getScaledY((object1Y) + object1Height) > getScaledY(object2Y))
    then
        return true
    else
        return false
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
    --asteroid1x = math.random(896+30,1792-30)
    asteroid1x = -30
    asteroid1y = math.random(30,414-30)
    asteroid2x = -30
    asteroid2y = math.random(30,414-30)
    asteroid3x = -30
    asteroid3y = math.random(30,414-30)
    asteroid4x = -30
    asteroid4y = math.random(30,414-30)

    asteroid1Status = true
    asteroid2Status = false
    asteroid3Status = false
    asteroid4Status = false

    shipupdownspeed = 0

    shipx = 896/6
    shipy = 414/2

    shipx2 = shipx + 182
    shipy2 = shipy + 54
    shipexpectedy = 414/2

    shipwidth = 170
    shipheight = 55

    score = 1
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

    lightSpeedGameIconActive = false
    lightSpeedAnimationIconActive = true

    setupLightSpeedAnimation()
    setupLightSpeedIconBreakingParticleSystem()

    resetOlivineAndItsParticleSystems()
    resetPlanets()
    OlivinesCollected = 0
    

end


function setupLightSpeedAnimation()
    lightspeedanimationx = math.random(896+30,1792-30)
    lightspeedanimationy = math.random(30,414-30-30)
    lightspeedanimation = {}
    lightspeedanimationframe = 1
    xforquads = 0
    indexforquadslightspeed = 0
    for incforquads = 0,(1890*2),140
    do 
        indexforquadslightspeed = indexforquadslightspeed + 1
        lightspeedanimation[indexforquadslightspeed] = love.graphics.newQuad(incforquads, 0,60,60,lightspeediconspritesheet:getDimensions())
    end
    
    lightspeedanimation.image = lightspeedanimation[lightspeedanimationframe]
    incrementor = 1
    lightspeedanimation.duration = 1
    lightspeedanimation.currentTime = 0
--[[
    indexforquads = 0
    for yforquad=0,1980,110
    do
        
        indexforquads = indexforquads+1
        shipanimation[indexforquads] = love.graphics.newQuad(0,yforquad,340,110,shipspritesheet:getDimensions())
    
    end
]]--
end


function returnIfCurrentlyInLightSpeedOrDeactivatingLightSpeed()

    if(activateLightSpeed == false and gamestate ~= "startmenu" and deactivateLightSpeed == false)
    then
        return false
    else
        return true
    end

end


function animateLightSpeedIcon(dt)

    if(math.floor(score+0.5) % 100 == 0 and returnIfCurrentlyInLightSpeedOrDeactivatingLightSpeed() == false)
    then
        love.graphics.print("here") 
        lightSpeedAnimationIconActive = true
    end


    if(lightSpeedAnimationIconActive == true)
    then

        lightspeedanimationx = lightspeedanimationx -(multiplier/4)
    end
    


    lightspeedanimation.currentTime = lightspeedanimation.currentTime + dt
    if lightspeedanimation.currentTime >= lightspeedanimation.duration then
        lightspeedanimation.currentTime = lightspeedanimation.currentTime - lightspeedanimation.duration
    end

    lightspeedanimationframe = math.floor(lightspeedanimation.currentTime / lightspeedanimation.duration * 24) + 1
    

    lightspeedanimation.image = lightspeedanimation[lightspeedanimationframe]

    
    checkIfLightSpeedIconClipped(dt)

    lightsystemx = lightsystemx - (multiplier/4)

    if(lightsystemactive == true)
    then
        lightsystemcurrenttime = lightsystemcurrenttime + dt
        xmaxlinearAcceleration = xmaxlinearAcceleration + 10
        --lightsystem:setLinearAcceleration(xminlinearAcceleration,yminlinearAcceleration,xmaxlinearAcceleration,ymaxlinearAcceleartion)
        if(xmaxlinearAcceleration >= 150)
        then
            lightsystem:pause()
            xmaxlinearAcceleration = 1
            lightsystemactive = false
        end

    end


    
    
    
    


   

    --[[
    if(lightspeedanimationframe < 23)
    then
        
        lightspeedanimationframe = lightspeedanimationframe + incrementor
        lightspeedanimation.image = lightspeedanimation[lightspeedanimationframe]
    else
       lightspeedanimationframe = 1
    end
    ]]--
end

function checkCollisionBetweenShipAndLightSpeedIcon(dt)
   

    if(returnCollisionBetweenTwoObjects(shipx,shipy,shipwidth,shipheight,lightspeedanimationx,lightspeedanimationy,30,30) == true)
    then
         
        lightsystem:start()
        lightsystemactive = true
        lightsystemx = lightspeedanimationx + 15
        lightsystemy = lightspeedanimationy + 15    
        
        lightSpeedGameIconActive = true
        lightSpeedAnimationIconActive = false
        math.randomseed(dt)
        lightspeedanimationx = 896+30
        lightspeedanimationy = math.random(30,414-30)
        

    end


end


function checkIfLightSpeedIconClipped(dt)

    if(lightspeedanimationx < -30)
    then
        math.randomseed(dt)
        lightspeedanimationx = 896+30
        lightspeedanimationy = math.random(30,414-30-30)
        lightSpeedAnimationIconActive = false
        lightsystemx = lightspeedanimationx
    end
    
    
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

function setupLightSpeedIconBreakingParticleSystem()

    lightsystemStatus = false

    lightsystem = love.graphics.newParticleSystem(lightspeediconbreaks, 100)
    lightsystem:setParticleLifetime(1) -- Particles live at least 2s and at most 5s. 
    lightsystem:setSpeed(1)
    
	lightsystem:setEmissionRate(100)    
    
    lightsystem:setSizes(0.3,0.4,0.2,0.4,0.4)
    xminlinearAcceleration = 0
    yminlinearAcceleration = 0
    xmaxlinearAcceleration = 1
    ymaxlinearAcceleartion = 0

    lightsystemRadialAcceleration = 1

    lightsystem:setEmissionArea('uniform', 10, 10, 0,true)
    --lightsystem:setRadialAcceleration(0,lightsystemRadialAcceleration)
    --lightsystem:setLinearAcceleration(xminlinearAcceleration,yminlinearAcceleration,xmaxlinearAcceleration,ymaxlinearAcceleartion)  -- Random movement in all directions.
	lightsystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
    --lightsystem:setRadialAcceleration(-590,590)
    lightsystem:stop()
    lightsystemx = 0
    lightsystemy = 0
      
    --[[   
    lightsystem:start()
    lightsystemx = 896/2
    lightsystemy  = 414/2
        ]]-- 
    lightsystemcurrenttime = 0
    lightsystemactive = false
    offsetx = 1
    offsety = 1
end




function love.draw()
    love.graphics.scale(WindowScaleFactorX,WindowScaleFactorY)
    
    if(gamestate == "startmenu")
    then
        --love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);
        
        love.graphics.draw(startbutton,startx,starty,0,0.5,0.5)

        
        drawblinkingstars()
        drawshootingstars()
        planetDraw()

    
    elseif(gamestate == "play")
    then
        --love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        love.graphics.draw(olivineanimation1[1],20+5,10+2+10,0,79/(79*10),140/(140*10))
        love.graphics.print(OlivinesCollected,40+5,10+10,0,0.4,0.4)
        love.graphics.draw(displayplanetimage,40+5+((font:getWidth(OlivinesCollected)*0.5))+15,10+1+10,0,90/(90*11),90/(90*11))
        love.graphics.print(planetsfound.." - 20",40+5+((font:getWidth(OlivinesCollected)*0.5))+15+30,10+10,0,0.4,0.4)
        
        love.graphics.scale(scalefactor, scalefactor)
        love.graphics.translate(translatefactorx, translatefactory)
        
        

        love.graphics.draw(planet2,planet2x,planet2y,planet2angle,24/(24*3),11/(11*3))
        love.graphics.draw(planet2blue,planet2bluex,planet2bluey,planet2blueangle,24/(24*3),11/(11*3))
        love.graphics.draw(planet1,planet1x,planet1y,planet1angle,16/(16*3),6/(6*3))
        love.graphics.draw(planet1green,planet1greenx,planet1greeny,planet1greenangle,16/(16*3),6/(5*3))

        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);

        drawblinkingstars()
        drawshootingstars()
        planetDraw()
        
        love.graphics.draw(particleAchievementSystem1.particleSystem,particleAchievementSystem1.x,particleAchievementSystem1.y)
        love.graphics.draw(particleAchievementSystem2.particleSystem,particleAchievementSystem2.x,particleAchievementSystem2.y)


        love.graphics.draw(olivineanimation1.image,olivineanimation1.x,olivineanimation1.y,0,olivineanimation1.scaleFactorX,olivineanimation1.scaleFactorY)
        love.graphics.draw(olivineanimation2.image,olivineanimation2.x,olivineanimation2.y,0,olivineanimation2.scaleFactorX,olivineanimation2.scaleFactorY)

        if(fadingparticleAchievementSystem1.particleSystem:isStopped() == false)
        then
            love.graphics.draw(fadingparticleAchievementSystem1.particleSystem,fadingparticleAchievementSystem1.x,fadingparticleAchievementSystem1.y)
        end
        

        if(fadingparticleAchievementSystem2.particleSystem:isStopped() == false)
        then
            love.graphics.draw(fadingparticleAchievementSystem2.particleSystem,fadingparticleAchievementSystem2.x,fadingparticleAchievementSystem2.y)
        end

        if(lightSpeedAnimationIconActive == true)
        then
            love.graphics.draw(lightspeediconspritesheet, lightspeedanimation[lightspeedanimationframe],lightspeedanimationx,lightspeedanimationy,0,0.5,0.5)
        end

        if(asteroid1Status == true)
        then
            love.graphics.draw(psystem,asteroid1x+(asteroid0width/2), asteroid1y+(asteroid0height/2))
        end

        if(asteroid2Status == true)
        then
            love.graphics.draw(psystem,asteroid2x+(asteroid0width/2), asteroid2y+(asteroid0height/2))
        
        end
        if(asteroid4Status == true)
        then
            love.graphics.draw(psystem,asteroid4x+(asteroid0width/2), asteroid4y+(asteroid0height/2))
        end

        if(asteroid4Status == true)
        then
            love.graphics.draw(psystem,asteroid3x+(asteroid0width/2), asteroid3y+(asteroid0height/2))
        end
        
        love.graphics.draw(asteroid0,asteroid1x,asteroid1y,0,30/(30*4),30/(30*4))
        
        love.graphics.draw(asteroid1,asteroid2x,asteroid2y,0,30/(30*4),30/(30*4))
        
        love.graphics.draw(asteroid3,asteroid3x,asteroid3y,0,30/(30*4),30/(30*4))
      
        love.graphics.draw(asteroid4,asteroid4x,asteroid4y,0,30/(30*4),30/(30*4))
        love.graphics.draw(lightsystem,lightsystemx,lightsystemy)

        --love.graphics.draw(olivineanimation.image,olivineanimation.x,olivineanimation.y,0,olivineanimation.scaleFactorX,olivineanimation.scaleFactorY)
        
        

        love.graphics.draw(shipspritesheet,shipanimation.image,shipx,shipy,0,0.5,0.5)


        
        --love.graphics.circle('fill',shipx,getReverseScaledY(shipexpectedy),10)
       
        --love.graphics.draw(up,upx,upy,0,0.5,0.5)
        --love.graphics.draw(down,downx,downy,0,0.5,0.5)
        if(activateLightSpeed == false and deactivateLightSpeed == false and lightSpeedGameIconActive == true)
        then
            
            love.graphics.draw(punch,punchx,punchy,0,0.5,0.5)
            --love.graphics.draw(achievement.image,punchx+50+10,punchy,0,95/(95*4),95/(95*4))
        end

        
        
       --[[     
        love.graphics.rectangle("line",shipx+110,shipy+8,50,22-8)
        love.graphics.rectangle("line",shipx+99,shipy+39,36,15)
        love.graphics.rectangle("line",shipx+48,shipy+39,49,6)
        love.graphics.rectangle("line",shipx+24,shipy+13,70,15)
        
        love.graphics.rectangle("line",shipx,shipy,shipwidth,shipheight)

        love.graphics.rectangle("line",asteroid1x,asteroid1y,asteroid0width,asteroid0height)
        love.graphics.rectangle("line",asteroid2x,asteroid2y,asteroid0width,asteroid0height)
        love.graphics.rectangle("line",asteroid3x,asteroid3y,asteroid0width,asteroid0height)
        love.graphics.rectangle("line",asteroid4x,asteroid4y,asteroid0width,asteroid0height)
    
        love.graphics.rectangle("line",lightspeedanimationx,lightspeedanimationy,30,30)

        checkCollisionBetweenTwoObjects(shipx+100,shipy+2,70,22,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+99,shipy+39,36,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+48,shipy+39,49,6,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        checkCollisionBetweenTwoObjects(shipx+24,shipy+13,70,15,asteroid2x,asteroid2y,asteroid0width,asteroid0height);
        ]]--
        


    elseif(gamestate == "pause")
    then
        --love.graphics.draw(backgroundcolor,0,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer0,backgroundlayer0x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer1,backgroundlayer1x,0,0,0.5,0.5);
        love.graphics.draw(backgroundlayer3,backgroundlayer3x,0,0,0.5,0.5);
        
        love.graphics.print("SCORE : "..OlivinesCollected,scorex,scorey,0,0.5,0.5)
        love.graphics.draw(restartbutton,restartbuttonx,restartbuttony,0,0.5,0.5)
        drawblinkingstars()
        drawshootingstars()
        planetDraw()


    elseif(gamestate  == "loading1" or gamestate == "loading2" or gamestate == "loading3" or gamestate == "loading4" or gamestate == "loading5" or gamestate == "loading6" or gamestate == "loading7" or gamestate == "loading8" or gamestate == "loading9" or gamestate == "loading10" or gamestate == "loading11" or gamestate == "loading12" or gamestate == "loading13" or gamestate == "loading14" or gamestate == "loading15")
    then
        love.graphics.draw(splashicon,896/2-(75/2),414/2-(75/2),0,0.5,0.5)
        love.graphics.draw(LOADING,(896/2)-(120/2),414/2+(75/2)+30,0,0.5,0.5)
    end
    
end



--[[
function loadAnimation(foldername,imagename, frames, duration)

    local animation = {}
    animation.frame = 1
    animation.currentTime = 0
    animation.frames = frames
    animation.duration = duration
    animation.x = 0
    animation.y = 0
    animation.scaleX = 1
    animation.scaleY = 1
    animation.status = "pause"
    for i=1,frames,1
    do
        animation[i] = love.graphics.newImage(foldername.."/"..imagename.." "..i.. ".png")
    end
    animation.image = animation[animation.frame]
    return animation
end



function updateAniamtion(dt, animation)

    if(animation.status == "play")
    then
        animation.currentTime = animation.currentTime + dt
        if(animation.currentTime > animation.duration)
        then
            animation.currentTime = animation.currentTime - animation.duration
        end
        animation.frame = math.floor(animation.currentTime / animation.duration * animation.frames ) + 1 
        animation.image = animation[animation.frame]
    
    end

end

function drawAnimation(animation)

    if(animation.status == "play")
    then
        love.graphics.draw(animation.image,animation.x,animation.y,0,animation.scaleX,animation.scaleY)
    end
end
]]--