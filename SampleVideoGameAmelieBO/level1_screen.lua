-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

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

-- The local variables for this scene
local bkg_image
local backButton
local muteButton
local unmuteButtton

-- the variables that will hold the correct answer and the wrong answers
local answer 
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

local questionTextObject
local answerTextObject 
local wrongAnswer1TextObject
local wrongAnswer2TextObject
local wrongAnswer3TextObject

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
-- create sound variables
local bkgSound = audio.loadSound ( "Sounds/bkgLevel1.mp3" ) -- Setting variable to mp3 file
local bkgSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "fade", time = 500})
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
----------------------------------------------------------------------------------------
-- code for level 1
local function DetermineAnswers()
    -- calculate the correct answer as well as the wrong answers
    answer = planets
    wrongAnswer1 = plainets
    wrongAnswer2 = plenets
    wrongAnswer3 = planeits
end

-- Function that changes the answers for a new question and places them randomly in one of the positions
local function DisplayAnswers( )

    local answerPosition = math.random(1,3)
    answerTextObject.text = tostring( answer )
    wrongAnswer1TextObject.text = tostring( wrongAnswer1 )
    wrongAnswer2TextObject.text = tostring( wrongAnswer2 )
    wrongAnswer3TextObject.text = tostring( wrongAnswer3 )

    if (answerPosition == 1) then                
        
        answerTextObject.x = display.contentWidth*.3        
        wrongAnswer1TextObject.x = display.contentWidth*.2
        wrongAnswer2TextObject.x = display.contentWidth*.1 
        wrongAnswer3TextObject.x = display.contentWidth*.4 

    elseif (answerPosition == 2) then
       
        answerTextObject.x = display.contentWidth*.2        
        wrongAnswer1TextObject.x = display.contentWidth*.1
        wrongAnswer2TextObject.x = display.contentWidth*.4 
        wrongAnswer3TextObject.x = display.contentWidth*.3

    else
       
        answerTextObject.x = display.contentWidth*.1        
        wrongAnswer1TextObject.x = display.contentWidth*.2
        wrongAnswer2TextObject.x = display.contentWidth*.3
        wrongAnswer3TextObject.x = display.contentWidth*.4
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

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1ScreenAmelieBO@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image ) 


    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*0.8/8,
        y = display.contentHeight*1.5/16,
        width = 150, 
        height = 80,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtoUnpressedYourName@2x.png",
        overFile = "Images/BackButtonPressedAbishaJ@2x.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )  

-------------------------------------------------------------------------------
-- OBJECT CREATION
-------------------------------------------------------------------------------
-- create image object for mute and unmute buttons
muteButton = display.newImageRect("Images/unmuteButtonPressedAmelieBo@2x .png", 100, 100)
muteButton.x = display.contentWidth*1/10
muteButton.y = display.contentHeight*9/10 
muteButton.isVisible = true

unmuteButton = display.newImageRect("Images/muteButtonUnpressedAmelieBo@2x .png", 100, 100)
unmuteButton.x = display.contentWidth*1/10
unmuteButton.y = display.contentHeight*9/10
unmuteButton.isVisible = true

 -- create the text object that will hold the correct answer and the wrong answers for question 1
 questionTextObject = display.newText("There are eight planits in our solar system", display.contentWidth*.5, display.contentHeight/4, nil, 50 )
 answerTextObject = display.newText("planets", display.contentWidth*.6, display.contentHeight/2.6, nil, 50 )
 wrongAnswer1TextObject = display.newText("plainets", display.contentWidth*.3, display.contentHeight/2.6, nil, 50 )
 wrongAnswer2TextObject = display.newText("plenets", display.contentWidth*.6, display.contentHeight/2, nil, 50 )
 wrongAnswer3TextObject = display.newText("planeits", display.contentWidth*.3, display.contentHeight/2, nil, 50 )
 numberCorrectText = display.newText("", display.contentWidth*4/5, display.contentHeight*6/7, nil, 25)


    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )
    
end --function scene:create( event )


-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        -- start the main menu screen music
        bkgSoundChannel = audio.play( bkgSound, { channel=2, loops=-1} )
        muteButton:addEventListener( "touch", Mute)
        unmuteButton:addEventListener( "touch", Unmute)
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        answerTextObject.isVisible = false
        wrongAnswer1TextObject.isVisible = false
        wrongAnswer2TextObject.isVisble = false
        wrongAnswer3TextObject.isVisible = false
        questionTextObject.isVisble = false
        audio.stop(bkgSoundChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- called iediately after scene goes off screen.
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)
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
