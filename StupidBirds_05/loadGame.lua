-----------------------------------------------------------------------------------------
-- Main menu is used an a UI for user to get into the game, just layer between the main
-- menu and the actual game.
-----------------------------------------------------------------------------------------
local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local physics = require ("physics")
local lvlMaster = require ("mainLevelMaster")
local birdGenerator = require ("moduleBirdGenerator")
physics.start()
physics.setDrawMode ("hybrid")
function scene:createScene( event )
    --Group represent the display group of this view, makes it easier to delete everything
    --Just remember to insert into it, ex: group:insert(obj)
 	local group = self.view
 	local assetGroup = display.newGroup( )
 	local gameBG
 	if (levelSelector == 1) then 
 		gameBG = display.newImage ("Assets/GUI/gameBG.jpg", 480, 160)
 	elseif (levelSelector == 2) then 
 		gameBG = display.newImage ("Assets/GUI/gameBG02.jpg", 480, 160)
 	elseif (levelSelector == 3) then
 		gameBG = display.newImage ("Assets/GUI/gameBG03.jpg", 480, 160)
 	end
 	local myBirdTarget = display.newImage ("Assets/GUI/birdTarget.png", 240, 190)
 	myBirdTarget.alpha = 0.8
 	
 	--local tempOrigin = display.newRect (100, 190, 20,20)
		-- the  ground
 	local gameGround = display.newRect (480, 315, 960, 10)
 	gameGround.alpha = 0.01
 	physics.addBody (gameGround, "static")
 	gameGround.Type = "Ground"
 	gameGround.ID = "Ground"
 	-----------------------------------------------------------------------------------------
	-- Loads the level
	-----------------------------------------------------------------------------------------
	local myCurrentStage = lvlMaster.getLevelData (levelSelector)
	local myCurrentAnimal = lvlMaster.getLevelAnimal (levelSelector)
	local myCurrentBird = {
		{Animal = birdGenerator.newBird (35, 280)},
		{Animal = birdGenerator.newBird (80, 280)},
		{Animal = birdGenerator.newBird (125, 280)}
	}
 	-----------------------------------------------------------------------------------------
	-- Adds stuff to group
	-----------------------------------------------------------------------------------------
 	assetGroup:insert (gameBG)
 	assetGroup:insert (gameGround)
 	assetGroup:insert (myBirdTarget)
 	for i=1, #myCurrentStage do
 		if (myCurrentStage[i].Type == "StandingPhysics") then
 			physics.addBody (myCurrentStage[i].Image, {density = 1, friction = 5})
 			myCurrentStage[i].Image.Type = "StandingPhysics"
 			myCurrentStage[i].Image.isSleepingAllowed = false
 		elseif (myCurrentStage[i].Type == "StaticPhysics") then
 			physics.addBody (myCurrentStage[i].Image, "static", {density = 1, friction = 5})
 			myCurrentStage[i].Image.Type = "StaticPhysics"
 			myCurrentStage[i].Image.isSleepingAllowed = false
 		end
 		myCurrentStage[i].Image.ID = "Structure"
 		myCurrentStage[i].Image.Strength = myCurrentStage[i].Strength
 		assetGroup:insert (myCurrentStage[i].Image)
 	end
 		-----------------------------------------------------------------------------------------
 	for i=1, #myCurrentAnimal do
 		physics.addBody (myCurrentAnimal[i].Animal, {density = 1, friction = 5})
		myCurrentAnimal[i].Animal.ID = "Pig"
		myCurrentAnimal[i].Animal.isSleepingAllowed = false
 		assetGroup:insert (myCurrentAnimal[i].Animal)
 		assetGroup:insert (myCurrentAnimal[i].Animal.Health)
 	end
 		-----------------------------------------------------------------------------------------
 	for i=1, #myCurrentBird do
 		myCurrentBird[i].Animal.ID = "Bird"
 		assetGroup:insert (myCurrentBird[i].Animal)
 	end
 	-----------------------------------------------------------------------------------------
	-- Control for the target
	-----------------------------------------------------------------------------------------
	local birdInFlight = false
	local resetToggle = false
	local targetRect = display.newRect (240, 160, 480, 320)
	targetRect.alpha = 0.3
	-- 0 to -50,        0-150
	local function myTargetListener (event)
		if (event.phase == "began") then
			myBirdTarget.x = event.x
			myBirdTarget.y = event.y 
			if (myBirdTarget.y > 180) then
				myBirdTarget.y = 180
			end
			if (myBirdTarget.x < 180) then
				myBirdTarget.x = 180
			end
		elseif (event.phase == "moved") then
			myBirdTarget.x = event.x
			myBirdTarget.y = event.y 
			if (myBirdTarget.y > 250) then
				myBirdTarget.y = 250
			end
			if (myBirdTarget.x < 180) then
				myBirdTarget.x = 180
			end
		elseif (event.phase == "ended") then
			birdInFlight = true
			physics.addBody (myCurrentBird[#myCurrentBird].Animal, {density = 1, friction = 5})
			myCurrentBird[#myCurrentBird].Animal:applyLinearImpulse ( (event.x - 100)/1.4, (event.y -190)/1.7, myCurrentBird[#myCurrentBird].Animal.x, myCurrentBird[#myCurrentBird].Animal.y)
		end
		return true
	end
	timer.performWithDelay (2000, function () targetRect:addEventListener ("touch", myTargetListener) end)
 	-----------------------------------------------------------------------------------------
	-- Move the whole group
	-----------------------------------------------------------------------------------------
	local initTouch = 0
	
	local function stageTouchListener (event)
		if (event.phase == "began") then
			initTouch = event.x
			if (assetGroup.x < -240) then
				for i=1, #myCurrentStage do
					if (myCurrentStage[i].Image.Type == "StandingPhysics") then
			 			myCurrentStage[i].Image.bodyType = "dynamic"
			 		end
			 	end
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
	--assetGroup:addEventListener ("touch", stageTouchListener)
	assetGroup.x = -480
	local function tooLazyToEnclose ()
		if (#myCurrentBird > 0) then
			myCurrentBird[#myCurrentBird].Animal.x = 100
			myCurrentBird[#myCurrentBird].Animal.y = 190
		end
	end
	timer.performWithDelay(1000, function () transition.to (assetGroup, {time = 1500, x = 0, onComplete = tooLazyToEnclose}) end)
 	-----------------------------------------------------------------------------------------
 	self.onUpdate = function (event)
 		if (birdInFlight == true) then
 			if (myCurrentBird[#myCurrentBird].Animal.x > 240 and myCurrentBird[#myCurrentBird].Animal.x < 720) then
 				assetGroup.x = -myCurrentBird[#myCurrentBird].Animal.x + 240
 			end
 			local function resetGame ()
 				transition.to (assetGroup, {time = 1800, x = 0, onComplete = tooLazyToEnclose})
 				table.remove (myCurrentBird, #myCurrentBird)
 			end
 			if (resetToggle == false) then
 				resetToggle = true
 				timer.performWithDelay (3000, function () birdInFlight = false resetToggle = false myCurrentBird[#myCurrentBird].Animal:removeSelf() resetGame () end)
 			end
 		end
  	end
  		--uses force to kill
  	local killForce = false
  	self.posColDMaster = function (event)
  		if ( event.force > 40 ) then
  			killForce = true
        	print( "Collision force: " .. event.force .. " Friction: " .. event.friction )
   	 	end
  	end
  	self.colDMaster = function (event)
  		if (event.phase == "began") then
  			if (event.object2.ID == "Bird" and event.object1.ID == "Pig") then
  				event.object1.deductHealth ()
  			elseif (event.object2.ID == "Bird" and event.object1.ID == "Structure") then
  				if (event.object1.Strength == "Weak") then
  					timer.performWithDelay (50, function () event.object1:removeSelf() end)
  				end
  			end
  			if ((event.object1.ID == "Pig" and event.object2.ID ~= "Pig") or (event.object2.ID == "Pig" and event.object1.ID ~= "Pig")) then
  				if (killForce == true) then
  					killForce = false
  					if (event.object1.ID == "Pig") then
  						event.object1.deductHealth ()
  					elseif (event.object2.ID == "Pig") then
  						event.object2.deductHealth ()
  				end
  				end
  			end
  		end
  	end
 	Runtime:addEventListener ("enterFrame", self.onUpdate)
 	Runtime:addEventListener ("collision", self.colDMaster)
 	Runtime:addEventListener ("postCollision", self.posColDMaster)  
end
-----------------------------------------------------------------------------------------
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene
-----------------------------------------------------------------------------------------