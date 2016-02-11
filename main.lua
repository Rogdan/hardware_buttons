display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

local width = display.contentWidth;
local height = display.contentHeight;

local text = display.newText("status", width/2, height/2, native.systemFont, 30);
local phaseText = display.newText("button phase", width/2, height*3/4, native.systemFont, 30);

text:setFillColor(0.4, 0.4, 0.4)
phaseText:setFillColor(0.4, 0.4, 0.4)

local function onKeyEvent( event )
   local phase = event.phase
   local keyName = event.keyName
   phaseText.text = tostring(phase);

   if ( "back" == keyName and phase == "up" ) then
      if ( storyboard.currentScene == "scene1" ) then
         native.requestExit()
      else
            local lastScene = storyboard.returnTo

            if ( lastScene == nil ) then
				native.requestExit()
            else
				text.text = "It is work"
				composer.gotoScene( lastScene, { effect="crossFade", time=500 } )
            end
      end
	  return true;
   end

   if ( keyName == "volumeUp" and phase == "down" ) then
      text.text = "UP volume button"
      return true
   elseif ( keyName == "volumeDown" and phase == "down" ) then
      text.text = "DOWN volume button"
      return true
   end
   return false;
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )

storyboard = {};
-- load scene1
composer.gotoScene( "scene1" )

