--[[--------------------------------------------------------------------
    Ovale Spell Priority
    Copyright (C) 2012 Sidoine

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License in the LICENSE
    file accompanying this program.
----------------------------------------------------------------------]]

-- Add-on that registers how many damage made the last spell cast by the player

local _, Ovale = ...
OvaleSpellDamage = Ovale:NewModule("OvaleSpellDamage", "AceEvent-3.0")

--<private-static-properties>
local select, strfind = select, string.find
local UnitGUID = UnitGUID
--</private-static-properties>

--<public-static-properties>
OvaleSpellDamage.value = {}
OvaleSpellDamage.playerGUID = nil
--</public-static-properties>

-- Events
--<public-static-methods>
function OvaleSpellDamage:OnEnable()
	self.playerGUID = UnitGUID("player")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function OvaleSpellDamage:OnDisable()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function OvaleSpellDamage:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local time, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = select(1, ...)

	if sourceGUID == self.playerGUID then
		if strfind(event, "SPELL_PERIODIC_DAMAGE")==1 or strfind(event, "SPELL_DAMAGE")==1 then
			local spellId, spellName, spellSchool, amount = select(12, ...)
			self.value[spellId] = amount
		end
	end
end

function OvaleSpellDamage:Get(spellId)
	return self.value[spellId]
end
--</public-static-methods>
