class cl_Handler : EventHandler
	{
	static const name cl_WeightVars[] =
		{
		'cl_weight_Bulwark', 'cl_weight_Brute', 'cl_weight_Swift', 'cl_weight_Volatile',
		'cl_weight_Toxic', 'cl_weight_Blink', 'cl_weight_Stalker', 'cl_weight_Splitter',
		'cl_weight_Veteran'
		};

	static const name cl_WeightVars_Mutations[] =
		{
		'cl_weight_Giant', 'cl_weight_Spectral', 'cl_weight_Rampage'
		};

	static const class<Thinker> cl_Controllers[] =
		{
		"cl_BulwarkController", "cl_BruteController", "cl_SwiftController", "cl_VolatileController",
		"cl_ToxicController", "cl_BlinkController", "cl_StalkerController", "cl_SplitterController",
		"cl_VeteranController"
		};

	static const int cl_MutationIds[] =
		{
		mutation_Giant, mutation_Spectral, mutation_Rampage
		};

	array<class<Thinker> > cl_WeightedTraits;
	array<int> cl_WeightedMutations;

	bool markers;
	double markerScale;
	bool particles;
	bool spawnFX;
	bool hitFX;
	bool missileGlow;
	bool traitFX;
	int mutationchance;
	array<Actor> cl_PendingRolls;
	int cl_PendingCursor;

	int cl_ControllerID(name controller)
		{
		for (int i = 0; i < cl_Controllers.Size(); i++)
			{
			if (controller == cl_Controllers[i].GetClassName())
				return i;
			}
		return 0;
		}

	void cl_BuildWeightedTraits()
		{
		cl_WeightedTraits.Clear();

		if (cl_Static.cl_ReturnCVAR("cl_debug_forced") != -1)
			{
			int forced = cl_Static.cl_ReturnCVAR("cl_debug_forced");
			if (forced >= 0 && forced < cl_Controllers.Size())
				cl_WeightedTraits.Push(cl_Controllers[forced]);
			return;
			}

		for (int i = 0; i < cl_WeightVars.Size(); i++)
			{
			int weight = cl_Static.cl_ReturnCVAR(cl_WeightVars[i]);
			for (int j = 0; j < weight; j++)
				cl_WeightedTraits.Push(cl_Controllers[i]);
			}
		}

	void cl_BuildMutationArray()
		{
		cl_WeightedMutations.Clear();
		for (int i = 0; i < cl_WeightVars_Mutations.Size(); i++)
			{
			int weight = cl_Static.cl_ReturnCVAR(cl_WeightVars_Mutations[i]);
			for (int j = 0; j < weight; j++)
				cl_WeightedMutations.Push(cl_MutationIds[i]);
			}
		}

	override void WorldLoaded(WorldEvent e)
		{
		cl_PendingRolls.Clear();
		cl_PendingCursor = 0;
		cl_BuildWeightedTraits();
		cl_BuildMutationArray();
		markers = cl_Static.cl_ReturnCVAR("cl_Markers");
		markerScale = cl_Static.cl_ReturnCVARFloat("cl_MarkerScale");
		particles = cl_Static.cl_ReturnCVAR("cl_Particles");
		bool visualFX = cl_Static.cl_ReturnCVAR("cl_VisualFX");
		spawnFX = visualFX;
		hitFX = visualFX;
		missileGlow = visualFX;
		traitFX = visualFX;
		mutationchance = cl_Static.cl_ReturnCVAR("cl_Mutations");
		}

	override void WorldThingSpawned(WorldEvent e)
		{
		if (!e || !e.Thing)
			return;

		let missileTarget = e.Thing.Target;
		if (e.Thing.bMISSILE && cl_Static.cl_ActorIsUsable(missileTarget) &&
			missileTarget.CountInv("cl_SwiftToken"))
			e.Thing.A_ScaleVelocity(1.35);

		if (missileGlow && e.Thing.bMISSILE && cl_Static.cl_ActorIsUsable(missileTarget) &&
			!missileTarget.player &&
			missileTarget.CountInv("cl_PersistentInfo"))
			{
			if (missileTarget.Health < 1)
				return;
			if (PBWP_FXThrottleHandler.PerformanceFireEnabled())
				return;

			let info = cl_PersistentInfo(missileTarget.FindInventory("cl_PersistentInfo"));
			if (info)
				{
				if (!PBWP_FXThrottleHandler.ShouldSpawnCosmeticFX(missileTarget))
					return;
				PBWP_FXThrottleHandler.RegisterCombatEvent(missileTarget);
				let effect = cl_MissileGlow(e.Thing.Spawn("cl_MissileGlow", e.Thing.pos));
				if (effect)
					{
					effect.master = e.Thing;
					effect.traitFrame = info.i;
					effect.frame = info.i;
					}
				}
			}

		if (!cl_CanChampionRoll(e.Thing))
			return;

		if (level.maptime < 1)
			{
			cl_PendingRolls.Push(e.Thing);
			return;
			}

		cl_TryChampionRoll(e.Thing);
		}

	override void WorldThingDestroyed(WorldEvent e)
		{
		if (!e || !e.Thing)
			return;
		for (int i = cl_PendingRolls.Size() - 1; i >= 0; i--)
			{
			if (cl_PendingRolls[i] == e.Thing)
				cl_PendingRolls.Delete(i);
			}
		if (cl_PendingCursor > cl_PendingRolls.Size())
			cl_PendingCursor = cl_PendingRolls.Size();
		}

	bool cl_CanChampionRoll(Actor mob)
		{
		if (!cl_Static.cl_ActorIsUsable(mob))
			return false;
		return mob.bCOUNTKILL
			&& !mob.bSPECIAL
			&& !mob.CountInv("cl_NullToken")
			&& !mob.CountInv("cl_PersistentInfo");
		}

	void cl_TryChampionRoll(Actor mob)
		{
		if (!cl_CanChampionRoll(mob) || cl_WeightedTraits.Size() < 1)
			return;

		int sk = G_SkillPropertyInt(SKILLP_ACSReturn);
		int chance = (4 + (sk * 10)) * (sk + 1);
		int or = cl_Static.cl_ReturnCVAR("cl_OverrideChance");
		if (or != -1) { chance = or; }

		if (random(0, 255) >= chance)
			return;

		int i = random(0, cl_WeightedTraits.Size() - 1);
		mob.A_GiveInventory("cl_PersistentInfo");
		let info = cl_PersistentInfo(mob.FindInventory("cl_PersistentInfo"));
		if (info)
			{
			info.c = cl_WeightedTraits[i];
			info.i = cl_ControllerID(cl_WeightedTraits[i].GetClassName());
			}

		let controller = cl_BaseController(new(cl_WeightedTraits[i]));
		if (controller)
			{
			controller.champion = mob;
			controller.markers = markers;
			controller.markerScale = markerScale;
			controller.particles = particles;
			controller.spawnFX = spawnFX;
			controller.hitFX = hitFX;
			controller.traitFX = traitFX;
			controller.mutation = cl_DoMutation(mob);
			}
		}

	override void WorldTick()
		{
		if (level.maptime < 1 || cl_PendingCursor >= cl_PendingRolls.Size())
			return;

		int processed = 0;
		while (cl_PendingCursor < cl_PendingRolls.Size() && processed < 8)
			{
			let mob = cl_PendingRolls[cl_PendingCursor];
			if (cl_Static.cl_ActorIsUsable(mob))
				cl_TryChampionRoll(mob);
			cl_PendingCursor++;
			processed++;
			}

		if (cl_PendingCursor >= cl_PendingRolls.Size())
			cl_PendingRolls.Clear();
		}

	int cl_DoMutation(actor mob)
		{
		if (!cl_Static.cl_ActorIsUsable(mob) || random(0, 255) >= mutationchance || cl_WeightedMutations.Size() == 0)
			return 0;

		let info = cl_PersistentInfo(mob.FindInventory("cl_PersistentInfo"));
		if (!info)
			return 0;

		int pick = cl_WeightedMutations[random(0, cl_WeightedMutations.Size() - 1)];
		info.m = pick;
		return pick;
		}

	override void WorldThingRevived(WorldEvent e)
		{
		if (!e || !cl_Static.cl_ActorIsUsable(e.Thing))
			return;
		let info = cl_PersistentInfo(e.Thing.FindInventory("cl_PersistentInfo"));
		if (!info)
			return;

		let controller = cl_BaseController(new(info.c));
		if (controller)
			{
			controller.mutation = info.m;
			controller.champion = e.Thing;
			controller.markers = markers;
			controller.markerScale = markerScale;
			controller.particles = particles;
			controller.spawnFX = spawnFX;
			controller.hitFX = hitFX;
			controller.traitFX = traitFX;
			}
		}

	override void WorldThingDamaged(WorldEvent e)
		{
		Actor victim = e.Thing;
		if (!victim)
			return;
		if (victim is "PlayerPawn" && cl_Static.cl_ActorIsUsable(e.DamageSource) &&
			e.DamageSource.CountInv("cl_ToxicToken"))
			victim.GiveInventory("cl_Poison", 1);
		}

	override void ConsoleProcess(ConsoleEvent e)
		{
		if (e.Name != 'cl_reset_traitweight')
			return;

		CVar.GetCVar("cl_weight_Bulwark").ResetToDefault();
		CVar.GetCVar("cl_weight_Brute").ResetToDefault();
		CVar.GetCVar("cl_weight_Swift").ResetToDefault();
		CVar.GetCVar("cl_weight_Volatile").ResetToDefault();
		CVar.GetCVar("cl_weight_Toxic").ResetToDefault();
		CVar.GetCVar("cl_weight_Blink").ResetToDefault();
		CVar.GetCVar("cl_weight_Stalker").ResetToDefault();
		CVar.GetCVar("cl_weight_Splitter").ResetToDefault();
		CVar.GetCVar("cl_weight_Veteran").ResetToDefault();
		}
	}

class cl_PoisonBase : Powerup
	{
	override void InitEffect()
		{
		super.InitEffect();
		owner.A_SetBlend("88cc00", 0.33, 35 * 4);
		}

	override void DoEffect()
		{
		super.DoEffect();
		if (owner && level.time % 35 == 0)
			owner.A_DamageSelf(2, "cl_Poison", flags: 0);
		}
	}

class cl_Poison : PowerupGiver
	{
	default
		{
		Powerup.Type "cl_PoisonBase";
		Powerup.Duration -3;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		}
	}
