// Caduceus — Cyberaugumented neonic wand (folded from DCY_NeonicWand).

class PBWP_Caduceus : PBWP_CA_WeaponBase
{
	int weaponmode;

	default
	{
		Weapon.SlotNumber 6;
		Weapon.SlotPriority 0.16;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoType2 "PBWP_CaduceusMag";
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 60;
		+WEAPON.EXPLOSIVE;
		Tag "Caduceus";
		Inventory.PickupMessage "You hold the Caduceus. Not your average plasma rifle.";
		Inventory.PickupSound "dcy/plasmariflepickup";
		Inventory.Icon "NNW3Z0";
		Inventory.AltHudIcon "NNW3Z0";
		Obituary "%o couldn't surpass %k's Caduceus azure power.";
	}

	action void PBWP_CaduceusFire()
	{
		A_GunFlash();
		if (invoker.weaponmode)
		{
			A_StartSound("NeonicBall/Fire", CHAN_WEAPON);
			A_FireCustomMissile("PBWP_CA_CaduceusOrb", 0, 0);
			PB_TakeAmmo("PBWP_CaduceusMag", 4, 0, 0);
		}
		else
		{
			A_StartSound("Lazer/Fire", CHAN_WEAPON);
			PBWP_CA_FireCaduceusRail(75);
			PB_TakeAmmo("PBWP_CaduceusMag", 1, 0, 0);
		}
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		NNW3 Z -1;
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
		TNT1 A 0 PB_WeaponRaise("dcy/plasmariflepickup");
		TNT1 A 0 PB_WeapTokenSwitch("PlasmagunSelected");
		TNT1 A 0 PB_SetMagUnloaded(false);
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto Ready3;
	SelectAnimation:
		C_AD XYZ 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		C_AD A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		Reload:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 PBWP_CA_ReloadPreamble();
		TNT1 A 0 A_JumpIfInventory("PBWP_CaduceusMag", 60, "Ready3");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 1, "DoReload");
		Goto Ready3;
	DoReload:
		C_AD G 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_PlaySound("CELLOUT2", CHAN_AUTO);
		C_AD H 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 { return PB_JumpIfMagUnloaded("CaduceusMagIn"); }
		TNT1 A 0 A_FireCustomMissile("PlasmaCaseSpawn", -5, 0, 8, -4);
		C_AD IJ 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_PlaySound("CELLIN2", CHAN_AUTO);
		C_AD KLM 2 A_DoPBWeaponAction(WRF_NOFIRE);
		CaduceusMagIn:
		TNT1 A 0
		{
			PB_AmmoIntoMag("PBWP_CaduceusMag", "PB_Cell", 60, 1, 1);
			PB_SetChamberEmpty(false);
			PB_SetMagEmpty(false);
			PB_SetMagUnloaded(false);
		}
		C_AD A 2 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		Goto Ready3;

		Unload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 { PB_SetMagUnloaded(true); PB_UnloadMag("PBWP_CaduceusMag", "PB_Cell", 1, 1, 60, 0, null); }
		Goto Ready3;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0
		{
			int need = invoker.weaponmode ? 4 : 1;
			if (CountInv("PBWP_CaduceusMag") >= need)
				return ResolveState(null);
			return ResolveState("Reload");
		}
		C_AD BCD 1 A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY | WRF_NOSWITCH | WRF_NOBOB);
		Goto FireHold;

	FireHold:
		C_AD E 1
		{
			PBWP_CaduceusFire();
			A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY | WRF_NOSWITCH | WRF_NOBOB);
		}
		C_AD FGHI 1 A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY | WRF_NOSWITCH | WRF_NOBOB);
		C_AD I 0
		{
			if (!invoker.weaponmode)
				return A_Refire("FireHold");
		}
		C_AD I 0 A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB);
		C_AD JKLAA 2 A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB);
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0
		{
			A_StartSound("NeonicWand/Switch", CHAN_WEAPON);
			invoker.weaponmode = !invoker.weaponmode;
		}
		C_AD BCD 2;
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
		TNT1 A 1 A_Light0();
		Goto LightDone;
	}
}
