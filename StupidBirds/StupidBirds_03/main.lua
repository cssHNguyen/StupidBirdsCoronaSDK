-----------------------------------------------------------------------------------------
--
-- Stupid Birds
-- By: Hong P Nguyen, President of Computer Science Society, C.S.U.E.B.
-- Please credit if you use my code.
-----------------------------------------------------------------------------------------
-- Main.lua is used to start the app
-- Corona SDK has a really power storyboard engine,
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
--because I am lazy?
levelSelector = 1
storyboard.purgeOnSceneChange = true
storyboard.gotoScene ("loadGame")
--storyboard.gotoScene ("mainMenu", {effect = "fade", time = 1500})
-----------------------------------------------------------------------------------------



