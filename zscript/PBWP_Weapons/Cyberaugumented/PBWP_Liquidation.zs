// Liquidation — Cyberaugumented aurum laser BFG (folded from DCY_TheBFG10000).

class PBWP_Liquidation : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 7;
		Weapon.SlotPriority 0.22;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive1 40;
		Weapon.AmmoUse1 1;
		+WEAPON.BFG;
		+WEAPON.NOAUTOFIRE;
		+WEAPON.NOAUTOAIM;
		Tag "Liquidation";
		Inventory.PickupMessage "Acquired the Liquidation! It liquidates everything.";
		Inventory.PickupSound "BFG10000Proto/UP";
		Weapon.UpSound "BFG10000Proto/UP";
		Inventory.Icon "BFG2Z0";
		Inventory.AltHudIcon "BFG2Z0";
		Obituary "All of %o's remains were blasted by %k's Liquidation.";
	}

	action void PBWP_LiquidationBeam()
	{
		PBWP_CA_FireAurumRail(100, 64);
		A_TakeInventory("PB_Cell", 1);
		A_GunFlash();
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		BFG2 Z -1;
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
		TNT1 A 0 PB_WeaponRaise("BFG10000Proto/UP");
		TNT1 A 0 PB_WeapTokenSwitch("BFGSelected");
		TNT1 A 0 A_PlaySound("BFG10000Proto/Idle", 5, 1, 1);
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto Ready3;
	SelectAnimation:
		L1QU ABCDEFGHI 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		L1QU A 1 { A_StopSound(CHAN_5); A_StopSound(CHAN_WEAPON); A_StopSound(CHAN_7); }
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		L1QU A 1 Bright A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 1, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		L1QU A 2 Bright A_StopSound(CHAN_5);
		TNT1 A 0 A_StartSound("BFG10000Proto/Charge", CHAN_WEAPON, 0, 0.85);
		L1QU AAAABBBB 1 Bright;
		L1QU CCCCDDDD 1 Bright;
		L1QU EEEEFFFGGGHHH 1 Bright;
		TNT1 A 0 Bright
		{
			A_QuakeEx(5, 5, 5, 12, 0, 300, "", QF_RELATIVE | QF_SCALEDOWN, rollintensity: 2.0, rollwave: 2.0);
			A_WeaponOffset(0, 32, WOF_INTERPOLATE);
			A_StartSound("BFG10kLaser/Fire", CHAN_6, CHANF_DEFAULT, 0.75);
			A_SetBlend("White", 0.85, 20, "Yellow");
		}
		L1QU IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII 1 Bright { PBWP_LiquidationBeam(); }
		Goto Hold;

		Hold:
		L1QU I 1 Bright
		{
			PBWP_LiquidationBeam();
			A_StartSound("BFG10kLaser/Hold", CHAN_7, CHANF_LOOPING, 0.75);
		}
		TNT1 A 0 A_Refire("Hold");
		TNT1 A 1 Bright;
		TNT1 A 10 { A_StopSound(CHAN_7); A_StartSound("BFG10kLaser/Stop", CHAN_6, CHANF_DEFAULT, 0.75); }
		L1QU IJ 2 Bright;
		L1QU KKKKKKKKKK 1 Bright;
		L1QU LLLMMMNNNOOOPPPQQQRRR 1 Bright;
		L1QU A 5 Bright A_WeaponOffset(0, 32, WOF_INTERPOLATE);
		TNT1 A 0 PBWP_CA_UnlockTilt();
		TNT1 A 0 A_StartSound("BFG10000Proto/Idle", 5, 1, 1);
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		Goto Ready3;

		Reload:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 { return ResolveState("PBWP_OffsetReloadAnim"); }
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
		TNT1 A 1 Bright A_Light1();
		TNT1 A 2 Bright A_Light0();
		Goto LightDone;
	}
}
