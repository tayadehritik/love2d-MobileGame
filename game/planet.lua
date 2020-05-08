
function planetLoad()


    planetanimation0 = loadAnimation("animation/planet0","planet0",48,2)
    planetanimation0.scaleX = 0.5
    planetanimation0.scaleY = 0.5

    planetanimation1 = loadAnimation("animation/planet1","planet1",48,2)
    planetanimation1.scaleX = 0.5
    planetanimation1.scaleY = 0.5

    planetanimation2 = loadAnimation("animation/planet2","planet2",48,2)
    planetanimation2.scaleX = 0.5
    planetanimation2.scaleY = 0.5

    planetanimation3 = loadAnimation("animation/planet3","planet3",48,2)
    planetanimation3.scaleX = 0.5
    planetanimation3.scaleY = 0.5


    planetanimation4 = loadAnimation("animation/planet4","planet4",48,2)
    planetanimation4.scaleX = 0.5
    planetanimation4.scaleY = 0.5


    planetanimation5 = loadAnimation("animation/planet5","planet5",48,2)
    planetanimation5.scaleX = 0.5
    planetanimation5.scaleY = 0.5

    planetanimation6 = loadAnimation("animation/planet6","planet6",48,2)
    planetanimation6.scaleX = 0.5
    planetanimation6.scaleY = 0.5

    planetanimation7 = loadAnimation("animation/planet7","planet7",48,2)
    planetanimation7.scaleX = 0.5
    planetanimation7.scaleY = 0.5

    planetanimation8 = loadAnimation("animation/planet8","planet8",48,2)
    planetanimation8.scaleX = 0.5
    planetanimation8.scaleY = 0.5

    planetanimation9 = loadAnimation("animation/planet9","planet9",48,2)
    planetanimation9.scaleX = 0.5
    planetanimation9.scaleY = 0.5




    planetanimationtable = {}
    planetanimationtable.index = 0
    --planetanimationtable.status = false
    planetanimationtable[0] = planetanimation0
    planetanimationtable[1] = planetanimation1
    planetanimationtable[2] = planetanimation2
    planetanimationtable[3] = planetanimation3
    planetanimationtable[4] = planetanimation4

    planetanimationtable[5] = planetanimation5
    planetanimationtable[6] = planetanimation6
    planetanimationtable[7] = planetanimation7
    planetanimationtable[8] = planetanimation8
    planetanimationtable[9] = planetanimation9

    planetanimationtable.animation = planetanimationtable[planetanimationtable.index]
    planetsfound = 0
    planetfoundstatus = false
    displayplanetimage = planetanimation0[1]

end

function planetUpdate(dt)

    updateAnimation(dt,planetanimationtable.animation)
   
    
    
    if(math.floor(score) % 110 == 0 and planetanimationtable.index <= 9)
    then
        planetanimationtable.animation = planetanimationtable[planetanimationtable.index]
        planetanimationtable.animation.x = math.random(896,1792)
        planetanimationtable.animation.y = math.random(0,414-95)
        planetanimationtable.animation.status = "play"
        
        
    end
    
    if(planetanimationtable.animation.status == "play")
    then
        planetanimationtable.animation.x = planetanimationtable.animation.x - (multiplier/4)

        
    end


    if(planetanimationtable.animation.x < 895 and planetanimationtable.animation.status == "play")
    then

        if(planetfoundstatus == false)
        then
            planetsfound = planetsfound + 1
            displayplanetimage = planetanimationtable.animation[1]
            planetfoundstatus = true
        end

    end


    if(planetanimationtable.animation.x < -90 and planetanimationtable.animation.status == "play")
    then
        planetanimationtable.animation.status = "pause"
        planetanimationtable.index  = planetanimationtable.index + 1
        planetfoundstatus = false
    end

    


end

function ActivatePlanets(dt)

end

function ClipPlanets(dt)


end


function resetPlanets()

    planetanimationtable.index = 0
    --planetanimationtable.status = false
    planetanimationtable[0] = planetanimation0
    planetanimationtable[1] = planetanimation1
    planetanimationtable[2] = planetanimation2
    planetanimationtable[3] = planetanimation3
    planetanimationtable[4] = planetanimation4
    planetanimationtable[5] = planetanimation5
    planetanimationtable[6] = planetanimation6
    planetanimationtable[7] = planetanimation7
    planetanimationtable[8] = planetanimation8
    planetanimationtable[9] = planetanimation9
    planetanimationtable.animation = planetanimationtable[planetanimationtable.index]
    planetsfound = 0
    displayplanetimage = planetanimation0[1]

end

function planetDraw()
    drawAnimation(planetanimationtable.animation)
end