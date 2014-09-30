-----------------------------------------------------------------------------------------
-- Hong P. Nguyen
-- Music Module for Coron SDK
-----------------------------------------------------------------------------------------
local mainSoundMaster = {}
local mySoundTable = {}
local currentSound = {}
currentSound.BGMOption = {
	channel=2,
	loops=-1,
	fadein=1000,
	--onComplete=callbackListener
}
local myCurrentSong = nil
function mainSoundMaster.initializeSoundMaster ()
	mySoundTable.BGM = {
		{myBGM = audio.loadSound ("Assets/Music/mikuBGM.mp3"), ID = "Main"},
		{myBGM = audio.loadSound ("Assets/Music/calmBGM.mp3"), ID = "ETC"}
	}
	mySoundTable.SFX = {
		{mySFX = audio.loadSound ("Assets/Music/buttonDing.mp3"), ID = "Ding"},
	}
end
function mainSoundMaster.stopCurrentBGM ()
	if (myCurrentSong ~= nil) then
		audio.stop(currentSound.BGMChannel)
	end
end
function mainSoundMaster.playBGM (_ID)
	for i=1, #mySoundTable.BGM do
		if (_ID == mySoundTable.BGM[i].ID) then
			myCurrentSong = mySoundTable.BGM[i].ID
			currentSound.BGMChannel = audio.play(mySoundTable.BGM[i].myBGM, currentSound.BGMOption)
			break
		end
	end
end
function mainSoundMaster.playButtonSound (_ID)
	for i=1, #mySoundTable.SFX do
		if (_ID == mySoundTable.SFX[i].ID) then
			audio.play (mySoundTable.SFX[i].mySFX)
		end
	end
end
-----------------------------------------------------------------------------------------
--***************************************************************************************
--
--***************************************************************************************
-----------------------------------------------------------------------------------------
function mainSoundMaster.cleanUp ()
	for i=1, #mySoundTable.BGM do
		--clean up
	end
	for i=1, #mySoundTable.SFX do
		--clean up
	end
end

return mainSoundMaster