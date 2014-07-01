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
 	soundMaster.stopCurrentBGM()
 	group:insert (mainMenuBackground)
 	-----------------------------------------------------------------------------------------
 	local lvlPrompt = display.newText ("Pick a Level", 240, 40, font, 32)
 	local lvl01 = display.newText ("Level 1", 240, 90, font, 28)
 	local lvl02 = display.newText ("Level 2", 240, 140, font, 28)
 	local lvl03 = display.newText ("Level 3", 240, 190, font, 28)
 	lvl01.ID = 1
 	lvl02.ID = 2
 	lvl03.ID = 3
 	group:insert (lvlPrompt)
 	group:insert (lvl01)
 	group:insert (lvl02)
 	group:insert (lvl03)
 	-----------------------------------------------------------------------------------------
 	local function lvlListener (event)
 		if (event.phase == "began") then
 			if (event.target.ID == 1) then
 				levelSelector = 1
 				storyboard.gotoScene ("loadGame")
 			elseif (event.target.ID == 2) then
 				levelSelector = 2
 				storyboard.gotoScene ("loadGame")
 			elseif (event.target.ID == 3) then
 				levelSelector = 3
 				storyboard.gotoScene ("loadGame")
 			end
 			soundMaster.playBGM ("Main")
 		end
 	end
 	lvl01:addEventListener ("touch", lvlListener)
 	lvl02:addEventListener ("touch", lvlListener)
 	lvl03:addEventListener ("touch", lvlListener)
 	-----------------------------------------------------------------------------------------
end
-----------------------------------------------------------------------------------------
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene
-----------------------------------------------------------------------------------------