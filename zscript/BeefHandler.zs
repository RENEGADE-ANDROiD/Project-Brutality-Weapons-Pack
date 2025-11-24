class BeefRiceWeaponDrop : EventHandler
{
	override void WorldThingDied(WorldEvent e)
	{
        let  actor = e.Thing;
        // name name = actor.GetClassName();
        // CVARS
        CVAR demontechAll = CVar.GetCVAR('PBSpawnALLDTechDrop');
        CVAR cyberdemonRL = CVar.GetCVAR('PBSpawnCyberdemonRLDrop');
        CVAR mastermindcg = CVar.GetCVAR('PBSpawnMastermindCGDrop');
        CVAR paingiver = CVar.GetCVAR('PBSpawnPaingiverDrop');

        // Initialize
        int DTechDrop = demontechAll.GetInt();
        int CyberRLDrop = cyberdemonRL.GetInt();
        int MastermindCGDrop = mastermindcg.GetInt();
        int PaingiverDrop = paingiver.GetInt();

        // Check and Spawn
        switch(actor.GetClassName())
        {
            case 'PB_CyberdemonGK':
            case 'PB_AnnihilatorGK':
                if(CyberRLDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                //console.printf("Cyberdemon Killed");
                actor.Spawn("CyberdemonRLSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            case 'HellTrooperPaingiver':
                if(PaingiverDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("PainGiverSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            //case 'PB_JuggernautGK': //Should we make the Juggernaut Drop MastermindCG?
            case 'PB_MastermindGK':
            case 'PB_DemolisherGK':
                if(MastermindCGDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("MastermindCGSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            case 'PB_DemonTechZombieGK':
                if(DTechDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("TechBlasterSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            // Add more here 
        }
	}
}