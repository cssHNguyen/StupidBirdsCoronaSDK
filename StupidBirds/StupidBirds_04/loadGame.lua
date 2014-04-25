-----------------------------------------------------------------------------------------
-- Main menu is used an a UI for user to get into the game, just layer between the main
-- menu and the actual game.
-----------------------------------------------------------------------------------------
local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local physics = require ("physics")
local lvlMaster = require ("mainLevelMaster")
physics.start()
physics.setDrawMode ("hybrid")
function scene:createScene( event )
    --Group represent the display group of this view, makes it easier to delete everything
    --Just remember to insert into it, ex: group:insert(obj)
 	local group = self.view
 	local assetGroup = display.newGroup( )
 	local gameBG = display.newImage ("Assets/GUI/gameBG.jpg", 480, 160)
		-- the  ground
 	local gameGround = display.newRect (480, 315, 960, 10)
 	gameGround.alpha = 0.01
 	physics.addBody (gameGround, "static")
 	-----------------------------------------------------------------------------------------
	-- Loads the level
	-----------------------------------------------------------------------------------------
	local myCurrentStage = lvlMaster.getLevelData (levelSelector)
 	-----------------------------------------------------------------------------------------
	-- Adds stuff to group
	-----------------------------------------------------------------------------------------
 	assetGroup:insert (gameBG)
 	assetGroup:insert (gameGround)
 	for i=1, #myCurrentStage do
 		if (myCurrentStage[i].Type == "StandingPhysics") then
 			physics.addBody (myCurrentStage[i].Image, {density = 1, friction = 5})
 			myCurrentStage[i].Image.isSleepingAllowed = false
 		end
 		assetGroup:insert (myCurrentStage[i].Image)
 	end
 	-----------------------------------------------------------------------------------------
	-- Move the whole group
	-----------------------------------------------------------------------------------------
	local initTouch = 0
	local function stageTouchListener (event)
		if (event.phase == "began") then
			initTouch = event.x
			if (assetGroup.x < -240) then
				for i=1, #myCurrentStage do
			 		myCurrentStage[i].Image.bodyType = "dynamic"
			 	end
				local rockBall = display.newImage ("Assets/PhysicsOBJ/rockBall01.png", event.x, event.y)
				physics.addBody (rockBall, "dynamic", {density = 2})
				assetGroup:insert (rockBall)
				rockBall.x = event.x
				rockBall.y = event.y
				rockBall:applyLinearImpulse ( 30, -20, rockBall.x, rockBall.y )
			end
		elseif (event.phase == "moved") then
			event.target.x = event.x - initTouch
			if (event.target.x <= -480) then
				event.target.x = -480
			elseif (event.target.x >= 0) then
				event.target.x = 0
			end
		end
		return true
	end
	assetGroup:addEventListener ("touch", stageTouchListener)
 	-----------------------------------------------------------------------------------------
 	self.onUpdate = function (event)
 		--assetGroup:translate (1, 0)
 	end
 	Runtime:addEventListener ("enterFrame", self.onUpdate)
end
-----------------------------------------------------------------------------------------
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene
-----------------------------------------------------------------------------------------