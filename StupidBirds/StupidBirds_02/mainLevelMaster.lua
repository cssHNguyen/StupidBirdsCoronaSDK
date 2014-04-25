local levelMaster = {}
local getLevelOne ()
	local levelTable = {
		{ID = "Pole", X = 100, Y == 100}
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