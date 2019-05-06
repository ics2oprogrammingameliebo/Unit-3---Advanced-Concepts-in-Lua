-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Amelie BO
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
SoundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton
local muteButton
local unmuteButtton


-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
-- create sound variables
local bkgSound = audio.loadSound ( "Sounds/bkgMusic.mp3" ) -- Setting variable to mp3 file
local bkgSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "fade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "fade", time = 1000})
end    

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function InstructionsTransition( )       
    composer.gotoScene( "instructions_screen", {effect = "fade", time = 500})
end 
-----------------------------------------------------------------------------------------
    local function Mute(touch)
     if (touch.phase == "ended") then
     -- pause the sound
     audio.pause(bkgSound)
     -- set the boolean variable to be false (sound is now muted)
     soundOn = false
     -- hide the mute
     muteButton.isVisible = false
     -- make the unmute button visible
     unmuteButton.isVisible = true
 end
end
    local function Unmute(touch)
     if (touch.phase == "ended") then
     -- pause the sound
     audio.play(bkgSound)
     -- set the boolean variable to be false (sound is now muted)
     soundOn = true
     -- hide the mute
     muteButton.isVisible = true
     -- make the unmute button visible
     unmuteButton.isVisible = false
 end
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenuAmelieBO@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*3.5/8,
            width = 200, 
            height = 100,


            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressedAbishaJ@2x.png",
            overFile = "Images/PlayButtonPressedAbishaJ@2x.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/8,
            y = display.contentHeight*6.5/8,
            width = 200, 
            height = 100,

            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedAbishaJ@2x.png",
            overFile = "Images/CreditsButtonPressedAbishaJ@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    -------------------------------------------------------------------------------

    -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/8,
            y = display.contentHeight*5/8,
            width = 200, 
            height = 100,


            -- Insert the images here
            defaultFile = "Images/InstuctionsButtonUnpressedAbishaJ@2x.png",
            overFile = "Images/InstuctionsButtonPressedAbishaJ@2x.png",

            -- When the button is released, call the Instructions transition function
            onRelease = InstructionsTransition
        } ) 

    -------------------------------------------------------------------------------
-- Object creation for mute button
muteButton = display.newImageRect("Images/unmuteButtonPressedAmelieBo@2x .png", 100, 100)
muteButton.x = display.contentWidth*1/10
muteButton.y = display.contentHeight*9/10 
muteButton.isVisible = true

unmuteButton = display.newImageRect("Images/muteButtonUnpressedAmelieBo@2x .png", 100, 100)
unmuteButton.x = display.contentWidth*1/10
unmuteButton.y = display.contentHeight*9/10
unmuteButton.isVisible = true

-----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )

end -- function scene:create( event )   


-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then  
        -- start the main menu screen music
        bkgSoundChannel = audio.play( bkgSound, { channel=1, loops=-1} )
        muteButton:addEventListener( "touch", Mute)
        unmuteButton:addEventListener( "touch", Unmute)
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    
    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        audio.stop(bkgSoundChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- called iediately after scene goes off screen.
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)
    end


end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
