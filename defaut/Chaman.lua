Ovale.defaut["SHAMAN"] =
[[
Define(CHAINLIGHTNING 421)
Define(LIGHTNINGBOLT 403)
Define(LAVABURST 51505)
Define(WATERSHIELD 52127)
Define(FLAMESHOCK 8050)
Define(FLAMETHONG 8024)
Define(EARTHSHOCK 8042)
Define(STORMSTRIKE 17364)
Define(LAVALASH 60103)
Define(LIGHTNINGSHIELD 324)
Define(MAELSTROMWEAPON 53817)
Define(ELEMENTALMASTERY 16166)
Define(SHAMANISTICRAGE 30823)
Define(THUNDERSTORM 51490)
Define(FERALSPIRIT 51533)
Define(HEROISM 32182)
Define(BLOODLUST 2825)

#Fire
Define(TOTEMOFWRATH 30706)
Define(FIREELEMENTALTOTEM 2894)
Define(FIRENOVATOTEM 1535)
Define(FLAMETONGTOTEM 8227)
Define(FROSTRESISTANCETOTEM 8181)
Define(MAGMATOTEM 8190)
Define(SEARINGTOTEM 3599)
#Water
Define(CLEANSINGTOTEM 8170)
Define(FIRERESISTANCETOTEM 8184)
Define(HEALINGSTREAMTOTEM 5394)
Define(MANASPRINGTOTEM 5675)
#Air
Define(GROUNDINGTOTEM 8177)
Define(NATURERESISTANCETOTEM 10595)
Define(WINDFURYTOTEM 8512)
Define(WRATHOFAIRTOTEM 3738)
#Earth
Define(STONESKINTOTEM 8071)
Define(STRENGTHOFEARTHTOTEM 8075)
Define(TREMORTOTEM 8143)

AddCheckBox(chain SpellName(CHAINLIGHTNING))
AddCheckBox(melee L(Melee))
AddListItem(fire wrath SpellName(TOTEMOFWRATH))
AddListItem(fire nova SpellName(FIRENOVATOTEM))
AddListItem(fire tong SpellName(FLAMETONGTOTEM))
AddListItem(fire frost SpellName(FROSTRESISTANCETOTEM))
AddListItem(fire magma SpellName(MAGMATOTEM))
AddListItem(fire searing SpellName(SEARINGTOTEM))
AddListItem(water clean SpellName(CLEANSINGTOTEM))
AddListItem(water fire SpellName(FIRERESISTANCETOTEM))
AddListItem(water heal SpellName(HEALINGSTREAMTOTEM))
AddListItem(water mana SpellName(MANASPRINGTOTEM))
AddListItem(air ground SpellName(GROUNDINGTOTEM))
AddListItem(air nature SpellName(NATURERESISTANCETOTEM))
AddListItem(air wind SpellName(WINDFURYTOTEM))
AddListItem(air wrath SpellName(WRATHOFAIRTOTEM))
AddListItem(earth stone SpellName(STONESKINTOTEM))
AddListItem(earth strength SpellName(STRENGTHOFEARTHTOTEM))
AddListItem(earth tremor SpellName(TREMORTOTEM))

AddIcon
{
	unless CheckBoxOn(melee)
	{
	#	if BuffExpires(FLAMETHONG 2) Spell(FLAMETHONG)
		if BuffExpires(WATERSHIELD 2) Spell(WATERSHIELD)
		if TargetDebuffExpires(FLAMESHOCK 0 mine=1) Spell(FLAMESHOCK)
		Spell(LAVABURST doNotRepeat=1)
		if CheckBoxOn(chain) Spell(CHAINLIGHTNING doNotRepeat=1)
		Spell(LIGHTNINGBOLT)
	}
	if CheckBoxOn(melee)
	{
		if TargetDebuffExpires(FLAMESHOCK 0 mine=1) Spell(FLAMESHOCK)
		if TargetDebuffExpires(FLAMESHOCK 1.5 haste=spell mine=1) and 1.5s before Spell(LAVALASH)
			Spell(FLAMESHOCK)
		if TargetDebuffPresent(FLAMESHOCK 5 mine=1) Spell(EARTHSHOCK)
		if BuffExpires(LIGHTNINGSHIELD 0) Spell(LIGHTNINGSHIELD)
		Spell(STORMSTRIKE)
		if TargetDebuffPresent(FLAMESHOCK 1.5 haste=spell mine=1) Spell(LAVALASH)
		if CheckBoxOn(chain) and BuffPresent(MAELSTROMWEAPON stacks=5) Spell(CHAINLIGHTNING doNotRepeat=1)
		if BuffPresent(MAELSTROMWEAPON stacks=5) Spell(LIGHTNINGBOLT doNotRepeat=1)
	}
}

AddIcon
{
	Spell(ELEMENTALMASTERY)
	Spell(FERALSPIRIT)
	Spell(FIREELEMENTALTOTEM)
}

AddIcon size=small
{
	if ManaPercent(less 25)
		Spell(SHAMANISTICRAGE)
	if ManaPercent(less 50)
		Spell(THUNDERSTORM)
}

AddIcon size=small
{
	Spell(HEROISM)
	Spell(BLOODLUST)	
}

AddIcon size=small
{
	if TotemExpires(fire)
	{
		if List(fire wrath) Spell(TOTEMOFWRATH)
		if List(fire nova) Spell(FIRENOVATOTEM)
		if List(fire tong) Spell(FLAMETONGTOTEM)
		if List(fire frost) Spell(FROSTRESISTANCETOTEM)
		if List(fire magma) Spell(MAGMATOTEM)
		if List(fire searing) Spell(SEARINGTOTEM)
	}
	if TotemExpires(water)
	{
		if List(water clean) Spell(CLEANSINGTOTEM)
		if List(water fire) Spell(FIRERESISTANCETOTEM)
		if List(water heal) Spell(HEALINGSTREAMTOTEM)
		if List(water mana) Spell(MANASPRINGTOTEM)
	}
	if TotemExpires(air)
	{
		if List(air ground) Spell(GROUNDINGTOTEM)
		if List(air nature) Spell(NATURERESISTANCETOTEM)
		if List(air wind) Spell(WINDFURYTOTEM)
		if List(air wrath) Spell(WRATHOFAIRTOTEM)
	}
	if TotemExpires(earth)
	{
		if List(earth stone) Spell(STONESKINTOTEM)
		if List(earth strength) Spell(STRENGTHOFEARTHTOTEM)
		if List(earth tremor) Spell(TREMORTOTEM)
	}
}
]]