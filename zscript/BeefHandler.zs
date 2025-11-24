class CyberdemonRLDrop : EventHandler
{
	override void WorldThingDied(WorldEvent e)
	{
        let  actor = e.Thing;
        CVAR c = CVar.GetCVAR('PBSpawnCyberdemonRLDrop');
        int CyberRLDrop = c.GetInt();
        String name = actor.GetClassName();

		if(CyberRLDrop == 1)
		{
            //console.printf("Spawn Checked");
			if(name == "PB_CyberdemonGK" || name == "PB_AnnihilatorGK")
			{
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                //console.printf("Cyberdemon Killed");
                actor.Spawn("CyberdemonsMissileLauncher", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
			}
		}
	}
}