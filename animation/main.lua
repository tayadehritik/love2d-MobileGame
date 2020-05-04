function love.load()

    foldername = "planet0"
    imagename = "planet0"
    frames = 13
    duration = 1
    animation1 = loadAnimation(foldername,imagename,frames,duration)

end


function loadAnimation(foldername,imagename, frames, duration)

    local animation = {}
    animation.frame = 1
    animation.currentTime = 0
    animation.frames = frames
    animation.duration = duration
    animation.x = 0
    animation.y = 0
    animation.status = "pause"
    for i=1,frames,1
    do
        animation[i] = love.graphics.newImage(foldername.."/"..imagename.." "..i.. ".png")
    end
    animation.image = animation[animation.frame]
    return animation
end


function love.update(dt)

    animation1.status = "play"
    updateAniamtion(dt, animation1) 
   
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

function love.draw()

    drawAnimation(animation1)    
    
end

function drawAnimation(animation)

    if(animation.status == "play")
    then
        love.graphics.draw(animation.image,animation.x,animation.y)
    end
end