class BeefRiceWeaponDrop : EventHandler
{
    // Check if something is killed
	override void WorldThingDied(WorldEvent e)
	{
        if (!e || !e.thing) return;
        if (!e.thing.bISMONSTER) return;
        let  actor = e.Thing;

        // Get CVARs
        let DTechDrop = CVar.GetCVAR('PBSpawnALLDTechDrop').GetInt();
        let MSSGDrop = CVar.GetCVAR('PBSpawnMSSGDrop').GetInt();
        let MastermindCGDrop = CVar.GetCVAR('PBSpawnMastermindCGDrop').GetInt();
        let PaingiverDrop = CVar.GetCVAR('PBSpawnPaingiverDrop').GetInt();

        let ShieldGRDrop = CVar.GetCVAR('EQSpawnShieldGR').GetInt();

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
            case 'PB_MastermindGK': case 'PB_DemolisherGK': case 'PB_Mastermind': case 'PB_Demolisher':
                if(MastermindCGDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("MastermindCGSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            case 'PB_DemonTechZombieGK':  case 'PB_DemonTechZombie':
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
                actor.Spawn("MarauderSSG", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                actor.Spawn("HookSpawn", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
                }
                break;

            // Add more here 
        }
	}
    
    // Special cases where something is spawned instead of killed
    override void WorldThingSpawned (WorldEvent e)
    {
        let  actor = e.Thing;
        // Get CVARs
        let MancFLameCNDrop = CVAR.GetCVAR('PBSpawnMancFlameCannonDrop').GetInt();
        let CyberRLDrop = CVar.GetCVAR('PBSpawnCyberdemonRLDrop').GetInt();

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