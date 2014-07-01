local levelMaster = {}
local pigGenerator = require ("modulePigGenerator")
-----------------------------------------------------------------------------------------
-- Function to load level one data
-----------------------------------------------------------------------------------------
local function getLevelOne ()
	local levelTable = {
		{Image = display.newImage ("Assets/PhysicsOBJ/branch01.png", 100, 245), Type = "NonPhysics", Strength = "Strong"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank02.png", 840, 228), Type = "StandingPhysics", Strength = "Weak"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank02.png", 660, 228), Type = "StandingPhysics", Strength = "Weak"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank01.png", 750, 130), Type = "StandingPhysics", Strength = "Weak"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockBlock01.png", 710, 290), Type = "StandingPhysics", Strength = "Normal"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockBlock01.png", 790, 290), Type = "StandingPhysics", Strength = "Normal"},
		{Image = display.newImage ("Assets/PhysicsOBJ/triRockLeftBlock01.png", 628, 290), Type = "StaticPhysics", Strength = "Strong"},
		{Image = display.newImage ("Assets/PhysicsOBJ/triRockRightBlock01.png", 872, 290), Type = "StaticPhysics", Strength = "Strong"}
	}
	return levelTable
end
local function getLevelTwo ()
	local levelTable = {
		{Image = display.newImage ("Assets/PhysicsOBJ/branch01.png", 100, 245), Type = "NonPhysics", Strength = "Strong"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank03.png", 840, 228), Type = "StandingPhysics", Strength = "Weak"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank03.png", 660, 228), Type = "StandingPhysics", Strength = "Weak"},

		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank03.png", 840, 170), Type = "StandingPhysics", Strength = "Weak"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank03.png", 660, 170), Type = "StandingPhysics", Strength = "Weak"},



		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank01.png", 750, 200), Type = "StandingPhysics", Strength = "Weak"},
		{Image = display.newImage ("Assets/PhysicsOBJ/woodPlank01.png", 750, 135), Type = "StandingPhysics", Strength = "Weak"},

		{Image = display.newImage ("Assets/PhysicsOBJ/rockBlock01.png", 710, 290), Type = "StandingPhysics", Strength = "Normal"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockBlock01.png", 790, 290), Type = "StandingPhysics", Strength = "Normal"},

		{Image = display.newImage ("Assets/PhysicsOBJ/rockPlank01.png", 638, 180), Type = "StaticPhysics", Strength = "Strong"},
		{Image = display.newImage ("Assets/PhysicsOBJ/rockPlank01.png", 862, 180), Type = "StaticPhysics", Strength = "Strong"},

		{Image = display.newImage ("Assets/PhysicsOBJ/triRockLeftBlock01.png", 628, 290), Type = "StaticPhysics", Strength = "Strong"},
		{Image = display.newImage ("Assets/PhysicsOBJ/triRockRightBlock01.png", 872, 290), Type = "StaticPhysics", Strength = "Strong"}
	}
	return levelTable
end
-----------------------------------------------------------------------------------------
-- Function to load level one's animals
-----------------------------------------------------------------------------------------
local function getLevelOneAnimal ()
	local levelAnimalTable = {
		{Animal = pigGenerator.newPig ("Large", 755, 225), Type = "StandingPhysics"},
		{Animal = pigGenerator.newPig ("Small", 675, 100), Type = "StandingPhysics"},
		{Animal = pigGenerator.newPig ("Small", 725, 100), Type = "StandingPhysics"},
		{Animal = pigGenerator.newPig ("Small", 775, 100), Type = "StandingPhysics"},
		{Animal = pigGenerator.newPig ("Small", 825, 100), Type = "StandingPhysics"}
	}
	return levelAnimalTable
end
local function getLevelTwoAnimal ()
	local levelAnimalTable = {
		{Animal = pigGenerator.newPig ("Small", 710, 180), Type = "StandingPhysics"},
		{Animal = pigGenerator.newPig ("Small", 750, 180), Type = "StandingPhysics"},
		{Animal = pigGenerator.newPig ("Small", 790, 180), Type = "StandingPhysics"},
	}
	return levelAnimalTable
end
-----------------------------------------------------------------------------------------
-- Get level data
-----------------------------------------------------------------------------------------
function levelMaster.getLevelData (_level)
	if (_level == 1) then
		return getLevelOne ()
	elseif (_level == 2) then
		return getLevelTwo ()
	elseif (_level == 3) then
		return getLevelThree ()
	end
end
function levelMaster.getLevelAnimal (_level)
	if (_level == 1) then
		return getLevelOneAnimal ()
	elseif (_level == 2) then
		return getLevelTwoAnimal ()
	elseif (_level == 3) then
		return getLevelThreeAnimal ()
	end
end

return levelMaster