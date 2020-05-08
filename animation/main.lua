function love.load()

    foldername = "planet9"
    imagename = "planet9"
    frames = 48
    duration = 2
    animation1 = loadAnimation(foldername,imagename,frames,duration)
    animation1.scaleX = 1
    animation1.scaleY = 1
    animation1.status = "play"
    animation1.x = 100
    

end


function loadAnimation(foldername,imagename, frames, duration)

    local animation = {}
    animation.frame = 1
    animation.currentTime = 0
    animation.frames = frames
    animation.duration = duration
    animation.rotation = 0
    animation.x = 0
    animation.y = 0
    animation.scaleX = 1
    animation.scaleY = 1
    animation.status = "pause"
    animation.completeStatus = false
    for i=1,frames,1
    do
        animation[i] = love.graphics.newImage(foldername.."/"..imagename.." "..i.. ".png")
    end
    animation.image = animation[animation.frame]
    return animation
end


function love.update(dt)

    
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

function updateAnimationWithoutLooping(dt,animation)

    if(animation.status == "play")
    then
        animation.currentTime = animation.currentTime + dt
        if(animation.currentTime > animation.duration)
        then
            animation.status = "pause"
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
        love.graphics.draw(animation.image,animation.x,animation.y,animation.rotation,animation.scaleX,animation.scaleY)
    end
end

function lerppos(initial_value, target_value, speed)
	local result = (1-speed) * initial_value + speed*target_value
	return result
end