local birdGenerator = {}
-----------------------------------------------------------------------------------------
-- Red bird sprite data
-----------------------------------------------------------------------------------------
local redBirdIdleSheet = graphics.newImageSheet ("Assets/Animals/redBird_Idle.png", {width = 65, height = 61, numFrames = 1})
local redBirdFlightSheet = graphics.newImageSheet ("Assets/Animals/redBird_Flight.png", {width = 65, height = 51, numFrames = 1})
local redBirdCrashSheet = graphics.newImageSheet ("Assets/Animals/redBird_Crash.png", {width = 60, height = 58, numFrames = 1})
	-----------------------------------------------------------------------------------------
local redBirdSequence = {
	{Name = "Idle", sheet = redBirdIdleSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Flight", sheet = redBirdFlightSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Crash", sheet = redBirdCrashSheet, start = 1, count = 1, time = 5000, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Purple bird sprite data
-----------------------------------------------------------------------------------------
local purpleBirdIdleSheet = graphics.newImageSheet ("Assets/Animals/purpleBird_Idle.png", {width = 84, height = 67, numFrames = 1})
local purpleBirdFlightSheet = graphics.newImageSheet ("Assets/Animals/purpleBird_Flight.png", {width = 84, height = 58, numFrames = 1})
local purpleBirdCrashSheet = graphics.newImageSheet ("Assets/Animals/purpleBird_Crash.png", {width = 84, height = 67, numFrames = 1})
	-----------------------------------------------------------------------------------------
local purpleBirdSequence = {
	{Name = "Idle", sheet = purpleBirdIdleSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Flight", sheet = purpleBirdFlightSheet, start = 1, count = 1, time = 5000, loopCount = 1},
	{Name = "Crash", sheet = purpleBirdCrashSheet, start = 1, count = 1, time = 5000, loopCount = 1}
}
-----------------------------------------------------------------------------------------
-- Small Pig sprite data
-----------------------------------------------------------------------------------------
function birdGenerator.newBird (_initX, _initY)
	local birdRoll = math.random (2)
	if (birdRoll == 1) then
		myBird = display.newSprite (redBirdIdleSheet, redBirdSequence)
	elseif (birdRoll == 2) then
		myBird = display.newSprite (purpleBirdIdleSheet, purpleBirdSequence)
	end
	myBird.x = _initX
	myBird.y = _initY

	return myBird
end
return birdGenerator