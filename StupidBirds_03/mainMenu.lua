-----------------------------------------------------------------------------------------
-- Main menu is used an a UI for user to get into the game, just layer between the main
-- menu and the actual game.
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

function scene:createScene( event )
    --Group represent the display group of this view, makes it easier to delete everything
    --Just remember to insert into it, ex: group:insert(obj)
 	local group = self.view
 	local mainMenuBackground = display.newImage ("Assets/GUI/mainMenuBG.jpg", 240, 160)
 	local mainTitle = display.newText ("Stupid Bids!", 240, 80, font, 28)
 	local playButton = display.newImage ("Assets/GUI/playButton.png", 240, 160)
 	-----------------------------------------------------------------------------------------
 	group:insert (mainMenuBackground)
 	group:insert (playButton)
 	group:insert (mainTitle)
 	-----------------------------------------------------------------------------------------
 	self.onUpdate = function (event)
 		playButton:setFillColor (math.random(255)/255,math.random(255)/255,math.random(255)/255)
 	end
 	Runtime:addEventListener ("enterFrame", self.onUpdate)
 	-----------------------------------------------------------------------------------------
 	local function playButtonListener (event)
 		if (event.phase == "began") then
 			storyboard.gotoScene ("mainSelectLevel")
 		end
 		return true
 	end
 	playButton:addEventListener ("touch", playButtonListener)
 	-----------------------------------------------------------------------------------------
end
-----------------------------------------------------------------------------------------
function scene:exitScene( event )
	Runtime:removeEventListener ("enterFrame", self.onUpdate)
end
-----------------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "exitScene", scene )
return scene
-----------------------------------------------------------------------------------------