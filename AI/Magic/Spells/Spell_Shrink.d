
const int SPL_Cost_Shrink = 180;

instance Spell_Shrink(C_Spell_Proto)
{
	time_per_mana = 0;
	spellType = SPELL_NEUTRAL;
	targetCollectAlgo = TARGET_COLLECT_FOCUS;
	targetCollectRange = 1000;
};


func int Spell_Logic_Shrink(var int manaInvested)
{
	if(Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		return SPL_SENDCAST;
	}
	else if(self.attribute[ATR_MANA] >= SPL_Cost_Shrink)
	{
		return SPL_SENDCAST;
	}
	else
	{
		return SPL_SENDSTOP;
	};
};

func void Spell_Cast_Shrink()
{
	if(Npc_GetActiveSpellIsScroll(self))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
		if(Npc_IsPlayer(self))
		{
			STAT_EXHST += 250;
			b_magic_exhaustion();
		};
	}
	else
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Shrink;
		if(Npc_IsPlayer(self))
		{
			STAT_EXHST += 250;
			b_magic_exhaustion();
		};
	};
	if((other.flags != NPC_FLAG_IMMORTAL) && !C_NpcIsUndead(other) && (other.guild > GIL_SEPERATOR_HUM) && (other.guild != GIL_DRAGON) && (other.aivar[AIV_MM_REAL_ID] != ID_TROLL_BLACK) && (other.aivar[AIV_MM_ShrinkState] == 0))
	{
		Npc_ClearAIQueue(other);
		B_ClearPerceptions(other);
		AI_StartState(other,ZS_MagicShrink,0,"");
	}
	else
	{
		PrintScreen(PRINT_SPELLNOTWORK,-1,40,FONT_ScreenSmall,3);
	};
	self.aivar[AIV_SelectSpell] += 1;
};

