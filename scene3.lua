local sceneName = ...

local composer = require( "composer" )

local scene = composer.newScene( sceneName )
local nextSceneButton

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
		storyboard.returnTo = "scene2"
		storyboard.currentScene = "scene3"
	
        local title = self:getObjectByName( "Title" )
		title.x = display.contentWidth / 2
		title.y = display.contentHeight / 2
        title.size = display.contentWidth / 10
        local goToScene1Btn = self:getObjectByName( "GoToScene1Btn" )
        goToScene1Btn.x = display.contentWidth - 95
        goToScene1Btn.y = display.contentHeight - 35
        local goToScene1Text = self:getObjectByName( "GoToScene1Text" )
        goToScene1Text.x = display.contentWidth - 92
        goToScene1Text.y = display.contentHeight - 35
    elseif phase == "did" then
        nextSceneButton = self:getObjectByName( "GoToScene1Btn" )
        if nextSceneButton then
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        			composer.gotoScene( "scene1", { effect = "fade", time = 300 } )
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
