Ovale.defaut["WARLOCK"]=
[[
Define(CURSERECKLESSNESS 704)
Define(CURSEELEMENTS 1490)
Define(CURSEAGONY 980)
Define(CURSEDOOM 603)
Define(CURSETONGUES 1714)
Define(CURSEWEAKNESS 702)
Define(SHIPHONLIFE 18265)
Define(UNSTABLEAFFLICTION 30108)
Define(CORRUPTION 172)
Define(TALENTUNSTABLEAFFLICTION 1670)
Define(TALENTSHADOWBOLT 944)
Define(IMMOLATE 348)
Define(TALENTIMMOLATE 961)
Define(TALENTEMBERSTORM 966)
Define(SOULFIRE 6353)
Define(SHADOWBOLT 686)
Define(HAUNT 48181)
Define(TALENTBACKDRAFT 1888)
Define(CONFLAGRATE 17962)
Define(DRAINSOUL 47855)
Define(SHADOWEMBRACE 32391)
Define(TALENTSHADOWEMBRACE 1763)
Define(METAMORPHOSIS 47241)

AddListItem(curse recklessness SpellName(CURSERECKLESSNESS))
AddListItem(curse elements SpellName(CURSEELEMENTS))
AddListItem(curse agony SpellName(CURSEAGONY))
AddListItem(curse doom SpellName(CURSEDOOM))
AddListItem(curse tongues SpellName(CURSETONGUES))
AddListItem(curse weakness SpellName(CURSEWEAKNESS))

AddIcon
{
if TalentPoints(TALENTSHADOWEMBRACE more 0) and TargetDebuffExpires(SHADOWEMBRACE 0) Spell(SHADOWBOLT)
if TargetDebuffExpires(HAUNT 1.5 mine=1) Spell(HAUNT doNotRepeat=1)
if TargetDebuffExpires(UNSTABLEAFFLICTION 1.5 mine=1) Spell(UNSTABLEAFFLICTION doNotRepeat=1)
if TalentPoints(TALENTBACKDRAFT more 0) and TargetDebuffExpires(IMMOLATE 3 mine=1)
   and TargetDebuffPresent(IMMOLATE mine=1) Spell(CONFLAGRATE doNotRepeat=1)
if TargetDebuffExpires(IMMOLATE 1.5 mine=1) and TargetLifePercent(more 25) Spell(IMMOLATE doNotRepeat=1)
if List(curse recklessness) and TargetDebuffExpires(CURSERECKLESSNESS 2) Spell(CURSERECKLESSNESS)
if List(curse elements) and TargetDebuffExpires(CURSEELEMENTS 2) Spell(CURSEELEMENTS)
if List(curse doom) and TargetDebuffExpires(CURSEDOOM 0 mine=1) Spell(CURSEDOOM)
if List(curse tongues) and TargetDebuffExpires(CURSETONGUES 2) Spell(CURSETONGUES)
if List(curse weakness) and TargetDebuffExpires(CURSEWEAKNESS 2) Spell(CURSEWEAKNESS)
if List(curse agony) and TargetDebuffExpires(CURSEAGONY 0 mine=1) Spell(CURSEAGONY)
if TargetDebuffExpires(CORRUPTION 0 mine=1) Spell(CORRUPTION)
if TargetDebuffExpires(SHIPHONLIFE 0 mine=1) Spell(SHIPHONLIFE)

if TargetLifePercent(less 25) and Level(more 76) Spell(DRAINSOUL)
 
if TalentPoints(TALENTEMBERSTORM more 0) Spell(SOULFIRE)
Spell(SHADOWBOLT)
}

AddIcon
{
	Spell(METAMORPHOSIS)
}
]]
