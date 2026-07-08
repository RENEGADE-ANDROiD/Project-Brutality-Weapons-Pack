// Intervention — Cyberaugumented grenade launcher (folded from DCY_Grenades).

class PBWP_Intervention : PBWP_CA_WeaponBase
{
	default
	{
		Weapon.SlotNumber 6;
		Weapon.SlotPriority 0.11;
		Weapon.AmmoType1 "PB_RocketAmmo";
		Weapon.AmmoGive1 2;
		Weapon.AmmoUse1 1;
		+WEAPON.NOAUTOFIRE;
		+WEAPON.EXPLOSIVE;
		Tag "Intervention Y0";
		Inventory.PickupMessage "You got the Intervention! Demons won't know what hit them.";
		Inventory.PickupSound "dcy/rocketpickup";
		Inventory.Icon "G3RNZ0";
		Inventory.AltHudIcon "G3RNZ0";
		Obituary "%o was blasted by %k's Intervention.";
	}

	states
	{
	Spawn:
		G3RN Z -1;
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
		TNT1 A 0 PB_WeaponRaise("dcy/rocketpickup");
		TNT1 A 0 PB_WeapTokenSwitch("RLSelected");
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto SelectAnimation;
	SelectAnimation:
		GNN_ WXY 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		GNN_ A 1 A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_RocketAmmo", 1, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		GNN_ A 2;
		GNN_ B 2 Bright;
		GNN_ C 2 Bright
		{
			A_StartSound("Grenade/Launch", CHAN_WEAPON, 0, 0.85);
			if (CountInv("InterventionMicroYield") >= 1)
				A_FireCustomMissile("PBWP_CA_MicroYieldGrenade", 0, 0, 0, 0, 0, 0);
			else
				A_FireCustomMissile("PBWP_CA_Grenade", 0, 0, 0, 0, 0, 0);
			A_TakeInventory("PB_RocketAmmo", 1);
			A_GunFlash();
			PB_GunSmoke_Launcher(0, 0, 0);
			A_AlertMonsters();
			PB_QuakeCamera(25, 0.4);
		}
		GNN_ D 2 Bright;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		TNT1 A 0 A_Refire();
		Goto Ready3;

		AltFire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_RocketAmmo", 1, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		GNN_ A 2;
		GNN_ B 2 Bright;
		GNN_ C 2 Bright
		{
			A_StartSound("Grenade/Launch", CHAN_WEAPON, 0, 0.85);
			A_FireCustomMissile("PBWP_CA_NapalmGrenade", 0, 0, 0, 0, 0, 0);
			A_TakeInventory("PB_RocketAmmo", 1);
			A_GunFlash();
			PB_GunSmoke_Launcher(0, 0, 0);
			A_AlertMonsters();
			PB_QuakeCamera(25, 0.4);
		}
		GNN_ D 2 Bright;
		TNT1 A 0 PBWP_CA_UnlockTilt();
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0 A_JumpIfInventory("InterventionMicroYield", 1, "InterventionYieldOff");
		TNT1 A 0 A_GiveInventory("InterventionMicroYield", 1);
		TNT1 A 0 A_StartSound("LIGHTON", CHAN_AUTO);
		TNT1 A 0 A_Print("Payload: Micro-Yield");
		Goto Ready3;
	InterventionYieldOff:
		TNT1 A 0 A_TakeInventory("InterventionMicroYield", 1);
		TNT1 A 0 A_StartSound("LIGHTON", CHAN_AUTO);
		TNT1 A 0 A_Print("Payload: Standard");
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
		TNT1 A 3 Bright A_Light1();
		TNT1 B 2 Bright;
		TNT1 CD 3 Bright A_Light0();
		Goto LightDone;
	}
}
