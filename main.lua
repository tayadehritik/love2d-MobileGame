push = require 'push'
GAMESTATE = "titlescreen"
PLAYERSTATE = "idle"
WIDTH, HEIGHT = love.graphics.getDimensions()
BACKGROUND_LAYER0 = love.graphics.newImage("assets/layers/parallax-mountain-bg.png")
BACKGROUND_LAYER1 = love.graphics.newImage("assets/layers/parallax-mountain-mountain-far.png")
BACKGROUND_LAYER2 = love.graphics.newImage("assets/layers/parallax-mountain-mountains.png")
BACKGROUND_LAYER3 = love.graphics.newImage("assets/layers/parallax-mountain-trees.png")
BACKGROUND_LAYER4 = love.graphics.newImage("assets/layers/parallax-mountain-foreground-trees.png")



PLAYER_IDLE = love.graphics.newImage("assets/megabot/png-files/player/idle.png")
PLAYER_RUN = {

    [1] = love.graphics.newImage("assets/megabot/png-files/player/run1.png"),
    [2] = love.graphics.newImage("assets/megabot/png-files/player/run2.png"),
    [3] = love.graphics.newImage("assets/megabot/png-files/player/run3.png"),
    [4] = love.graphics.newImage("assets/megabot/png-files/player/run4.png"),
    [5] =  love.graphics.newImage("assets/megabot/png-files/player/jump.png")

}

 
TILE_SET =  love.graphics.newImage("assets/megabot/png-files/tileset.png")
VIRTUAL_WIDTH = love.graphics.getWidth() --[272]--
VIRTUAL_HEIGHT = love.graphics.getHeight()  --[160]--
BOTRunningX = 0
BOTRunningY = VIRTUAL_HEIGHT-24-32
BOTIdleX = 0
BOTIdleY = VIRTUAL_HEIGHT-24-32
TileSetW = TILE_SET:getWidth()
TileSetH = TILE_SET:getHeight()
Platform_Quad = love.graphics.newQuad(48,48,48,48,TileSetW,TileSetH)

SPRITE0 = love.graphics.newQuad(0,96-15,16,31,TileSetW,TileSetH)
SPRITE1 = love.graphics.newQuad(32,96-15,16,31,TileSetW,TileSetH)
SPRITE2 = love.graphics.newQuad(32+16,96,16,16,TileSetW,TileSetH)

SPRITE0_X = VIRTUAL_WIDTH + 10
SPRITE1_X = SPRITE0_X + 20
SPRITE2_X = SPRITE1_X + 30

CURRENT_Height = 0
CURRENT_Width = 0

SPRITE1_Y = VIRTUAL_HEIGHT-24-28
SPRITE0_Y = VIRTUAL_HEIGHT-24-28
SPRITE2_Y = VIRTUAL_HEIGHT-24-22

runningIndex = 1

FLOOR_SPRITE = 544
CEIL_SPRITE = 272+10

SPRITE_0_POSITIONALWIDTH = 0
SPRITE_0_POSITIONALHEIGHT = 0
SPRITE_1_POSITIONALWIDTH = 0
SPRITE_1_POSITIONALHEIGHT = 0
SPRITE_2_POSITIONWIDTH = 0
SPRITE_2_POSITIONALHEIGHT = 0
PLAYER_POSITIONALWIDTH = 0
PLAYER_POSITIONALHEIGHT = 0

FLOORX = 544
LAYER_0_X = 0
LAYER_1_X = 0
LAYER_2_X = 0
LAYER_3_X = 0
LAYER_4_X = 0

Layer4width = BACKGROUND_LAYER4:getWidth();

Scale_layer1_y =  love.graphics.getHeight()  / BACKGROUND_LAYER0:getHeight() 
Scale_layer1_x = love.graphics.getWidth() / BACKGROUND_LAYER1:getWidth() 

Scale_layer4_y = love.graphics.getHeight() / 166
Scale_layer4_x = love.graphics.getWidth() / 544

Scale_platformquad_y = love.graphics.getHeight() / 48
Scale_platformquad_x = love.graphics.getWidth() / 48
timepassed = 0

GRAVITY = 100

CrossingStatus = false;

score = 0
status = 0

-- TODO : make sure random sprites don't overlap each other.

