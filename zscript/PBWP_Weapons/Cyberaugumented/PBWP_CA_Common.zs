// Shared PBWP integration helpers for Cyberaugumented weapon fold.
// PBWP cannot extend PB_WeaponBase in this TU (UZDoom 4.14) — use a shared subclass.

class PBWP_CA_WeaponBase : PB_WeaponBase
{
	action void PBWP_CA_ReadyPose(int crosshair = 44)
	{
		A_WeaponOffset(0, 32);
		A_SetRoll(0);
		PB_HandleCrosshair(crosshair);
		A_TakeInventory("PB_LockScreenTilt", 1);
		A_ClearOverlays(10, 11);
	}

	action void PBWP_CA_LockTilt()
	{
		A_GiveInventory("PB_LockScreenTilt", 1);
	}

	action void PBWP_CA_UnlockTilt()
	{
		A_TakeInventory("PB_LockScreenTilt", 1);
	}

	action state PBWP_CA_FatalityGate()
	{
		if (CountInv("GoFatality") >= 1)
		{
			SetPlayerProperty(0, 1, 0);
			return ResolveState("Steady");
		}
		SetPlayerProperty(0, 0, 0);
		SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
		return ResolveState(null);
	}

	action void PBWP_CA_DeselectCleanup()
	{
		A_WeaponOffset(0, 32);
		A_SetRoll(0);
		A_TakeInventory("PB_LockScreenTilt", 1);
		A_TakeInventory("Unloading", 1);
		A_TakeInventory("Reloading", 1);
		A_TakeInventory("Zoomed", 1);
		A_ZoomFactor(1.0);
	}

	action void PBWP_CA_DeferredRailHit(int damage, Name dmgType = 'Hitscan')
	{
		let ply = player;
		if (!ply || !ply.mo)
			return;

		let mo = ply.mo;
		FLineTraceData lt;
		double aimz = ply.viewheight;
		mo.LineTrace(mo.angle, 8192, mo.pitch, 0, aimz, data: lt);
		if (PBWP_CombatDamageHandler.IsCombatTarget(lt.hitActor, mo))
			PBWP_CombatDamageHandler.Schedule(lt.hitActor, mo, mo, damage, dmgType);
	}
}
