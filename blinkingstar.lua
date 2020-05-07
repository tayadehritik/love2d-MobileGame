

function loadblinkingstars()

    blinkstaranimation1 = loadAnimation("animation/blinkingstar","blinkingstar",11,1)
    blinkstaranimation1.scaleX = 0.25
    blinkstaranimation1.scaleY = 0.25

    blinkstaranimation2 = loadAnimation("animation/blinkingstar1","blinkingstar1",11,1)
    blinkstaranimation2.scaleX = 0.25
    blinkstaranimation2.scaleY = 0.25
end



function updateblinkingstars(dt)

    updateAnimationWithoutLooping(dt,blinkstaranimation1)
    updateAnimationWithoutLooping(dt,blinkstaranimation2)

    if(blinkstaranimation1.status == "pause")
    then
        
        blinkstaranimation1.x = math.random(10,896-10)
        blinkstaranimation1.y = math.random(10,414-10) 
        blinkstaranimation1.status = "play"
      
    end

    if(blinkstaranimation2.status == "pause")
    then
        
        blinkstaranimation2.x = math.random(20,896-20)
        blinkstaranimation2.y = math.random(10,414-10) 
        blinkstaranimation2.status = "play"
    end


    if(blinkstaranimation1.status == "play")
    then
        blinkstaranimation1.x = blinkstaranimation1.x - (multiplier/6)
    end

    if(blinkstaranimation2.status == "play")
    then
        blinkstaranimation2.x = blinkstaranimation2.x - (multiplier/6)
    end

end


function drawblinkingstars()

    drawAnimation(blinkstaranimation1)
    drawAnimation(blinkstaranimation2)

end