function love.load()
    
    smallfont = love.graphics.newFont("font.ttf",8)
    mediumfont = love.graphics.newFont("flappy.ttf",14)
    largefont = love.graphics.newFont("flappy.ttf",28)
    hugefont = love.graphics.newFont("flappy.ttf",56)    
    --push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT, {resizable=true, vsync=false})
    
    love.window.setMode(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, {resizable=true, vsync=false})
    Xcoor = 0
    love.touch.displaytouched = false
    love.keyboard.keysPressed = {}
    math.randomseed(os.time())
    
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.touchpressed( id, x, y, dx, dy, pressure )

    love.touch.displaytouched = true
end

function love.touch.wasTouched()
    return love.touch.displaytouched
    
    
end

function love.update(dt)
    playstate(dt)
    
    if(love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.touch.wasTouched() and GAMESTATE == "titlescreen")
    then
        
        GAMESTATE = "playstate"
        PLAYERSTATE = "running"
        
        love.keyboard.keysPressed['enter'] = false
        love.keyboard.keysPressed['return'] = false
        love.touch.displaytouched = false
        
    end
    
    if(GAMESTATE == "playstate" and PLAYERSTATE == "running")
    then
        
        checkPlayerCollisionWithFloor(dt)
        checkPlayerCollisionWithSprites()
        
        if(love.touch.wasTouched() or love.keyboard.wasPressed('space') )
        then
            
            PLAYERSTATE = "jumping"
            runningIndex = 5
            print("jump")

        end

    end
    
    if(PLAYERSTATE == "jumping" and GAMESTATE == "playstate")
    then
        
        checkPlayerCollisionWithJumpLimit(dt)
        
    end
    
    --[[
    SPRITE_0_POSITIONALWIDTH = SPRITE0_X + 16
    SPRITE_1_POSITIONALWIDTH = SPRITE1_X + 16
    SPRITE_2_POSITIONALWIDTH = SPRITE2_X + 16

    SPRITE_0_POSITIONALHEIGHT = SPRITE0_Y + 31
    SPRITE_1_POSITIONALHEIGHT = SPRITE1_Y + 31
    SPRITE_2_POSITIONALHEIGHT = SPRITE2_Y + 16

    PLAYER_POSITIONALWIDTH = BOTRunningX + 28
    PLAYER_POSITIONALHEIGHT = BOTRunningY + 28

   ]]--
    

end

function love.resize(width, height)
    Scale_layer1_y =  love.graphics.getHeight()  / BACKGROUND_LAYER0:getHeight() 
    Scale_layer1_x = love.graphics.getWidth() / BACKGROUND_LAYER1:getWidth() 
    
    Scale_layer4_y = love.graphics.getHeight() / 166
    Scale_layer4_x = love.graphics.getWidth() / 544

    Scale_platformquad_y = love.graphics.getHeight() / 48
    Scale_platformquad_x = love.graphics.getWidth() / 48

    VIRTUAL_HEIGHT = love.graphics.getHeight()
    VIRTUAL_WIDTH = love.graphics.getWidth()
end


function checkPlayerCollisionWithJumpLimit(dt)
    
    if(BOTRunningY <= 70)
    then
        PLAYERSTATE = "running"
        checkPlayerCollisionWithFloor(dt)
        

    else
        BOTRunningY = BOTRunningY - GRAVITY * dt
        
    end

end

function checkPlayerCollisionWithFloor(dt)
    if(BOTRunningY <= VIRTUAL_HEIGHT - 53)
    then
        BOTRunningY = BOTRunningY + GRAVITY *dt 
        love.touch.displaytouched = false
        love.keyboard.keysPressed['space'] = false
    else
        if(runningIndex == 5)
        then
            runningIndex = 1    
        end
    end
    
end


function checkPlayerCollisionWithSprites()


end

function updateScore()

    if(PLAYER_POSITIONALWIDTH > SPRITE_0_POSITIONALWIDTH)
    then 
        score = score + 1

    end

    

end


