// STALKER-style weapon lowering for reload when no dedicated reload sprites exist.
// After barrel checks in Reload:, Goto PBWP_OffsetReloadAnim (optional PBWP_OffsetReloadSetReturn first).

extend class PB_WeaponBase
{
	StateLabel pbwp_offsetReloadReturn;
	bool pbwp_offsetReloadReturnSet;

	action void PBWP_OffsetReloadSetReturn(StateLabel label)
	{
		if (invoker)
		{
			invoker.pbwp_offsetReloadReturn = label;
			invoker.pbwp_offsetReloadReturnSet = true;
		}
	}

	action void PBWP_OffsetReloadBegin()
	{
		A_WeaponOffset(0, 32);
		A_SetRoll(0);
		A_TakeInventory("PB_LockScreenTilt", 1);
		A_TakeInventory("Unloading", 1);
		A_TakeInventory("Reloading", 1);
		A_GiveInventory("Reloading", 1);
		A_TakeInventory("Zoomed", 1);
		A_ZoomFactor(1.0);
		if (invoker && !invoker.pbwp_offsetReloadReturnSet)
			invoker.pbwp_offsetReloadReturn = 'Ready3';
	}

	action void PBWP_OffsetReloadStep(int step)
	{
		switch (step)
		{
		case 0: A_WeaponOffset(0, 40, WOF_INTERPOLATE); break;
		case 1: A_WeaponOffset(2, 48, WOF_INTERPOLATE); break;
		case 2: A_WeaponOffset(4, 58, WOF_INTERPOLATE); break;
		case 3: A_WeaponOffset(6, 68, WOF_INTERPOLATE); break;
		case 4: A_WeaponOffset(4, 56, WOF_INTERPOLATE); break;
		case 5: A_WeaponOffset(2, 44, WOF_INTERPOLATE); break;
		case 6: A_WeaponOffset(0, 32, WOF_INTERPOLATE); break;
		}
	}

	action state PBWP_OffsetReloadFinish()
	{
		A_TakeInventory("Reloading", 1);
		StateLabel ret = 'Ready3';
		if (invoker)
		{
			ret = invoker.pbwp_offsetReloadReturn;
			invoker.pbwp_offsetReloadReturn = 'Ready3';
			invoker.pbwp_offsetReloadReturnSet = false;
		}
		return ResolveState(ret);
	}

	States
	{
	PBWP_OffsetReloadAnim:
		TNT1 A 0 PBWP_OffsetReloadBegin();
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(0);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(1);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(2);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(3);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 0 A_PlaySound("weapons/rifle/magin", CHAN_WEAPON);
		TNT1 A 10 A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(4);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(5);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 2
		{
			PBWP_OffsetReloadStep(6);
			A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB | WRF_NOSECONDARY | WRF_NOSWITCH);
		}
		TNT1 A 0 { return PBWP_OffsetReloadFinish(); }
		Stop;
	}
}
