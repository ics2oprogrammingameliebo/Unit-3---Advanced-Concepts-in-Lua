-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Amelie BO
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
-- create sound variables
local rocketSound = audio.loadSound ( "Sounds/rocketSound.mp3" )
local rocketSoundChannel

local barkSound = audio.loadSound ( "Sounds/bark.mp3" )
local barkSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------------------
local sky
local stars
local stars2
local earth
local rocketShip
local fire
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- Function: fade in FadeIn 
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the visibility in the image by making it fade in.
local function FadeInBkg(event)

-- make the images fade in
sky.alpha = sky.alpha + 0.01
earth.alpha = earth.alpha + 0.01
end


local function FadeIn(event)

-- make the images fade in
stars.alpha = stars.alpha + 0.01
fire.alpha = fire.alpha + 0.01

-- scale the stars2 so that they grow
stars2:scale( 1.03, 1.03)
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

-- Creating a group that associates objects with the scene
local sceneGroup = self.view

 
    -- set the background to be black
    display.setDefault("background", 1, 1, 1)

    -- Insert the images
    sky = display.newImageRect("Images/backgroundAmelieBO@2x.png", 750, 750)
    stars = display.newImageRect("Images/StarsAmelieBO@2x.png", 750, 750)
    stars2 = display.newImageRect("Images/StarsAmelieBO@2x.png", 750, 750)
    earth = display.newImageRect("Images/earthAmelieBO@2x.png", 750, 750)
    rocketShip = display.newImageRect("Images/RocketShipAmelie@2x.png", 300, 205)
    fire = display.newImageRect("Images/fireAmelie@2x.png", 200, 70)

    -- set the earth to be transparent
    sky.alpha = 0
    earth.alpha = 0
    stars.alpha = 0
    fire.alpha = 0

    -- set the initial x and y position of the images
    sky.x = 500
    sky.y = 380

    stars.x = 500
    stars.y = 380

    stars2.x = 500
    stars2.y = 380

    earth.x = 500
    earth.y = 380

    rocketShip.x = 1400
    rocketShip.y = 380

    transition.to(rocketShip, {x=400, y=380, time=1000})

    fire.x = 1620
    fire.y = 400

    transition.to(fire, {x=620, y=400, time=1000})

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( sky )
    sceneGroup:insert( stars )
    sceneGroup:insert( stars2 )
    sceneGroup:insert( earth )
    sceneGroup:insert( rocketShip )
    sceneGroup:insert( fire )

    end -- function scene:create( event )
--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        rocketSoundChannel = audio.play(rocketSound )

        -- start the splash screen music
        barkSoundChannel = audio.play(barkSound )

        -- Call the FadeInBkg function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", FadeInBkg)

        -- Call the FadeIn function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", FadeIn)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 2200, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the rocket sound channel for this screen
        audio.stop(rocketSoundChannel)

        -- stop the bark sound channel for this screen
        audio.stop(barkSoundChannel)

    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
