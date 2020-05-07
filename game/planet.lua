
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

    planetanimationtable = {}
    planetanimationtable.index = 0
    --planetanimationtable.status = false
    planetanimationtable[0] = planetanimation0
    planetanimationtable[1] = planetanimation1
    planetanimationtable[2] = planetanimation2
    planetanimationtable[3] = planetanimation3
    planetanimationtable.animation = planetanimationtable[planetanimationtable.index]
    planetsfound = 0
    planetfoundstatus = false
    displayplanetimage = planetanimation0[1]

end

function planetUpdate(dt)

    updateAnimation(dt,planetanimationtable.animation)
   
    
    
    if(math.floor(score) % 50 == 0 and planetanimationtable.index <= 3)
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
    planetanimationtable.animation = planetanimationtable[planetanimationtable.index]
    planetsfound = 0
    displayplanetimage = planetanimation0[1]

end

function planetDraw()
    drawAnimation(planetanimationtable.animation)
end