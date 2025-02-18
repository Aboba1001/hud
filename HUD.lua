local botplayTxts = {
 "[BOTPLAY]",
 "[AUTOPLAY]",
 "why are you\ndoing this",
 ":face_with_symbols_over_mouth:",
 "Noob",
 "Skill Issue",
 "you got no skill\n don\"t you?",
 "I am 0.5km away from you",
 "WHY CAN\"T YOU JUST\nTURN ON PRACTICE MODE??!?!"
}
local debugMode = true -- Activates Debug Mode
local hudStyle = scoreTxtStyle -- Change HUD Style
-- Default, Psych, Kade, Forever, osu!Mania
local wasd = false
local controls = {
 ["LEFT"] = "W",
 ["UP"] = "A",
 ["DOWN"] = "S",
 ["RIGHT"] = "D"
}
function onCreatePost()
 setProperty("timeBar.visible", false)
 setProperty("timeTxt.visible", false)
 
 debugPrint(currentModDirectory)
 
 configureJson = json.parse(getTextFromFile("mods/My-Mod/_HUDSETTINGS.json"))
 if configureJson then
   for key, value in pairs(configureJson) do
     _G[key] = value
   end
 end

 local timeTxtX = getProperty("timeTxt.x")
 local timeTxtY = getProperty("timeTxt.y")

 makeLuaText("CustomTimeInfo", " - [" .. songName .. " - " .. difficultyName .. "] - ", 0, 0, 0)
 setTextSize("CustomTimeInfo", getTextSize("timeTxt") - 10)
 setObjectCamera("CustomTimeInfo", "hud")
 setTextBorder("CustomTimeInfo", 1, "000000")
 setProperty("CustomTimeInfo.x", timeTxtX + 50)
 setProperty("CustomTimeInfo.y", timeTxtY + 10)
 addLuaText("CustomTimeInfo")
 
 makeLuaText("CustomTimeTxt", " - [" .. songName .. " - " .. difficultyName .. "] - ", 0, 0, 0)
 setTextSize("CustomTimeTxt", getTextSize("timeTxt") - 10)
 setObjectCamera("CustomTimeTxt", "hud")
 setTextBorder("CustomTimeTxt", 1, "000000")
 setProperty("CustomTimeTxt.x", timeTxtX + 50)
 setProperty("CustomTimeTxt.y", timeTxtY + 10)
 addLuaText("CustomTimeTxt")
 
 local scoreTxtX = getProperty("scoreTxt.x")
 local scoreTxtY = getProperty("scoreTxt.y")
 local scoreTxtWidth = getProperty("scoreTxt.width")
 local scoreTxtHeight = getProperty("scoreTxt.height")
 
 makeLuaSprite("scoreTxtBackground", "", scoreX - 5, scoreY - 5)
 makeGraphic("scoreTxtBackground", scoreWidth + 10, scoreHeight + 10, "000000")
 setObjectCamera("scoreTxtBackground", "hud")
 setProperty("scoreTxtBackground", scoreTxtX - 5)
 setProperty("scoreTxtBackground", scoreTxtY - 5)
 setProperty("scoreTxtBackground", scoreTxtWidth)
 setProperty("scoreTxtBackground", scoreTxtHeight)
 --setObjectOrder("scoreTxtBackground", getObjectOrder("scoreTxt") - 1)
 addLuaSprite("scoreTxtBackground", false)
   
 if debugMode then
  debugPrint("DEBUG MODE ACTIVATED")
 end
 if curStage == "school" or curStage "schoolEvil" then
  setTextFont("scoreTxt", "pixel-latin.ttf")
 end
 
 local randomNum = getRandomInt(0,#botplayTxts)
 setTextString("botplayTxt", botplayTxts[randomNum])
end

function onSongStart()
end

function onUpdatePost()
 local acc = (string.sub(getProperty("ratingPercent")* 100,0,5))
 local health = tostring(getProperty("health") / 2 * 100)
 
 local style = configureJson.scoreTxtStyle
 
 local hudText = "- / Score: " .. score .. " / Misses: " .. misses .. " / ACC & Rating: " .. acc .. "% [" .. ratingFC .. "] / -"
 local foreverHud = "Score: " .. score .. " • Combo Breaks: " .. misses
 local kadeHud = "Score: " .. score .. " | Combo Breaks: " .. misses .. " | Accuracy: " .. acc .. "% - " .. ratingFC
 
 if style == "Default" then
   setTextString("scoreTxt", hudText)
 elseif style == "Forever" then
   setTextString("scoreTxt", foreverHud)
 elseif style == "kadeHud" then
   setTextString("scoreTxt", kadeHud)
 end
 
end

function onCustomSubstateCreate(name)
  if name == "Results Screen" then
    makeLuaSprite("RS_bg", nil, 0, 0)
    makeGraphic("RS_bg", screenWidth, screenHeight, "000000")
    setObjectCamera("RS_bg", "other")
    
    makeLuaText("RS_TotalScore", "| Score: " .. score, 0, 0, 0)
    setTextSize("RS_TotalScore", 20)
    setObjectCamera("RS_TotalScore", "other")
    
    makeLuaText("RS_JudgmentBar", "SICKS: " .. sicks .. "\n\nGOODS: " .. goods .. "\n\nBADS: " .. bads .. "\n\nSHITS: " .. shits, 0, 0, 0)
    setTextSize("RS_JudgmentBar", 25)
    setObjectCamera("RS_JudgmentBar", "other")
    
    if buildTarget == "android" or "ios" then
      makeLuaText("RS_PressEnter", "Press here to continue!", 0, 0, 0)
      else
        makeLuaText("RS_PressEnter", "Click ENTER to continue!", 0, 0, 0)
    end
    setTextSize("RS_PressEnter", 30)
    setObjectCamera("RS_PressEnter", "other")
    
    insertToCustomSubstate("RS_TotalScore")
    insertToCustomSubstate("RS_JudgmentBar")
    insertToCustomSubstate("RS_PressEnter")
    
    local mobilePlatforms = {"android", "ios"}
    if table.contains(mobilePlatforms, buildTarget) then
      if keyboardJustPressed("smth") then
        debugPrint("ok")
      end
    end
    local desktopPlatforms = {"windows", "linux", "mac"}
    if table.contains(desktopPlatforms, buildTarget) then
      if keyboardJustPressed("enter") then
        debugPrint("ok")
      end
    end
  end
end