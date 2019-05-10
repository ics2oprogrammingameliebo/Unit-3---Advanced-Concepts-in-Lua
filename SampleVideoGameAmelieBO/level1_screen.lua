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

local randomQuestionNumber

-- displays the number correct that the user has
local numberCorrectText 

-- displays the number of lives the user has
local livesText 

-- variables for questions
local instructionsText
local textQuestion1
local q1CorrectAnswer
local q1WrongAnswer1
local q1WrongAnswer2
local q1WrongAnswer3
local textQuestion2
local textQuestion3
local textQuestion4
local textQuestion5
local textQuestion6
local textQuestion7
local textQuestion8
local textQuestion9
local textQuestion10
local textQuestion11
local textQuestion12
local textQuestion13
local textQuestion14
local textQuestion15
local textQuestion16
local textQuestion17
local textQuestion18
local textQuestion19
local textQuestion20

-- Boolean variable that states if user clicked the answer or not
local alreadyClickedAnswer = false

-- displays the number correct that the user has
local numberCorrectText 

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

local function AskQuestion()
    -- randomly choose 1 out of the 20 questions
    randomQuestionNumber = math.random(1,1)

    -- if the random question number is 1, then ask question 1
    if (randomQuestionNumber == 1) then

         -- make fist question visible
         textQuestion1.isVisible = true

         -- make answers visible
         q1CorrectAnswer.isVisible = true
         q1WrongAnswer1.isVisible = true
         q1WrongAnswer2.isVisible = true
         q1WrongAnswer3.isVisible = true
    end
end

-- Function that changes the answers for a new question and places them randomly in one of the positions
local function DisplayAnswers( )

    local answerPosition = math.random(1,3)
    q1CorrectAnswer.text = tostring( q1CorrectAnswer )
    q1WrongAnswer1.text = tostring( q1WrongAnswer1 )
    q1WrongAnswer2.text = tostring( q1WrongAnswer2 )
    q1WrongAnswer3.text = tostring( q1WrongAnswer3 )

    if (answerPosition == 1) then                
        
        q1CorrectAnswer.x = display.contentWidth*.3        
        q1WrongAnswer1.x = display.contentWidth*.2
        q1WrongAnswer2.x = display.contentWidth*.1 
        q1WrongAnswer3.x = display.contentWidth*.4 

    elseif (answerPosition == 2) then
       
        q1CorrectAnswer.x = display.contentWidth*.2        
        q1WrongAnswer1.x = display.contentWidth*.1
        q1WrongAnswer2.x = display.contentWidth*.4 
        q1WrongAnswer3.x = display.contentWidth*.3

    else
       
        q1CorrectAnswer.x = display.contentWidth*.1        
        q1WrongAnswer1.x = display.contentWidth*.2
        q1WrongAnswer2.x = display.contentWidth*.3
        q1WrongAnswer3.x = display.contentWidth*.4
    end
end

-- Functions that checks if the buttons have been clicked.
local function TouchListenerq1CorrectAnswer(touch)
    -- get the user answer from the text object that was clicked on
    local userAnswer = q1CorrectAnswer.text

    if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

        alreadyClickedAnswer = true

        -- if the user gets the answer right, display Correct and call RestartSceneRight
        if (answerq1CorrectAnswer == tonumber(userAnswer)) then     
            correct.isVisible = true
            -- increase the number correct by 1
            numberCorrect = numberCorrect + 1
            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )
        end        

    end
end

local function TouchListenerq1WrongAnswer1(touch)
    -- get the user answer from the text object that was clicked on
    local userAnswer = q1WrongAnswer1.text

    if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

        alreadyClickedAnswer = true


        if (q1WrongAnswer1 ~= tonumber(userAnswer)) then
            incorrect.isVisible = true
            -- decrease a life
            lives = lives - 1
            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )            
        end        

    end
end

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1ScreenAmelieBOAbishaJ@2x.png", display.contentWidth, display.contentHeight)
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

-----------------------------------------------------------------------------------------
   -- display question 1
    instructionsText = display.newText( "Level 1- Click on the correct spelling", 515, 70, nil, 40)
    -- set the color of the text to be white
    instructionsText:setTextColor(1, 1, 1)

    -- display question 1
    textQuestion1 = display.newText( "There are eight PLANITS in our solar system.", 500, 150, nil, 40)
    -- set the color of the text to be white
    textQuestion1:setTextColor(1, 1, 1)
    textQuestion1.isVisible = false

    -- display question 1
    q1CorrectAnswer = display.newText( "Planets", 600, 300, nil, 35)
    -- set the color of the text to be white
    q1CorrectAnswer:setTextColor(1, 1, 1)
    q1CorrectAnswer.isVisible = false

    -- display question 1
    q1WrongAnswer1 = display.newText( "Plainets", 400, 235, nil, 35)
    -- set the color of the text to be white
    q1WrongAnswer1:setTextColor(1, 1, 1)
    q1WrongAnswer1.isVisible = false

    -- display question 1
    q1WrongAnswer2 = display.newText( "Plenets", 600, 235, nil, 35)
    -- set the color of the text to be white
    q1WrongAnswer2:setTextColor(1, 1, 1)
    q1WrongAnswer2.isVisible = false

    -- display question 1
    q1WrongAnswer3 = display.newText( "Planeits", 400, 300, nil, 35)
    -- set the color of the text to be white
    q1WrongAnswer3:setTextColor(1, 1, 1)
    q1WrongAnswer3.isVisible = false

    -- create the text object that will say Correct, set the colour and then hide it
    correct = display.newText("Correct", display.contentWidth/2, display.contentHeight*1/3, nil, 50 )
    correct:setTextColor(100/255, 47/255, 210/255)
    correct.isVisible = false

    -- create the text object that will say Correct, set the colour and then hide it
    incorrect = display.newText("Incorrect", display.contentWidth/2, display.contentHeight*1/3, nil, 50 )
    incorrect:setTextColor(242/255, 19/255, 19/255)
    incorrect.isVisible = false

     -- create the text object that will hold the number of lives
    livesText = display.newText("", display.contentWidth*4/5, display.contentHeight*8/9, nil, 25) 

    -- create the text object that will hold the number of correct answers
    numberCorrectText = display.newText("", display.contentWidth*4/5, display.contentHeight*6/7, nil, 25)
-----------------------------------------------------------------------------------------


    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )
    sceneGroup:insert( textQuestion1)
    sceneGroup:insert( q1CorrectAnswer )
    sceneGroup:insert( q1WrongAnswer1 )
    sceneGroup:insert( q1WrongAnswer2 )
    sceneGroup:insert( q1WrongAnswer3 )
    sceneGroup:insert( correct )
    sceneGroup:insert( incorrect )
    
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

        -- initialize the number of lives and number correct 
        lives = 2
        numberCorrect = 0

        -- start the main menu screen music
        bkgSoundChannel = audio.play( bkgSound, { channel=2, loops=-1} )
        muteButton:addEventListener( "touch", Mute)
        unmuteButton:addEventListener( "touch", Unmute)
        AskQuestion()
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