class BeefScientist : EventHandler
{
    override void WorldLoaded(WorldEvent e)
	{
		bool spawnedScientist = false;

		Array<Sector> validSecs;

		for (int i = 0; i < level.Sectors.Size(); ++i)
		{
			Sector sec = level.Sectors[i];
			if (!level.IsPointInLevel((sec.centerspot, sec.floorplane.ZAtPoint(sec.centerspot))))
			{
				continue;
			}
			if (sec.IsSecret() && random(1, 100) <= max(15, 60 - 5 * (level.total_secrets - 1)))
			{
				validSecs.Push(sec);
			}
			else if (!spawnedScientist && sec.IsSecret() && random(1, 100) <= max(15, 50 - 5 * (level.total_secrets - 1)))
			{
				vector3 spawnPos = (sec.centerspot.x, sec.centerspot.y, sec.floorplane.ZAtPoint(sec.centerspot));
				Actor a = Actor.Spawn("Scientist", spawnPos);
                console.printf("Scientist Spawned! at %d", spawnPos);
				// a.angle = sec.GetUDMFInt('user_slotmachineangle');
				spawnedScientist = true;
			}
		}
	}

    // override void WorldLoaded(WorldEvent e)
	// {
	// 	bool spawnedScientist = false;

	// 	// [Ace] Spawn stuff in sectors.
	// 	for (int i = 0; i < level.Sectors.Size(); ++i)
	// 	{
	// 		Sector CurrSec = level.Sectors[i];
	// 		vector3 SpawnPos = (CurrSec.centerspot.x, CurrSec.centerspot.y, CurrSec.floorplane.ZAtPoint(CurrSec.centerspot));

	// 		// Spawns a Survivor and a chance at an equipment item in secret sectors.
	// 		if (CurrSec.IsSecret() && !spawnedScientist)
	// 		{
	// 			Actor.Spawn("Scientist", SpawnPos);
    //             console.printf("Scientist Spawned! at %d", spawnPos);
	// 			spawnedScientist = true;
	// 		}			
	// 	}
    // }
}