enum champion_Colours
	{
	champ_DarkRed,
	champ_Red,
	champ_Orange,
	champ_Yellow,
	champ_DarkGreen,
	champ_Green,
	champ_Cyan,
	champ_Blue,
	champ_Indigo,
	champ_Violet,
	champ_Pink,
	champ_Black,
	champ_Grey,
	champ_White,
	champ_Bronze,
	champ_Silver,
	champ_Gold,
	}

enum champion_mutations
	{
	mutation_None,
	mutation_Titan,
	mutation_Undying,
	mutation_Ghost,
	mutation_Balloon,
	mutation_Hybrid,
	};

class champion_HealthBonus : HealthBonus
	{
	default
		{
		+RANDOMIZE;
		-COUNTITEM;
		}
	
	override void PostBeginPlay(void)
		{
		Super.PostBeginPlay();
		
		bSPRITEFLIP = random(0,1);
		frame = random(0,7);
		}
	
	states
		{
		Spawn:
			FRUT "#" 35;
			FRUT "#" 1 Bright;
			loop;
		}
	}

class champion_IceChunk : IceChunk replaces IceChunk
	{
	default
		{
		Translation "champion_Ice";
		}
	}

class champion_static 
	{
	static const class<inventory> champion_Tokens[] =
		{
		"champion_DarkRedToken",		"champion_RedToken",		"champion_OrangeToken",
		"champion_YellowToken",			"champion_DarkGreenToken",	"champion_GreenToken",
		"champion_CyanToken",			"champion_BlueToken",		"champion_IndigoToken",
		"champion_VioletToken",			"champion_PinkToken",		"champion_BlackToken",
		"champion_GreyToken",			"champion_WhiteToken",		"champion_BronzeToken",
		"champion_SilverToken",			"champion_GoldToken"
		};
	
	static bool champion_LegendoomCheck(void)
		{
		if(champion_Static.champion_ReturnCVAR('champion_Legendoom'))
			{
			if(	Wads.FindLump("LEGNDLIB") 					!= -1 ||
				Wads.CheckNumForFullName("acs/LEGNDLIB.o") 	!= -1)
				{
				if(champion_static.champion_ReturnCVAR('champion_Debug'))
					console.printf("Legendoom Compat Identified"); 
				return true;
				}
				
			return false;
			}
			
		return false;
		}
	
	static bool champion_GuncasterCheck(void)
		{
		if( Wads.CheckNumForFullName("Loreyore.txt") != -1)
			return true;
			
		return false;
		}
	
	static int champion_ReturnCVAR(name c)
		{
		cvar cv = CVar.FindCVar(c);
		if(cv)
			{
			return cv.GetInt();
			}		
		return 0;
		}
		
	static double champion_ReturnCVARFloat(name c)
		{
		cvar cv = CVar.FindCVar(c);
		if(cv)
			{
			return cv.GetFloat();
			}		
		return 0;
		}
		
	}
