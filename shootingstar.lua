

function loadshootingstars()

    shootingstar1 = loadAnimation("animation/shootingstar","shootingstar",11,1)
    shootingstar1.rotation = -43.4
    shootingstar1.scaleX = 0.5
    shootingstar1.scaleY = 0.5
    
end

function updateshootingstars(dt)

    updateAnimationWithoutLooping(dt,shootingstar1)

    if(math.floor(score) % 10 == 0)
    then
        if(shootingstar1.status == "pause")
        then
            shootingstar1.x = math.random(50,896-50)
            shootingstar1.y = math.random(2,414-2)
            shootingstar1.status = "play"
        end
    end

    if(shootingstar1.status == "play")
    then
        shootingstar1.x = lerppos(shootingstar1.x,shootingstar1.x+(multiplier/1),0.2)
        shootingstar1.y = lerppos(shootingstar1.y,shootingstar1.y+(multiplier/1),0.2)

    end

end

function drawshootingstars()

    drawAnimation(shootingstar1)

end