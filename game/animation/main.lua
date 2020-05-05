function love.load()

    foldername = "planet3"
    imagename = "planet3"
    frames = 48
    duration = 2
    animation1 = loadAnimation(foldername,imagename,frames,duration)
    animation1.scaleX = 0.5
    animation1.scaleY = 0.5

end


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


function love.update(dt)

    animation1.status = "play"
    updateAnimation(dt, animation1) 
   
end

function updateAnimation(dt, animation)

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
    animation1.x = 414/2
    drawAnimation(animation1)    
    
end

function drawAnimation(animation)

    if(animation.status == "play")
    then
        love.graphics.draw(animation.image,animation.x,animation.y,0,animation.scaleX,animation.scaleY)
    end
end