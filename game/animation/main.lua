function love.load()

    foldername = "shootingstar"
    imagename = "shootingstar"
    frames = 11
    duration = 1
    animation1 = loadAnimation(foldername,imagename,frames,duration)
    animation1.scaleX = 1
    animation1.scaleY = 1
    animation1.status = "play"
    animation1.x = 10
    animation1.rotation = -43.4

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

    
    updateAnimationWithoutLooping(dt, animation1) 
    if(animation1.status == "pause")
    then
        animation1.x = math.random(10,100)
        animation1.y = math.random(10,100)
        animation1.status = "play"
    end

    if(animation1.status == "play")
    then
        animation1.x = lerppos(animation1.x,animation1.x+10,0.5)
        animation1.y = lerppos(animation1.y,animation1.y+10,0.5)
    end
   
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