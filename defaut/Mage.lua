Ovale.defaut["MAGE"]=
[[
Define(TALENTLIVINGBOMB 1852)
Define(TALENTPIERCINGICE 61)
Define(TALENTCHILLEDTOTHEBONES 1856)
Define(TALENTARCANEBARRAGE 1847)
Define(TALENTIMPROVEDSCORSH 25)

Define(HOTSTREAK 48108)
Define(IMPROVEDSCORCH 22959)

Define(PYROBLAST 11366)
Define(LIVINGBOMB 44457)
Define(SCORCH 2948)
Define(FROSTFIREBOLT 44614)
Define(FIREBALL 133)

Define(FROSTBOLT 116)
Define(DEEPFREEZE 44572)

Define(ARCANEBARRAGE 44425)
Define(ARCANEMISSILES 5143)
Define(ARCANEBLAST 30451)
Define(ARCANEPOWER 12042)
Define(MISSILEBARRAGE 44401)

Define(COMBUSTION 11129)
Define(ICYVEINS 12472)
Define(MIRRORIMAGE 55342)
Define(SUMMONWATERELEMENTAL 31687)
Define(PRESENCEOFMIND 12043)

AddCheckBox(scorch SpellName(SCORCH) default talent=TALENTIMPROVEDSCORSH)
AddCheckBox(abarr SpellName(ARCANEBARRAGE) default talent=TALENTARCANEBARRAGE)

SpellAddDebuff(PYROBLAST HOTSTREAK=0)
SpellAddDebuff(ARCANEBLAST ARCANEBLAST=10)
SpellAddDebuff(ARCANEMISSILES ARCANEBLAST=0)
SpellAddTargetDebuff(SCORCH IMPROVEDSCORCH=30)
SpellAddTargetDebuff(LIVINGBOMB LIVINGBOMB=12)
SpellInfo(MIRRORIMAGE cd=180)
SpellInfo(ARCANEPOWER cd=84)
SpellInfo(COMBUSTION cd=180)
SpellInfo(ICYVEINS cd=144)
SpellInfo(SUMMONWATERELEMENTAL cd=180)

ScoreSpells(SCORCH PYROBLAST LIVINGBOMB FROSTFIREBOLT FIREBALL SUMMONWATERELEMENTAL FROSTBOLT ARCANEBLAST ARCANEMISSILES)

AddIcon help=main
{
       if TalentPoints(TALENTLIVINGBOMB more 0)
       {
              #Fire spec
              if TargetDebuffExpires(IMPROVEDSCORCH 6) and CheckBoxOn(scorch) and TargetDeadIn(more 15) Spell(SCORCH)
              if BuffPresent(HOTSTREAK) Spell(PYROBLAST)
              if TargetDebuffExpires(LIVINGBOMB 0 mine=1) and TargetDeadIn(more 12) Spell(LIVINGBOMB)
              if TalentPoints(TALENTPIERCINGICE more 0)
                     Spell(FROSTFIREBOLT)
              if TalentPoints(TALENTPIERCINGICE less 1)
                     Spell(FIREBALL)
       }
       
       if TalentPoints(TALENTCHILLEDTOTHEBONES more 0)
       {
              #Frost spec
              if PetPresent(no) Spell(SUMMONWATERELEMENTAL)
              if TargetClassification(worldboss) Spell(DEEPFREEZE)
              Spell(FROSTBOLT)
       }
       
       if TalentPoints(TALENTARCANEBARRAGE more 0)
       {
				#Arcane spec
				unless DebuffPresent(ARCANEBLAST stacks=3)
					Spell(ARCANEBLAST)
				if BuffPresent(MISSILEBARRAGE)
					Spell(ARCANEMISSILES)
				if CheckBoxOn(abarr) Spell(ARCANEBARRAGE)
				Spell(ARCANEMISSILES)
       }
}

AddIcon help=cd
{
       Spell(MIRRORIMAGE)
       if DebuffPresent(ARCANEBLAST stacks=3) Spell(ARCANEPOWER)
       Spell(COMBUSTION)
       Spell(ICYVEINS)
       Spell(PRESENCEOFMIND)
       Item(Trinket0Slot usable=1)
       Item(Trinket1Slot usable=1)
}

]]