function playstate(dt)

    timepassed = timepassed + 1 * dt
    if(BOTRunningX < VIRTUAL_WIDTH /2 - 50)
    then
        BOTRunningX = BOTRunningX + 80 * dt
    end
    
    if(timepassed >= 0.131554799898) 
    then
        timepassed = 0
        if(runningIndex == 5)
        then

        else
            playerrun()
        end
    end
    FLOORX = FLOORX - 1.8
    LAYER_4_X = LAYER_4_X - 1.7
    LAYER_3_X = LAYER_3_X - 1.0
    LAYER_2_X = LAYER_2_X - 0.5   

    SPRITE0_X = SPRITE0_X - 2
    SPRITE1_X = SPRITE1_X - 2
    SPRITE2_X = SPRITE2_X - 2
    --TODO = fix layer4 animation
    if(LAYER_4_X <= -VIRTUAL_WIDTH)
    then
        LAYER_4_X = 0
    end

    if(LAYER_3_X <= -VIRTUAL_WIDTH)
    then
        LAYER_3_X = 0
    end

    if(LAYER_2_X <= -VIRTUAL_WIDTH)
    then
        LAYER_2_X = 0
    end

  
    if(SPRITE0_X <= -16)
    then
        
        SPRITE0_X =  math.random(FLOOR_SPRITE,CEIL_SPRITE) --544
        
    end

    if(SPRITE1_X <= -16)
    then
        
        SPRITE1_X = math.random(FLOOR_SPRITE, CEIL_SPRITE)--[SPRITE0_X +20]-- --[random value between floor_sprite and base_sprite]--
    end

    if(SPRITE2_X <= -16)
    then
        SPRITE2_X = math.random(FLOOR_SPRITE,CEIL_SPRITE)--[SPRITE1_X + 20]-- --[random value between floor_sprite and base sprite]--
    end


end

function playerjump()



end


function playerrun(timepassed, counter)
    
    if(runningIndex ==  4) then
        
        runningIndex = 0
        
    end
    runningIndex = runningIndex + 1
    
end


function love.draw()
    --push:start()
    
   

    if(GAMESTATE == "playstate")
    then
        
        
        love.graphics.draw(BACKGROUND_LAYER0,LAYER_0_X,0,0, Scale_layer1_x ,Scale_layer1_y)
        love.graphics.draw(BACKGROUND_LAYER1,LAYER_1_X,0-24,0, Scale_layer1_x, Scale_layer1_y)
        love.graphics.draw(BACKGROUND_LAYER2,LAYER_2_X,0,0, Scale_layer1_x, Scale_layer1_y)
        --love.graphics.draw(BACKGROUND_LAYER3,LAYER_3_X,2)
       love.graphics.draw(BACKGROUND_LAYER4,LAYER_4_X,0-24 ,0,Scale_layer4_x,Scale_layer4_y)

        love.graphics.draw(TILE_SET,SPRITE0,SPRITE0_X,SPRITE0_Y)
        love.graphics.draw(TILE_SET,SPRITE1,SPRITE1_X,SPRITE1_Y)
        love.graphics.draw(TILE_SET,SPRITE2,SPRITE2_X,SPRITE2_Y)

        love.graphics.setFont(smallfont)
        love.graphics.printf(score, 0,0,VIRTUAL_WIDTH,'center')
        love.graphics.printf(status, 0,0,VIRTUAL_WIDTH,'left')
        
        
        if(FLOORX <=  VIRTUAL_WIDTH-48)
        then
            FLOORX = VIRTUAL_WIDTH
        end
        for i=FLOORX,-48,- 48
        do
            love.graphics.draw(TILE_SET,Platform_Quad,i,VIRTUAL_HEIGHT-48)
        end
        

        if(PLAYERSTATE == "idle")
        then
            
            love.graphics.draw(PLAYER_IDLE,BOTIdleX,BOTIdleY)
            
        elseif(PLAYERSTATE == 'running' or PLAYERSTATE == "jumping")
        then
                    
                love.graphics.draw(PLAYER_RUN[runningIndex],BOTRunningX,BOTRunningY)     
            
        end

        
    
    elseif(GAMESTATE == "titlescreen")
    then

        love.graphics.draw(BACKGROUND_LAYER0,LAYER_0_X,0)
        love.graphics.draw(BACKGROUND_LAYER1,LAYER_1_X,0)
        love.graphics.draw(BACKGROUND_LAYER2,LAYER_2_X,0)
        --love.graphics.draw(BACKGROUND_LAYER3,LAYER_3_X,0)
        love.graphics.draw(BACKGROUND_LAYER4,LAYER_4_X,0)
        
        

        love.graphics.setFont(mediumfont)
        love.graphics.printf("Start Game",0,VIRTUAL_HEIGHT/2,VIRTUAL_WIDTH,'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf("Touch to start",0,(VIRTUAL_HEIGHT/2)+20,VIRTUAL_WIDTH,'center')
        
        

    end
    
    --push:finish()
end