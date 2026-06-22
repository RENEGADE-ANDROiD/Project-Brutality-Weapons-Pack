// Cinereal Ordnance — Cyberaugumented superweapon (folded from DCY_TheCinerealOrdnance).

class PBWP_CinerealOrdnance : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 9;
		Weapon.SlotPriority 0.05;
		Weapon.AmmoType1 "PB_DTech";
		Weapon.AmmoType2 "PBWP_CinerealMag";
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 100;
		+WEAPON.EXPLOSIVE;
		+WEAPON.BFG;
		+BRIGHT;
		Tag "The Cinereal Ordnance";
		Inventory.PickupMessage "You have the Cinereal Ordnance! We're going to have a lot of fun.";
		Inventory.PickupSound "CinerealOrdnance/Up";
		Weapon.UpSound "CinerealOrdnance/Up";
		Inventory.Icon "CINRZ0";
		Obituary "%o got removed by %k's Cinereal Ordnance.";
	}

	action void PBWP_CinerealBurst(bool altOffset)
	{
		A_GunFlash();
		A_QuakeEx(3, 3, 3, 25, 0, 1000, "", QF_RELATIVE | QF_SCALEDOWN);
		A_FireProjectile("PBWP_CA_CinerealLaser", 0, altOffset ? 1 : 0);
		A_TakeInventory("PBWP_CinerealMag", 3);
	}

	action void PBWP_CinerealIdleLoop()
	{
		A_StartSound("CinerealOrdnance/Idle", CHAN_6, CHANF_LOOPING | CHANF_NOSTOP, 1, 0.5);
	}

	states
	{
	Spawn:
		CINR Z -1;
		Stop;

		Steady:
		TNT1 A 1;
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 SetPlayerProperty(0, 0, 0);
		TNT1 A 0 SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
		Goto Ready3;

		Select:
		TNT1 A 0 A_WeaponOffset(0, 32);
		Goto SelectFirstPersonLegs;

	SelectContinue:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_StopSound(CHAN_6);
		TNT1 A 0 PB_WeaponRaise("CinerealOrdnance/Up");
		TNT1 A 0 PB_WeapTokenSwitch("BFGSelected");
		TNT1 A 0 PB_SetMagUnloaded(false);
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto Ready3;
	SelectAnimation:
		CINR WXY 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 {
			A_StopSound(CHAN_6);
			A_StopSound(CHAN_5);
			PBWP_CA_DeselectCleanup();
		}
		CINR YXW 1;
		Goto DeselectDown;
	DeselectDown:
		TNT1 AAAAAAAAAAAAAAAAAA 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		CINR A 1 Bright {
			PBWP_CinerealIdleLoop();
			A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		}
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PBWP_CinerealMag", 3, 2);
		Goto ReloadMag;
		TNT1 A 0 PBWP_CA_LockTilt();
		CINR H 0
		{
			A_SetBlend("White", 0.75, 30);
			A_StartSound("CinerealOrdnance/Charge", CHAN_6, 0, 0.35);
		}
		CINR HIJKL 1;
		CINR L 1 A_StartSound("CinerealOrdnance/Laser", CHAN_6, 1.0, 1, 0.5);
		Goto FireLoop;

		FireLoop:
		CINR MN 1 { PBWP_CinerealBurst(false); }
		CINR O 1 { PBWP_CinerealBurst(true); }
		CINR M 0 A_Refire("FireLoop");
		CINR T 5
		{
			A_StopSound(CHAN_6);
			A_SetBlend("White", 0.5, 30);
			A_StartSound("CinerealOrdnance/Cooldown", CHAN_6, 0, 0.5);
		}
		CINR TSRQP 5;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		Goto Ready3;

	ReloadMag:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 PB_CheckReload(null, "DoReload", null, "Ready3", "Ready3", 100, 1);
		Goto Ready3;
	DoReload:
		TNT1 A 10 { PB_AmmoIntoMag("PBWP_CinerealMag", "PB_DTech", 100, 1, 1); }
		Goto Ready3;

		Unload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 { PB_SetMagUnloaded(true); PB_UnloadMag("PBWP_CinerealMag", "PB_DTech", 1, 1, 100, 0, null); }
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		Goto Ready3;

		FlashPunching:
		TNT1 AAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashKicking:
		TNT1 AAAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashAirKicking:
		TNT1 AAAAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashSlideKicking:
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 1 A_DoPBWeaponAction();
		Stop;
		FlashSlideKickingStop:
		TNT1 AAAAAAA 1 A_DoPBWeaponAction();
		Stop;

		Flash:
		TNT1 A 1;
		Goto LightDone;
	}
}
