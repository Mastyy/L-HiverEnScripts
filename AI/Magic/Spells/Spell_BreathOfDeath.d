
const int SPL_Cost_BreathOfDeath = 100;
const int SPL_Damage_BreathOfDeath = 550;

instance Spell_BreathOfDeath(C_Spell_Proto)
{
	time_per_mana = 0;
	damage_per_level = SPL_Damage_BreathOfDeath;
	targetCollectRange = 1200;
};


func int Spell_Logic_BreathOfDeath(var int manaInvested)
{
	if(Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		return SPL_SENDCAST;
	}
	else if(self.attribute[ATR_MANA] >= SPL_Cost_BreathOfDeath)
	{
		return SPL_SENDCAST;
	}
	else
	{
		return SPL_SENDSTOP;
	};
};

func void Spell_Cast_BreathOfDeath(var int spellLevel)
{
	if(Npc_GetActiveSpellIsScroll(self))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
		if(Npc_IsPlayer(self))
		{
			STAT_EXHST += 120;
			b_magic_exhaustion();
		};
	}
	else
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_BreathOfDeath;
		if(Npc_IsPlayer(self))
		{
			STAT_EXHST += 120;
			b_magic_exhaustion();
		};
	};
	self.aivar[AIV_SelectSpell] += 1;
};

