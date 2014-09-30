local levelMaster = {}
local function getLevelOne ()
	local levelTable = {
		{Image = display.newImage ("Assets/PhysicsOBJ/branch01.png", 100, 245), Type = "NonPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockPlank01.png", 840, 228), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockPlank01.png", 660, 228), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank01.png", 750, 130), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockBlock01.png", 710, 290), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockBlock01.png", 790, 290), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/triRockLeftBlock01.png", 626, 270), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/triRockRightBlock01.png", 875, 270), Type = "StandingPhysics"},
		{Image = display.newImage ("Assets/PhysicsOBJ/egg01.png", 750, 235), Type = "StandingPhysics"}
	}
	return levelTable
end
function levelMaster.getLevelData (_level)
	if (_level == 1) then
		return getLevelOne ()
	elseif (_level == 2) then
		return getLevelTwo ()
	elseif (_level == 3) then
		return getLevelThree ()
	end
end
return levelMaster