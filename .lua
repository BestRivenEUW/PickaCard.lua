--[[
	Pick a Card
		by BestRivenEUW

		Features:
			- Press shift to configure
			- Shows the range of attack
			- Press V to pick the Red card
			- Press E to pick the Blue card
			- Press Y to pick the Gold card
			- Hold Spacebar to pick the Yellow card
]]--
if myHero.charName ~= "TwistedFate" then return end
--[[		Code		]]
local selected = "goldcardlock"
local lastUse,lastUse2 = 0,0
local WREADY = false
local rangew = 700
function OnLoad()
	PaCConfig = scriptConfig("Pick a Card", "pickacard")
	PaCConfig:addParam("selectgold", "Select Gold", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	PaCConfig:addParam("selectblue", "Select Blue", SCRIPT_PARAM_ONKEYDOWN, false, 69)
	PaCConfig:addParam("selectred", "Select Red", SCRIPT_PARAM_ONKEYDOWN, false, 84)
	PaCConfig:addParam("drawcircles", "Draw Circles", SCRIPT_PARAM_ONOFF, true)
	PaCConfig:permaShow("selectgold")
	PaCConfig:permaShow("selectblue")
	PaCConfig:permaShow("selectred")
	PrintChat(" >> Pick a Card loaded!")
end
function OnTick()
	WREADY = (myHero:CanUseSpell(_W) == READY)
	if WREADY and GetTickCount()-lastUse <= 2300 then
		if myHero:GetSpellData(_W).name == selected then CastSpell(_W) end
	end
	if WREADY and myHero:GetSpellData(_W).name == "PickACard" and GetTickCount()-lastUse2 >= 2400 and GetTickCount()-lastUse >= 500 then 
		if PaCConfig.selectgold then selected = "goldcardlock"
		elseif PaCConfig.selectblue then selected = "bluecardlock"
		elseif PaCConfig.selectred then selected = "redcardlock"
		else return end	
		CastSpellEx(_W)
		lastUse = GetTickCount()
	end
end
function OnProcessSpell(unit, spell)
	if unit.isMe and spell.name == "PickACard" then lastUse2 = GetTickCount() end
end
function OnDraw()
	if PaCConfig.drawcircles and not myHero.dead then
		DrawCircle(myHero.x, myHero.y, myHero.z, rangew, 0x19A712)
	end
end
