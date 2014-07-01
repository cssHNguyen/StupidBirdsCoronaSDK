local moduleScoreUI = {}
local myScore = 0
local myScoreDisplay
function moduleScoreUI.initializeScoreUI ()
	myScoreDisplay = display.newText (myScore, 450, 18, font, 20)
end
function moduleScoreUI.cleanUp ()
	myScoreDisplay:removeSelf()
	myScore = 0
end
function moduleScoreUI.addPoints (_pointsRecieved)
	myScore = myScore + _pointsRecieved
	myScoreDisplay.text = myScore
end
return moduleScoreUI