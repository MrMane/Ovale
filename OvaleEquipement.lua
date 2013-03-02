--[[--------------------------------------------------------------------
    Ovale Spell Priority
    Copyright (C) 2011, 2012, 2013 Sidoine, Johnny C. Lam

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License in the LICENSE
    file accompanying this program.
----------------------------------------------------------------------]]

local _, Ovale = ...
OvaleEquipement = Ovale:NewModule("OvaleEquipement", "AceEvent-3.0")

--<private-static-properties>
local pairs = pairs
local strfind = string.find
local tonumber = tonumber
local wipe = wipe
local GetInventoryItemLink = GetInventoryItemLink
local GetInventorySlotInfo = GetInventorySlotInfo

-- count of equipped pieces of an armor set: armorSetCount[armorSetName] = equippedCount
local armorSetCount = {}
-- database of armor set items: armorSet[itemId] = armorSetName
local armorSet = {
	-- Death Knight
	[85314] = "T14_tank",
	[85315] = "T14_tank",
	[85316] = "T14_tank",
	[85317] = "T14_tank",
	[85318] = "T14_tank",
	[86654] = "T14_tank",
	[86655] = "T14_tank",
	[86656] = "T14_tank",
	[86657] = "T14_tank",
	[86658] = "T14_tank",
	[86918] = "T14_tank",
	[86919] = "T14_tank",
	[86920] = "T14_tank",
	[86921] = "T14_tank",
	[86922] = "T14_tank",
	-- Druid
	[60281] = "T11",
	[60282] = "T11",
	[60283] = "T11",
	[60284] = "T11",
	[60285] = "T11",
	[60286] = "T11",
	[60287] = "T11",
	[60288] = "T11",
	[60289] = "T11",
	[60290] = "T11",
	[65189] = "T11",
	[65190] = "T11",
	[65191] = "T11",
	[65192] = "T11",
	[65193] = "T11",
	[65199] = "T11",
	[65200] = "T11",
	[65201] = "T11",
	[65202] = "T11",
	[65203] = "T11",
	[77013] = "T13",
	[77014] = "T13",
	[77015] = "T13",
	[77016] = "T13",
	[77017] = "T13",
	[78665] = "T13",
	[78684] = "T13",
	[78694] = "T13",
	[78713] = "T13",
	[78743] = "T13",
	[78760] = "T13",
	[78779] = "T13",
	[78789] = "T13",
	[78808] = "T13",
	[78838] = "T13",
	[85304] = "T14_caster",
	[85305] = "T14_caster",
	[85306] = "T14_caster",
	[85307] = "T14_caster",
	[85308] = "T14_caster",
	[85309] = "T14_melee",
	[85310] = "T14_melee",
	[85311] = "T14_melee",
	[85312] = "T14_melee",
	[85313] = "T14_melee",
	[85354] = "T14_heal",
	[85355] = "T14_heal",
	[85356] = "T14_heal",
	[85357] = "T14_heal",
	[85358] = "T14_heal",
	[85379] = "T14_tank",
	[85380] = "T14_tank",
	[85381] = "T14_tank",
	[85382] = "T14_tank",
	[85383] = "T14_tank",
	[86644] = "T14_caster",
	[86645] = "T14_caster",
	[86646] = "T14_caster",
	[86647] = "T14_caster",
	[86648] = "T14_caster",
	[86649] = "T14_melee",
	[86650] = "T14_melee",
	[86651] = "T14_melee",
	[86652] = "T14_melee",
	[86653] = "T14_melee",
	[86694] = "T14_heal",
	[86695] = "T14_heal",
	[86696] = "T14_heal",
	[86697] = "T14_heal",
	[86698] = "T14_heal",
	[86719] = "T14_tank",
	[86720] = "T14_tank",
	[86721] = "T14_tank",
	[86722] = "T14_tank",
	[86723] = "T14_tank",
	[86923] = "T14_melee",
	[86924] = "T14_melee",
	[86925] = "T14_melee",
	[86926] = "T14_melee",
	[86927] = "T14_melee",
	[86928] = "T14_heal",
	[86929] = "T14_heal",
	[86930] = "T14_heal",
	[86931] = "T14_heal",
	[86932] = "T14_heal",
	[86933] = "T14_caster",
	[86934] = "T14_caster",
	[86935] = "T14_caster",
	[86936] = "T14_caster",
	[86937] = "T14_caster",
	[86938] = "T14_tank",
	[86939] = "T14_tank",
	[86940] = "T14_tank",
	[86941] = "T14_tank",
	[86942] = "T14_tank",
	-- Hunter
	[77028] = "T13",
	[77029] = "T13",
	[77030] = "T13",
	[77031] = "T13",
	[77032] = "T13",
	[78661] = "T13",
	[78674] = "T13",
	[78698] = "T13",
	[78709] = "T13",
	[78737] = "T13",
	[78756] = "T13",
	[78769] = "T13",
	[78793] = "T13",
	[78804] = "T13",
	[78832] = "T13",
	[85294] = "T14",
	[85295] = "T14",
	[85296] = "T14",
	[85297] = "T14",
	[85298] = "T14",
	[86634] = "T14",
	[86635] = "T14",
	[86636] = "T14",
	[86637] = "T14",
	[86638] = "T14",
	[87002] = "T14",
	[87003] = "T14",
	[87004] = "T14",
	[87005] = "T14",
	[87006] = "T14",
	-- Mage
	[76212] = "T13",
	[76213] = "T13",
	[76214] = "T13",
	[76215] = "T13",
	[76216] = "T13",
	[78671] = "T13",
	[78701] = "T13",
	[78720] = "T13",
	[78729] = "T13",
	[78748] = "T13",
	[78766] = "T13",
	[78796] = "T13",
	[78815] = "T13",
	[78824] = "T13",
	[78843] = "T13",
	[85374] = "T14",
	[85375] = "T14",
	[85376] = "T14",
	[85377] = "T14",
	[85378] = "T14",
	[86714] = "T14",
	[86715] = "T14",
	[86716] = "T14",
	[86717] = "T14",
	[86718] = "T14",
	[87007] = "T14",
	[87008] = "T14",
	[87009] = "T14",
	[87010] = "T14",
	[87011] = "T14",
	-- Monk
	[85394] = "T14_melee",
	[85395] = "T14_melee",
	[85396] = "T14_melee",
	[85397] = "T14_melee",
	[85398] = "T14_melee",
	[86734] = "T14_melee",
	[86735] = "T14_melee",
	[86736] = "T14_melee",
	[86737] = "T14_melee",
	[86738] = "T14_melee",
	[87084] = "T14_melee",
	[87085] = "T14_melee",
	[87086] = "T14_melee",
	[87087] = "T14_melee",
	[87088] = "T14_melee",
	-- Paladin
	[76874] = "T13",
	[76875] = "T13",
	[76876] = "T13",
	[76877] = "T13",
	[76878] = "T13",
	[78675] = "T13",
	[78693] = "T13",
	[78712] = "T13",
	[78727] = "T13",
	[78742] = "T13",
	[78770] = "T13",
	[78788] = "T13",
	[78807] = "T13",
	[78822] = "T13",
	[78837] = "T13",
	[85319] = "T14_tank",
	[85320] = "T14_tank",
	[85321] = "T14_tank",
	[85322] = "T14_tank",
	[85323] = "T14_tank",
	[85339] = "T14_melee",
	[85340] = "T14_melee",
	[85341] = "T14_melee",
	[85342] = "T14_melee",
	[85343] = "T14_melee",
	[85344] = "T14_heal",
	[85345] = "T14_heal",
	[85346] = "T14_heal",
	[85347] = "T14_heal",
	[85348] = "T14_heal",
	[86659] = "T14_tank",
	[86660] = "T14_tank",
	[86661] = "T14_tank",
	[86662] = "T14_tank",
	[86663] = "T14_tank",
	[86679] = "T14_melee",
	[86680] = "T14_melee",
	[86681] = "T14_melee",
	[86682] = "T14_melee",
	[86683] = "T14_melee",
	[86684] = "T14_heal",
	[86685] = "T14_heal",
	[86686] = "T14_heal",
	[86687] = "T14_heal",
	[86688] = "T14_heal",
	[87099] = "T14_melee",
	[87100] = "T14_melee",
	[87101] = "T14_melee",
	[87102] = "T14_melee",
	[87103] = "T14_melee",
	[87104] = "T14_heal",
	[87105] = "T14_heal",
	[87106] = "T14_heal",
	[87107] = "T14_heal",
	[87108] = "T14_heal",
	[87109] = "T14_tank",
	[87110] = "T14_tank",
	[87111] = "T14_tank",
	[87112] = "T14_tank",
	[87113] = "T14_tank",
	-- Priest
	[85359] = "T14_heal",
	[85360] = "T14_heal",
	[85361] = "T14_heal",
	[85362] = "T14_heal",
	[85363] = "T14_heal",
	[85364] = "T14_caster",
	[85365] = "T14_caster",
	[85366] = "T14_caster",
	[85367] = "T14_caster",
	[85368] = "T14_caster",
	[86699] = "T14_heal",
	[86700] = "T14_heal",
	[86701] = "T14_heal",
	[86702] = "T14_heal",
	[86703] = "T14_heal",
	[86704] = "T14_caster",
	[86705] = "T14_caster",
	[86706] = "T14_caster",
	[86707] = "T14_caster",
	[86708] = "T14_caster",
	[87114] = "T14_heal",
	[87115] = "T14_heal",
	[87116] = "T14_heal",
	[87117] = "T14_heal",
	[87118] = "T14_heal",
	[87119] = "T14_caster",
	[87120] = "T14_caster",
	[87121] = "T14_caster",
	[87122] = "T14_caster",
	[87123] = "T14_caster",
	-- Rogue
	[71045] = "T12",
	[71046] = "T12",
	[71047] = "T12",
	[71048] = "T12",
	[71049] = "T12",
	[71537] = "T12",
	[71538] = "T12",
	[71539] = "T12",
	[71540] = "T12",
	[71541] = "T12",
	[77023] = "T13",
	[77024] = "T13",
	[77025] = "T13",
	[77026] = "T13",
	[77027] = "T13",
	[78664] = "T13",
	[78679] = "T13",
	[78699] = "T13",
	[78708] = "T13",
	[78738] = "T13",
	[78759] = "T13",
	[78774] = "T13",
	[78794] = "T13",
	[78803] = "T13",
	[78833] = "T13",
	[85299] = "T14",
	[85300] = "T14",
	[85301] = "T14",
	[85302] = "T14",
	[85303] = "T14",
	[86639] = "T14",
	[86640] = "T14",
	[86641] = "T14",
	[86642] = "T14",
	[86643] = "T14",
	[87124] = "T14",
	[87125] = "T14",
	[87126] = "T14",
	[87127] = "T14",
	[87128] = "T14",
	-- Shaman
	[71291] = "T12",
	[71292] = "T12",
	[71293] = "T12",
	[71294] = "T12",
	[71295] = "T12",
	[71552] = "T12",
	[71553] = "T12",
	[71554] = "T12",
	[71555] = "T12",
	[71556] = "T12",
	[77035] = "T13",
	[77036] = "T13",
	[77037] = "T13",
	[77038] = "T13",
	[77039] = "T13",
	[77040] = "T13",
	[77041] = "T13",
	[77042] = "T13",
	[77043] = "T13",
	[77044] = "T13",
	[78666] = "T13",
	[78667] = "T13",
	[78685] = "T13",
	[78686] = "T13",
	[78704] = "T13",
	[78711] = "T13",
	[78723] = "T13",
	[78724] = "T13",
	[78733] = "T13",
	[78741] = "T13",
	[78761] = "T13",
	[78762] = "T13",
	[78780] = "T13",
	[78781] = "T13",
	[78799] = "T13",
	[78806] = "T13",
	[78818] = "T13",
	[78819] = "T13",
	[78828] = "T13",
	[78836] = "T13",
	--Warlock
	[65248] = "T11",
	[65249] = "T11",
	[65250] = "T11",
	[65251] = "T11",
	[65252] = "T11",
	[65259] = "T11",
	[65260] = "T11",
	[65261] = "T11",
	[65262] = "T11",
	[65263] = "T11",
	[76339] = "T13",
	[76340] = "T13",
	[76341] = "T13",
	[76342] = "T13",
	[76343] = "T13",
	[78681] = "T13",
	[78702] = "T13",
	[78721] = "T13",
	[78730] = "T13",
	[78749] = "T13",
	[78776] = "T13",
	[78797] = "T13",
	[78816] = "T13",
	[78825] = "T13",
	[78844] = "T13",
	[85369] = "T14",
	[85370] = "T14",
	[85371] = "T14",
	[85372] = "T14",
	[85373] = "T14",
	[86709] = "T14",
	[86710] = "T14",
	[86711] = "T14",
	[86712] = "T14",
	[86713] = "T14",
	[87187] = "T14",
	[87188] = "T14",
	[87189] = "T14",
	[87190] = "T14",
	[87191] = "T14",
	-- Warrior
	[60323] = "T11",
	[60324] = "T11",
	[60325] = "T11",
	[60326] = "T11",
	[60327] = "T11",
	[65264] = "T11",
	[65265] = "T11",
	[65266] = "T11",
	[65267] = "T11",
	[65268] = "T11",
	[71068] = "T12",
	[71069] = "T12",
	[71070] = "T12",
	[71071] = "T12",
	[71072] = "T12",
	[71599] = "T12",
	[71600] = "T12",
	[71601] = "T12",
	[71602] = "T12",
	[71603] = "T12",
	[76983] = "T13",
	[76984] = "T13",
	[76985] = "T13",
	[76986] = "T13",
	[76987] = "T13",
	[78657] = "T13",
	[78668] = "T13",
	[78688] = "T13",
	[78706] = "T13",
	[78735] = "T13",
	[78752] = "T13",
	[78763] = "T13",
	[78783] = "T13",
	[78801] = "T13",
	[78830] = "T13",
	[85324] = "T14_tank",
	[85325] = "T14_tank",
	[85326] = "T14_tank",
	[85327] = "T14_tank",
	[85328] = "T14_tank",
	[85329] = "T14_melee",
	[85330] = "T14_melee",
	[85331] = "T14_melee",
	[85332] = "T14_melee",
	[85333] = "T14_melee",
	[86664] = "T14_tank",
	[86665] = "T14_tank",
	[86666] = "T14_tank",
	[86667] = "T14_tank",
	[86668] = "T14_tank",
	[86669] = "T14_melee",
	[86670] = "T14_melee",
	[86671] = "T14_melee",
	[86672] = "T14_melee",
	[86673] = "T14_melee",
	[87192] = "T14_melee",
	[87193] = "T14_melee",
	[87194] = "T14_melee",
	[87195] = "T14_melee",
	[87196] = "T14_melee",
	[87197] = "T14_tank",
	[87198] = "T14_tank",
	[87199] = "T14_tank",
	[87200] = "T14_tank",
	[87201] = "T14_tank",
}
--</private-static-properties>

