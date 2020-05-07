


function loadresourcepack1()
    olivineanimation1 = {}
    olivineanimation2 = {}
    olivineanimation3 = {}
    olivineanimation4 = {}
    particleAchievementImage = love.graphics.newImage("assets/layers/particleachievement.png")

    particleAchievementSystem1 = {}
    particleAchievementSystem2 = {}

    fadingparticleAchievementSystem1 = {}
    fadingparticleAchievementSystem2 = {}

    return true
end


function loadresourcepack2()



    backgroundlayer0 = love.graphics.newImage("assets/layers/backgroundlayer0(5).png")

    backgroundlayer1 = love.graphics.newImage("assets/layers/backgroundlayer1(8).png")

    

    return true
   
end


function loadresourcepack3()

    backgroundlayer3 = love.graphics.newImage("assets/layers/backgroundlayer3(10).png")

    backgroundlayer5 = love.graphics.newImage("assets/layers/backgroundlayer5(still).png")

    return true
end


function loadresourcepack4()

    startbutton = love.graphics.newImage("assets/layers/startbutton.png")

    up = love.graphics.newImage("assets/layers/up.png")
    down = love.graphics.newImage("assets/layers/down.png")

    restartbutton = love.graphics.newImage("assets/layers/restart.png")

    backgroundcolor = love.graphics.newImage("assets/layers/backgroundcolor.png")

    asteroid0 = love.graphics.newImage("assets/layers/asteroid(0).png")

    lightspeediconspritesheet = love.graphics.newImage("assets/layers/lightspeediconanimationspritesheet.png")

    lightspeediconbreaks = love.graphics.newImage("assets/layers/lightspeediconbreaks.png")

    return true
end

function loadresourcepack5()



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

    return true
end


function loadresourcepack6()


   

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


    img = love.graphics.newImage('assets/layers/particle.png')

    return true

end



function loadresourcepack7()

    psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s. 
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(0, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.


 
    
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

    return true
end


function loadresourcepack8()


    loadandSetupOlivine()

    

    return true
end

function loadresourcepack9()

    loadAchievementParticleSystem()

    return true

end


function loadresourcepack10()




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

    return true

end

function loadresourcepack11()

    setupLightSpeedAnimation()
    setupLightSpeedIconBreakingParticleSystem()
    return true
end

function  loadresourcepack12()

    resetOlivineAndItsParticleSystems()
    return true
end


function loadresourcepack13()

    resetPlanets()
    OlivinesCollected = 0
    width = 0
    return true
end

function loadresourcepack14()

    loadblinkingstars()

    return true

end


function loadresourcepack15()

    loadshootingstars()
    return true
end