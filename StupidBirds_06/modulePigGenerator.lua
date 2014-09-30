local pigGenerator = {}
-----------------------------------------------------------------------------------------
-- Large Pig sprite data
-----------------------------------------------------------------------------------------
local largePigFullSheet = graphics.newImageSheet ("Assets/Animals/greePig_Full.png", {width = 88, height = 82, numFrames =1})
local largePigEmptySheet = graphics.newImageSheet ("Assets/Animals/greenPig_Empty.png", {width = 86, height = 82, numFrames =1})
local largePigSleepSheet = graphics.newImageSheet ("Assets/Animals/greenPig_Sleep.png", {width = 88, height = 82, numFrames =1})
	-----------------------------------------------------------------------------------------
local largePigSequence = {
	{name = "Full", sheet = largePigFullSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{name = "Empty", sheet = largePigEmptySheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{name = "Sleep", sheet = largePigSleepSheet, start = 1, count = 1, time = 5000, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Small Pig sprite data
-----------------------------------------------------------------------------------------
local smallPigFullSheet = graphics.newImageSheet ("Assets/Animals/greenPig_SmallFull.png", {width = 43, height = 41, numFrames =1})
local smallPigEmptySheet = graphics.newImageSheet ("Assets/Animals/greenPig_SmallFull.png", {width = 42, height = 41, numFrames =1})
	-----------------------------------------------------------------------------------------
local smallPigSequence = {
	{name = "Full", sheet = smallPigFullSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{name = "Empty", sheet = smallPigEmptySheet, start = 1, count = 1, time = 5000, loopCount = 1},
}
-----------------------------------------------------------------------------------------
-- Pig Health Bar
-----------------------------------------------------------------------------------------
local healthFullSheet = graphics.newImageSheet ("Assets/GUI/healthBar_Full.png", {width = 100, height = 20, numFrames = 1})
local healthHalfSheet = graphics.newImageSheet ("Assets/GUI/healthBar_Half.png", {width = 100, height = 20, numFrames = 1})
local healthEmptySheet = graphics.newImageSheet ("Assets/GUI/healthBar_Empty.png", {width = 100, height = 20, numFrames = 1})
	-----------------------------------------------------------------------------------------
local healthBarSequence = {
	{name = "Full", sheet = healthFullSheet, start =1, count = 1, time = 5000, loopCount = 1},
	{name = "Half", sheet = healthHalfSheet, start =1, count = 1, time = 5000, loopCount = 1},
	{name = "Empty", sheet = healthEmptySheet, start =1, count = 1, time = 5000, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Pig Sounds
-----------------------------------------------------------------------------------------
local pigDead01 = audio.loadSound ("Assets/Music/pigDead01.mp3")
local pigDead02 = audio.loadSound ("Assets/Music/pigDead02.mp3")
-----------------------------------------------------------------------------------------
--***************************************************************************************
-- Pig's states
--***************************************************************************************
-----------------------------------------------------------------------------------------
local idleState = {}
local attackedState = {}
local deadState ={}
-----------------------------------------------------------------------------------------
-- Defines the state
function idleState.enter (_Owner)
	idleState.deltaExecute = system.getTimer() + math.random (1000,3000)
end
function idleState.exit (_Owner)
	return 
end
function idleState.execute (_Owner)
	if (idleState.deltaExecute < system.getTimer() and _Owner.isDead == false) then
		_Owner:scale (-1,1)
		idleState.deltaExecute = system.getTimer() + math.random (1000,3000)
	end
end
-----------------------------------------------------------------------------------------
function attackedState.enter (_Owner)
	if (_Owner.isDead == true) then
		return
	elseif (_Owner.isAttacked == true) then
		audio.play (pigDead01)
		_Owner:setFillColor (245/255,15/255,15/255, 0.7)
		if ((_Owner.currentHealth-1) < 0) then
			_Owner.isDead = true
			_Owner.FSM.changeState (deadState)
		else
			_Owner.currentHealth = _Owner.currentHealth - 1
			_Owner.FSM.changeState (idleState)
		end
	end
end
function attackedState.exit (_Owner)
	if (_Owner.isDead == false) then
		timer.performWithDelay (1000, function () if (_Owner.isDead == false) then _Owner:setFillColor(1,1,1) end end)
	end
	_Owner.isAttacked = false
end
function attackedState.execute (_Owner)
	return --does nothing
end
-----------------------------------------------------------------------------------------
function deadState.enter (_Owner)
	timer.performWithDelay (100, function () _Owner:removeSelf() end)
end
function deadState.exit (_Owner)
	return -- does nothing
end
function deadState.execute (_Owner)
	return -- does nothing
end
-----------------------------------------------------------------------------------------
function pigGenerator.newPig (_pigType, _initX, _initY)
	local fsmFactory = require ("mainFSM")
	local myPig
	if (_pigType == "Large") then
		myPig = display.newSprite (largePigFullSheet, largePigSequence)
		--[[
		myPig.Health = display.newSprite (healthFullSheet, healthBarSequence)
		myPig.Health.alpha = 0.5
		myPig.Health:scale (0.5,0.5)
		myPig.Health.x = _initX
		myPig.Health.y = _initY -50--]]
		myPig.currentHealth = 3
	elseif (_pigType == "Small") then
		myPig = display.newSprite (smallPigFullSheet, smallPigSequence)
		--[[
		myPig.Health = display.newSprite (healthEmptySheet, healthBarSequence)
		myPig.Health.alpha = 0.7
		myPig.Health:scale (0.3,0.3)
		myPig.Health.x = _initX
		myPig.Health.y = _initY -30--]]
		myPig.currentHealth = 1
	end
	myPig.Type = _pigType
	myPig.x = _initX
	myPig.y = _initY
	myPig.isDead = false
	myPig.isHit = false
	-----------------------------------------------------------------------------------------
	myPig.isIdle = true
	myPig.isAttacked = false

	function myPig.idle ()
		--does nothing, just sit there
	end
	function myPig.getsAttacked ()
		myPig.isAttacked = true
		myPig.FSM.changeState (attackedState)
	end
	-----------------------------------------------------------------------------------------
	--***************************************************************************************
	-- FSM Stuff
	--***************************************************************************************
	-----------------------------------------------------------------------------------------
	myPig.FSM = fsmFactory.newFSM (myPig)
	myPig.FSM.changeState (idleState)
	-----------------------------------------------------------------------------------------

	return myPig
end
return pigGenerator 