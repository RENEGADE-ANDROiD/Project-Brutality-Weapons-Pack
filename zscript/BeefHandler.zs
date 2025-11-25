class BeefRiceWeaponDrop : EventHandler
{
    // Check if something is killed
	override void WorldThingDied(WorldEvent e)
	{
        let  actor = e.Thing;
        // CVARS
        CVAR demontechAll = CVar.GetCVAR('PBSpawnALLDTechDrop');
        CVAR MarauderMSSG = CVar.GetCVAR('PBSpawnMSSGDrop');
        CVAR mastermindcg = CVar.GetCVAR('PBSpawnMastermindCGDrop');
        CVAR paingiver = CVar.GetCVAR('PBSpawnPaingiverDrop');

        CVAR ShieldGR = CVar.GetCVAR('EQSpawnShieldGR');

        // Initialize
        int MSSGDrop = MarauderMSSG.GetInt();
        int DTechDrop = demontechAll.GetInt();
        int MastermindCGDrop = mastermindcg.GetInt();
        int PaingiverDrop = paingiver.GetInt();

        int ShieldGRDrop = ShieldGR.GetInt();

        // Check what monster was killed
        switch(actor.GetClassName())
        {
            // Different Monsters spawn Different Things
            case 'HellTrooperPaingiver':
                if(PaingiverDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("PainGiverSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            //case 'PB_JuggernautGK': //Should we make the Juggernaut Drop MastermindCG?
            case 'PB_MastermindGK': case 'PB_DemolisherGK':
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
                actor.Spawn("DTechSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            // Monster Pack Stuff
            case 'CyberSatyr':
                if(ShieldGRDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("ShieldGrenadeDrop", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            case 'PB_Marauder':
                if(MSSGDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("MarauderDropSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            // Add more here 
        }
	}
    
    // Special casse if something is spawned instead of killed
    override void WorldThingSpawned (WorldEvent e)
    {
        let  actor = e.Thing;
        // CVARS
        CVAR MancFlameCN = CVAR.GetCVAR('PBSpawnMancFlameCannonDrop');
        CVAR cyberdemonRL = CVar.GetCVAR('PBSpawnCyberdemonRLDrop');

        // Initialize
        int MancFLameCNDrop = MancFlameCN.GetInt();
        int CyberRLDrop = cyberdemonRL.GetInt();

        // Check and Spawn
        switch(actor.GetClassName())
        {
            case 'XDeathCyberdemonGun':
                if(CyberRLDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("CyberdemonsMissileLauncher", (monsPos.x, monsPos.y, monsPos.z)); //Spawn the Weapon
                actor.destroy(); //Destroy the original actor so there's no duplicates
                }
                break;

            case 'PB_FlamethrowerMancubusGas':
                if(MancFLameCNDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("MancubusFlameCannon", (monsPos.x, monsPos.y, monsPos.z)); //Spawn the Weapon
                actor.destroy();
                }
                break;
        }
    }
}