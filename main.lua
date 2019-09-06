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
    [4] = love.graphics.newImage("assets/megabot/png-files/player/run4.png")


}
 
TILE_SET =  love.graphics.newImage("assets/megabot/png-files/tileset.png")
VIRTUAL_WIDTH = 272
VIRTUAL_HEIGHT = 160
BOTRunningX = 0
BOTRunningY = VIRTUAL_HEIGHT-24-28
BOTIdleX = 0
BOTIdleY = VIRTUAL_HEIGHT-24-28
TileSetW = TILE_SET:getWidth()
TileSetH = TILE_SET:getHeight()
Platform_Quad = love.graphics.newQuad(48,48,48,48,TileSetW,TileSetH)

runningIndex = 0

FLOORX = 544
TREESX = 0
MOUNTAINSX = 0

function love.load()
    
    smallfont = love.graphics.newFont("font.ttf",8)
    mediumfont = love.graphics.newFont("flappy.ttf",14)
    largefont = love.graphics.newFont("flappy.ttf",28)
    hugefont = love.graphics.newFont("flappy.ttf",56)    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT, {resizable=true, vsync=false})
    Xcoor = 0
    love.touch.displaytouched = false
    love.keyboard.keysPressed = {}
    
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
    
    
    if(love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.touch.wasTouched())
    then
        
        GAMESTATE = "playstate"
        PLAYERSTATE = "running"
        love.touch.displaytouched = false
        if(BOTRunningX < VIRTUAL_WIDTH /2 - 15)
        then
            BOTRunningX = BOTRunningX + 80 * dt
        end
        
        
        playerrun()

        
        

    end

    

end

function love.resize(width, height)
    push:resize(width, height)
end

function playerrun()

    
    
        
        if(runningIndex ==  4) then
            runningIndex = 0
        end
        runningIndex = runningIndex + 1
        

    

end


function love.draw()
    push:start()
    love.graphics.draw(BACKGROUND_LAYER0,0,0)
    love.graphics.draw(BACKGROUND_LAYER1,0,0)
    love.graphics.draw(BACKGROUND_LAYER2,0,0)
    love.graphics.draw(BACKGROUND_LAYER3,0,0)
    love.graphics.draw(BACKGROUND_LAYER4,0,0)
    
    if(GAMESTATE == "playstate")
    then
        
        if(FLOORX ==  272-48)
        then
            FLOORX = 272
        end
        for i=FLOORX,-48,- 48
        do
            love.graphics.draw(TILE_SET,Platform_Quad,i,VIRTUAL_HEIGHT-24)
        end
        FLOORX = FLOORX - 4

        if(PLAYERSTATE == "idle")
        then
            
            love.graphics.draw(PLAYER_IDLE,BOTIdleX,BOTIdleY)
            
        elseif(PLAYERSTATE == 'running')
        then
            
           
            for i=1,250000 
            do
                love.graphics.draw(PLAYER_RUN[runningIndex],BOTRunningX,BOTRunningY)
            end
            
            
        end
    
    elseif(GAMESTATE == "titlescreen")
    then
        love.graphics.setFont(mediumfont)
        love.graphics.printf("Start Game",0,VIRTUAL_HEIGHT/2,VIRTUAL_WIDTH,'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf("Touch to start",0,(VIRTUAL_HEIGHT/2)+20,VIRTUAL_WIDTH,'center')

    end
    push:finish()
end