class BeefRiceWeaponDrop : EventHandler
{
	override void WorldThingDied(WorldEvent e)
	{
        let  actor = e.Thing;
        // CVARS
        CVAR demontechAll = CVar.GetCVAR('PBSpawnALLDTechDrop');
        CVAR MarauderMSSG = CVar.GetCVAR('PBSpawnMSSGDrop');
        CVAR cyberdemonRL = CVar.GetCVAR('PBSpawnCyberdemonRLDrop');
        CVAR mastermindcg = CVar.GetCVAR('PBSpawnMastermindCGDrop');
        CVAR paingiver = CVar.GetCVAR('PBSpawnPaingiverDrop');

        // Initialize
        int MSSGDrop = MarauderMSSG.GetInt();
        int DTechDrop = demontechAll.GetInt();
        int CyberRLDrop = cyberdemonRL.GetInt();
        int MastermindCGDrop = mastermindcg.GetInt();
        int PaingiverDrop = paingiver.GetInt();

        // Check and Spawn
        switch(actor.GetClassName())
        {
            case 'PB_CyberdemonGK': case 'PB_AnnihilatorGK':
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
                actor.Spawn("TechBlasterSpawner", (monsPos.x, monsPos.y, monsPos.z + monsHeight/2));
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
    
    //If something is spawned instead of killed
    override void WorldThingSpawned (WorldEvent e)
    {
        let  actor = e.Thing;
        // CVARS
        CVAR MancFlameCN = CVAR.GetCVAR('PBSpawnMancFlameCannonDrop');

        // Initialize
        int MancFLameCNDrop = MancFlameCN.GetInt();

        // Check and Spawn
        switch(actor.GetClassName())
        {
            case 'PB_FlamethrowerMancubusGas':
                if(MancFLameCNDrop == 1)
                {
                vector3 monsPos = actor.pos;
                double monsHeight = actor.height;
                actor.Spawn("MancubusFlameCannon", (monsPos.x, monsPos.y, monsPos.z));
                actor.destroy();
                }
                break;
        }
    }
}

/// SPECIAL CASES
/*class MancFlameCannonDrop : XDeathMancubusArm replaces XDeathMancubusArm
{ 
    States
    {
    Spawn:
        TNT1 A 0 A_JumpIf(waterlevel > 1, "Death");
        MANA ABCDEFG 3;
        Loop;
    Death:
        TNT1 A 0 A_SpawnItem("Brutal_BloodSpot",0,0,0,1);
        TNT1 A 0 A_JumpIf(GetCVAR("PBSpawnMancFlameCannonDrop") == 0, "StandardDeath");
        TNT1 A 0 A_SpawnItem("MancubusFlameCannon",0,0,0,1);
    Stop;
    StandardDeath:
        TNT1 A 0 A_SpawnItem("PB_FlamethrowerMancubusGas",0,0,0,1);
    Stop;
    }
} */
