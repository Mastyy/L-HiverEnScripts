
const int SPL_Cost_InstantFireStorm = 25;
const int SPL_Damage_InstantFireStorm = 150;

instance Spell_Firestorm(C_Spell_Proto)
{
	time_per_mana = 0;
	damage_per_level = SPL_Damage_InstantFireStorm;
	damagetype = DAM_MAGIC;
};


func int Spell_Logic_Firestorm(var int manaInvested)
{
	if(Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		return SPL_SENDCAST;
	}
	else if(self.attribute[ATR_MANA] >= SPL_Cost_InstantFireStorm)
	{
		return SPL_SENDCAST;
	}
	else
	{
		return SPL_SENDSTOP;
	};
};

func void Spell_Cast_Firestorm()
{
	if(Npc_GetActiveSpellIsScroll(self))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
		if(Npc_IsPlayer(self))
		{
			STAT_EXHST += 35;
			b_magic_exhaustion();
		};
	}
	else
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_InstantFireStorm;
		if(Npc_IsPlayer(self))
		{
			STAT_EXHST += 35;
			b_magic_exhaustion();
		};
	};
	self.aivar[AIV_SelectSpell] += 1;
};

