extend class Champion_Bundle
	{
	void Champion_BuildCompatBundle(void)
		{
		if(champion_Static.champion_GuncasterCheck())
			{
			Champion_Guncaster();
			}
		}
	
	void Champion_Guncaster(void)
		{
		switch(tier)
			{
			case 5:
				champion_PushModItem("Champion_GuncasterGemDropper",4);
				
			case 4:
				champion_PushModItem("TomeSpawner",	1);
				
			case 3:
				champion_PushModItem("Ruby",			4+(2*tier));
				
			case 2:
				champion_PushModItem("Amber",			8+(4*tier));
				
			case 1:	
				champion_PushModItem("Dosh35",			16+(6*tier));
				
			case 0:
			default:
				champion_PushModItem("Dosh25",			32+(8*tier));
					break;
			}
		}
	}

class Champion_GuncasterGemDropper : RandomSpawner
	{
	default
		{
		DropItem "champion_GC_Amber", 		255, 32;
		DropItem "champion_GC_Ruby",		255, 16;
		DropItem "champion_GC_Emerald",		255, 8;
		DropItem "champion_GC_Sapphire", 	255, 4;
		DropItem "champion_GC_Diamond", 	96, 1;
		}
	}

class Champion_ItemDropper : Actor
	{
	name dropClass; property dropClass : dropClass;
	default
		{
		+NOINTERACTION;
		Champion_ItemDropper.dropClass '';
		}
	override void PostBeginPlay()
		{
		super.postBeginPlay();
		
		A_SpawnItemEx(dropClass, xvel:frandom(1.0,2.0), zvel:8.0, angle:random(0,360));
		}
	}
	
class champion_GC_Amber 	: Champion_ItemDropper 	{ default { Champion_ItemDropper.dropClass 'Amber'; 	} }
class champion_GC_Ruby 		: Champion_ItemDropper 	{ default { Champion_ItemDropper.dropClass 'Ruby'; 		} }
class champion_GC_Emerald	: Champion_ItemDropper 	{ default { Champion_ItemDropper.dropClass 'Emerald'; 	} }
class champion_GC_Sapphire 	: Champion_ItemDropper 	{ default { Champion_ItemDropper.dropClass 'Sapphire'; 	} }
class champion_GC_Diamond 	: Champion_ItemDropper 	{ default { Champion_ItemDropper.dropClass 'Diamond'; 	} }

/* 		{
		switch(tier)
			{
			case 5:
				
				
			case 4:
				
				
			case 3:
				
				
			case 2:
				
				
			case 1:	
				
				
			case 0:
			default:
				
					break;
			}
		} */