--<public-static-methods>
function OvaleEquipement:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
end

function OvaleEquipement:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
end

function OvaleEquipement:PLAYER_EQUIPMENT_CHANGED(event, slot, hasItem)
	self:Refresh()
end

function OvaleEquipement:PLAYER_ENTERING_WORLD(event)
	self:Refresh()
end

function OvaleEquipement:GetArmorSetCount(name)
	if not armorSetCount[name] then
		return 0
	else
		return armorSetCount[name]
	end
end

function OvaleEquipement:Debug()
	for k, v in pairs(armorSetCount) do
		Ovale:Print("Player has " ..v.. "piece(s) of " ..k.. " armor set")
	end
end

function OvaleEquipement:GetItemId(slot)
	local link = GetInventoryItemLink("player", GetInventorySlotInfo(slot))
	if not link then return nil end
	local a, b, itemId = strfind(link, "item:(%d+)");
	return tonumber(itemId);
end

-- slots that can contain pieces from armor sets
local itemSlots = { "HeadSlot", "ShoulderSlot", "ChestSlot", "HandsSlot", "LegsSlot" }

function OvaleEquipement:Refresh()
	wipe(armorSetCount)
	for i = 1, #itemSlots do
		local itemId = self:GetItemId(itemSlots[i])
		if itemId then
			local name = armorSet[itemId]
			if name then
				if not armorSetCount[name] then
					armorSetCount[name] = 1
				else
					armorSetCount[name] = armorSetCount[name] + 1
				end
			end
		end
	end	
end
--</public-static-methods>
