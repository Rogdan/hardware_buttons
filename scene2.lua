---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------

local nextSceneButton

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
		storyboard.returnTo = "scene1"
		storyboard.currentScene = "scene2"
	
        local title = self:getObjectByName( "Title" )
        title.x = display.contentWidth / 2
        title.y = display.contentHeight / 2
        title.size = display.contentWidth / 10
        local goToScene3Btn = self:getObjectByName( "GoToScene3Btn" )
        goToScene3Btn.x = display.contentWidth - 95
        goToScene3Btn.y = display.contentHeight - 35
        local goToScene3Text = self:getObjectByName( "GoToScene3Text" )
        goToScene3Text.x = display.contentWidth - 92
        goToScene3Text.y = display.contentHeight - 35
    elseif phase == "did" then
        nextSceneButton = self:getObjectByName( "GoToScene3Btn" )
        if nextSceneButton then
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        			composer.gotoScene( "scene3", { effect = "fade", time = 300 } )
					print(storyboard.currentScene)
        		end
        	end
        	nextSceneButton:addEventListener( "touch", nextSceneButton )
        end
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
	
	if phase == "did" then
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
    end 
end

scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene
