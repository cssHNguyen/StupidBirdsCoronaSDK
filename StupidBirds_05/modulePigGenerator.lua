local pigGenerator = {}
-----------------------------------------------------------------------------------------
-- Large Pig sprite data
-----------------------------------------------------------------------------------------
local largePigFullSheet = graphics.newImageSheet ("Assets/Animals/greePig_Full.png", {width = 88, height = 82, numFrames =1})
local largePigEmptySheet = graphics.newImageSheet ("Assets/Animals/greenPig_Empty.png", {width = 86, height = 82, numFrames =1})
local largePigSleepSheet = graphics.newImageSheet ("Assets/Animals/greenPig_Sleep.png", {width = 88, height = 82, numFrames =1})
	-----------------------------------------------------------------------------------------
local largePigSequence = {
	{Name = "Full", sheet = largePigFullSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Empty", sheet = largePigEmptySheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Sleep", sheet = largePigSleepSheet, start = 1, count = 1, time = 5000, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Small Pig sprite data
-----------------------------------------------------------------------------------------
local smallPigFullSheet = graphics.newImageSheet ("Assets/Animals/greenPig_SmallFull.png", {width = 43, height = 41, numFrames =1})
local smallPigEmptySheet = graphics.newImageSheet ("Assets/Animals/greenPig_SmallFull.png", {width = 42, height = 41, numFrames =1})
	-----------------------------------------------------------------------------------------
local smallPigSequence = {
	{Name = "Full", sheet = smallPigFullSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Empty", sheet = smallPigEmptySheet, start = 1, count = 1, time = 5000, loopCount = 1},
}
-----------------------------------------------------------------------------------------
-- Pig Health Bar
-----------------------------------------------------------------------------------------
local healthFullSheet = graphics.newImageSheet ("Assets/GUI/healthBar_Full.png", {width = 100, height = 20, numFrames = 1})
local healthHalfSheet = graphics.newImageSheet ("Assets/GUI/healthBar_Half.png", {width = 100, height = 20, numFrames = 1})
local healthEmptySheet = graphics.newImageSheet ("Assets/GUI/healthBar_Empty.png", {width = 100, height = 20, numFrames = 1})
	-----------------------------------------------------------------------------------------
local healthBarSequence = {
	{Name = "Full", sheet = healthFullSheet, start =1, count = 1, time = 5000, loopCount = 1},
	{Name = "Half", sheet = healthHalfSheet, start =1, count = 1, time = 5000, loopCount = 1},
	{Name = "Empty", sheet = healthEmptySheet, start =1, count = 1, time = 5000, loopCount = 1}
}
-----------------------------------------------------------------------------------------
function pigGenerator.newPig (_pigType, _initX, _initY)
	local myPig
	if (_pigType == "Large") then
		myPig = display.newSprite (largePigFullSheet, largePigSequence)
		myPig.Health = display.newSprite (healthFullSheet, healthBarSequence)
		myPig.Health.alpha = 0.7
		myPig.Health:scale (0.5,0.5)
		myPig.Health.x = _initX
		myPig.Health.y = _initY -50
		myPig.currentHealth = 3
	elseif (_pigType == "Small") then
		myPig = display.newSprite (smallPigFullSheet, smallPigSequence)
		myPig.Health = display.newSprite (healthEmptySheet, healthBarSequence)
		myPig.Health.alpha = 0.7
		myPig.Health:scale (0.3,0.3)
		myPig.Health.x = _initX
		myPig.Health.y = _initY -30
		myPig.currentHealth = 1
	end
	myPig.Type = _pigType
	myPig.x = _initX
	myPig.y = _initY
	myPig.isDead = false
	-----------------------------------------------------------------------------------------
	myPig.isIdle = true
	myPig.isAttacked = false

	function myPig.deductHealth ()
		if ((myPig.currentHealth-1) <= 0) then
			myPig.isDead = true
			myPig.alpha = 0.01
			timer.performWithDelay (100, function () myPig.Health:removeSelf() myPig:removeSelf()end)
		else
			myPig.currentHealth = myPig.currentHealth - 1
			if (myPig.currentHealth == 2) then
				myPig.Health:setSequence ("Half")
				myPig.Health:play()
			elseif (myPig.currentHealth == 1) then
				myPig.Health:setSequence ("Empty")
				myPig.Health:play()
			end
		end
	end
	function myPig.idle ()
		--does nothing, just sit there
	end
	function myPig.isAttacked ()
		if (myPig.Type == "Large") then
			myPig:setSequence ("Empty")
		elseif (myPig.Type == "Small") then
			myPig:setSequence ("Empty")
		end
	end

	-----------------------------------------------------------------------------------------
	return myPig
end
return pigGenerator 