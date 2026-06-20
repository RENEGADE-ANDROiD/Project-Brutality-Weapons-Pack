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
		Obituary "All of %o's remains were blasted by %k's Liquidation.";
	}

	action void PBWP_LiquidationBeam()
	{
		A_RailAttack(100, 0, 0, "", "", RGF_SILENT | RGF_FULLBRIGHT, pufftype: "PBWP_CA_BFGPuff", sparsity: 64, spawnclass: "PBWP_CA_BFGExtra");
		PBWP_CA_DeferredRailHit(100, 'BFG');
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
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		Goto Ready3;
	SelectAnimation:
		L1QU ABCDEFGHI 1 A_WeaponReady(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		L1QU A 1 { A_StopSound(CHAN_5); A_StopSound(CHAN_WEAPON); A_StopSound(CHAN_7); }
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(39); }
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
		TNT1 A 20 Bright A_StartSound("BFG10000Proto/Charge", CHAN_WEAPON, 0, 0.85);
		TNT1 A 0 Bright
		{
			A_StartSound("BFG10kLaser/Fire", CHAN_6, CHANF_DEFAULT, 0.75);
			A_SetBlend("White", 0.85, 20, "Yellow");
		}
		TNT1 AAAAAAAAAAA 1 Bright { PBWP_LiquidationBeam(); }
		Goto Hold;

		Hold:
		TNT1 A 1 Bright
		{
			PBWP_LiquidationBeam();
			A_StartSound("BFG10kLaser/Hold", CHAN_7, CHANF_LOOPING, 0.75);
		}
		TNT1 A 0 A_Refire("Hold");
		TNT1 A 1 Bright;
		TNT1 A 10 { A_StopSound(CHAN_7); A_StartSound("BFG10kLaser/Stop", CHAN_6, CHANF_DEFAULT, 0.75); }
		L1QU IJKLMNOPQR 1 Bright;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		TNT1 A 0 A_StartSound("BFG10000Proto/Idle", 5, 1, 1);
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
		TNT1 A 1 Bright A_Light1();
		TNT1 A 2 Bright A_Light0();
		Goto LightDone;
	}
}
