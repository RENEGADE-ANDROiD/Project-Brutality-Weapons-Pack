// Amnesia Proton Phaser — Cyberaugumented BFG (folded from DCY_TheBFG9000).

class PBWP_AmnesiaProtonPhaser : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 7;
		Weapon.SlotPriority 0.2;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive1 40;
		Weapon.AmmoUse1 40;
		+WEAPON.BFG;
		Tag "Amnesia Proton Phaser";
		Inventory.PickupMessage "You got the Amnesia Proton Phaser! ...Looks like a BFG-9000.";
		Inventory.PickupSound "BFG10000Proto/UP";
		Weapon.UpSound "BFG10000Proto/UP";
		Inventory.Icon "BIG_U0";
		Obituary "%o was atomized by %k's Amnesia Proton Phaser.";
	}

	action void PBWP_ProtonFire()
	{
		A_QuakeEx(3, 3, 3, 34, 0, 200, "", QF_SCALEDOWN, falloff: 400);
		A_StartSound("DCYBFGX/FIRE", CHAN_6, CHANF_DEFAULT, 0.65, ATTN_IDLE);
		A_StartSound("DCYBFG/Fire", CHAN_WEAPON, CHANF_DEFAULT, 0.8, ATTN_IDLE);
		A_FireCustomMissile("PBWP_CA_BFGSpheroid", 0, 0);
		A_TakeInventory("PB_Cell", 40);
		A_GunFlash();
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		BIG_ U -1;
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
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto SelectAnimation;
	SelectAnimation:
		BFG_ ABCDEFGHI 1 Bright A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		BFG_ A 1 Bright A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 40, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		BFG_ BCD 1 Bright;
		BFG_ E 1 Bright A_StartSound("DCYBFGX/CHARGE", CHAN_6, CHANF_DEFAULT, 0.3, ATTN_IDLE, 1.15);
		BFF_ BCDEFGHI 2 Bright;
		BIG_ A 1 Bright { PBWP_ProtonFire(); }
		BIG_ BCDEFGHIJ 1 Bright;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		TNT1 A 0 A_Refire();
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
		TNT1 A 10 A_Light1();
		TNT1 A 5 A_Light0();
		Goto LightDone;
	}
}
