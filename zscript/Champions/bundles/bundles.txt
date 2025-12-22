class champion_Bundle : Actor
	{
	array<string> 	DropItems;
	array<string>	ModItems;	// special array for extra mod items...
	int maxdrops;
	int tier;
	
	default
		{
		+NOINTERACTION;
		}
		
	void champion_PushItem(string item, int amount)
		{
		for(int i = 0; i < amount; i++)
			DropItems.Push(item);
		}
	
	void champion_PushModItem(string item, int amount)
		{
		for(int i = 0; i < amount; i++)
			ModItems.Push(item);
		}
	
	void champion_DropItems(int drops = 4)
		{
		int max = DropItems.Size()-1;
		for(int i = 0; i < drops; i++)
			{
			if (i >= DropItems.Size()) break;
			int drop = random(0,max);
			bool a;
			actor b;
			[a, b] = A_SpawnItemEx(DropItems[drop],				xvel:frandom(1.0,2.0),
																zvel:frandom(8.0,10.0),
																angle:frandom(0.0,359.9),
																failchance:32);
																
			if(a && b)
				b.A_ChangeCountFlags(FLAG_NO_CHANGE, false, FLAG_NO_CHANGE);
				
			DropItems.Delete(drop);
			max = dropitems.Size()-1;
			}
		}
	
	void champion_DropModitems(int drops = 4)
		{
		int max = ModItems.Size()-1;
		for(int i = 0; i < drops; i++)
			{
			if (i >= ModItems.Size()) break;
			int drop = random(0,max);
			bool a;
			actor b;
			[a, b] = A_SpawnItemEx(ModItems[drop],				xvel:frandom(1.0,2.0),
																zvel:frandom(8.0,10.0),
																angle:frandom(0.0,359.9),
																failchance:32);
																
			if(a && b)
				b.A_ChangeCountFlags(FLAG_NO_CHANGE, false, FLAG_NO_CHANGE);
				
			ModItems.Delete(drop);
			max = ModItems.Size()-1;
			}
		}		
	
	override void PostBeginPlay()
		{	
		switch(gameinfo.gametype)
			{
			case GAME_Doom:
			case GAME_Chex:
				champion_BuildDoomBundle();
				break;
				
			case GAME_Heretic:
				champion_BuildHereticBundle();
				break;
				
			case GAME_Hexen:
				champion_BuildHexenBundle();
				break;
				
			case GAME_Strife:
				champion_BuildStrifeBundle();
				break;
			
			default:
				//champion_BuildGenericBundle();
				break;
			}
			
		champion_BuildCompatBundle();
		
		if(dropitems.Size() > 0)
			champion_DropItems(maxdrops);
			
		if(moditems.Size() > 0)
			champion_DropModitems(int(clamp(maxdrops*0.5, 1, 25)));
		}
	}