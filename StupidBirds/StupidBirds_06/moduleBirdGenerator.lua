local birdGenerator = {}
-----------------------------------------------------------------------------------------
-- Red bird sprite data
-----------------------------------------------------------------------------------------
local redBirdIdleSheet = graphics.newImageSheet ("Assets/Animals/redBird_Idle.png", {width = 65, height = 61, numFrames = 1})
local redBirdFlightSheet = graphics.newImageSheet ("Assets/Animals/redBird_Flight.png", {width = 65, height = 51, numFrames = 1})
local redBirdCrashSheet = graphics.newImageSheet ("Assets/Animals/redBird_Crash.png", {width = 60, height = 58, numFrames = 1})
	-----------------------------------------------------------------------------------------
local redBirdSequence = {
	{name = "Idle", sheet = redBirdIdleSheet, start = 1, count = 1, time = 10, loopCount = 1},
	{name = "Flight", sheet = redBirdFlightSheet, start = 1, count = 1, time = 10, loopCount = 1},
	{name = "Crash", sheet = redBirdCrashSheet, start = 1, count = 1, time = 10, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Purple bird sprite data
-----------------------------------------------------------------------------------------
local purpleBirdIdleSheet = graphics.newImageSheet ("Assets/Animals/purpleBird_Idle.png", {width = 84, height = 67, numFrames = 1})
local purpleBirdFlightSheet = graphics.newImageSheet ("Assets/Animals/purpleBird_Flight.png", {width = 84, height = 58, numFrames = 1})
local purpleBirdCrashSheet = graphics.newImageSheet ("Assets/Animals/purpleBird_Crash.png", {width = 84, height = 67, numFrames = 1})
	-----------------------------------------------------------------------------------------
local purpleBirdSequence = {
	{name = "Idle", sheet = purpleBirdIdleSheet, start = 1, count = 1, time = 10, loopCount = 1},
	{name = "Flight", sheet = purpleBirdFlightSheet, start = 1, count = 1, time = 10, loopCount = 1},
	{name = "Crash", sheet = purpleBirdCrashSheet, start = 1, count = 1, time = 10, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Small Pig sprite data
-----------------------------------------------------------------------------------------
function birdGenerator.newBird (_initX, _initY)
	local myBird
	local birdRoll = math.random (2)
	if (birdRoll == 1) then
		myBird = display.newSprite (redBirdIdleSheet, redBirdSequence)
	elseif (birdRoll == 2) then
		myBird = display.newSprite (purpleBirdIdleSheet, purpleBirdSequence)
	end
	myBird.x = _initX
	myBird.y = _initY

	function myBird.crashed ()
		myBird:setSequence ("Crash")
	end
	function myBird.flight ()
		myBird:setSequence("Flight")
	end
	return myBird
end
return birdGenerator