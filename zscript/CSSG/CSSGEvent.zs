Class CSSGEvent : Eventhandler
{	
	//basically, just type in console "NetEvent CM_AllShells" and voila, you got all the upgrades of this
	override void NetworkProcess(ConsoleEvent e)
	{
		let pm = players[e.player].mo;
		if(!pm)
			return;
			
		if (e.Name ~== "CM_AllShells")
		{
			pm.giveinventory("ExplosiveShellsUpgrade",1);
			pm.giveinventory("WPShellsUpgrade",1);
			pm.giveinventory("DoomShellsUpgrade",1);
			pm.giveinventory("DragonBreathUpgrade",1);
			pm.giveinventory("DanmakuUpgrade",1);
		}
		
	}
}

//finally
class CSSG_Injector : PBInjector
{
	override void Init(PB_EventHandler handler)
	{
		//Usage:
		//InjectSpawn(Spawner to inject, the thing you want to inject, 255, weight);
		//weight is the probability for this to spawn over others spawns in the spawner, usually a weight of 1 is good enough
		
		handler.InjectSpawn('PB_SSGSpawnerT2', 'PB_CSSG', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT3', 'PB_CSSG', 255, 1);
		handler.InjectSpawn('PB_SSGSpawnerT4', 'PB_CSSG', 255, 1);
		
		handler.InjectSpawn('PB_PackSpawnerT2', 'DanmakuShellsUpgrade', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT3', 'WPShellsUpgrade', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'ExplosiveShellsUpgrade', 255, 1);
		handler.InjectSpawn('PB_PackSpawnerT4', 'DoomShellsUpgrade', 255, 1);
	}
}