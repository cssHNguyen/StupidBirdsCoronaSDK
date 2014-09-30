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
 	local gameBG = display.newImage ("Assets/GUI/gameBG.jpg", 480, 160)
	
end
-----------------------------------------------------------------------------------------
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene
-----------------------------------------------------------------------------------------