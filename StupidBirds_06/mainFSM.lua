
local fsm = {}

function fsm.newFSM (_Owner)
	local myFSM = {}
	myFSM.Owner = _Owner
	myFSM.currentStage = nil


	function myFSM.changeState (_newState)
		if not _newState then return end

		if myFSM.currentState then
			myFSM.currentState.exit( myFSM.Owner )
		end

		myFSM.currentState = _newState
		myFSM.currentState.enter ( myFSM.Owner )
	end
	function myFSM.update (event)
		if myFSM.currentState then
			myFSM.currentState.execute ( myFSM.Owner )
		end
	end

	return myFSM
end
return fsm
