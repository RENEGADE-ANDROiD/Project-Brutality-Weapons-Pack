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
		Weapon.AmmoGive2 40;
		+WEAPON.EXPLOSIVE;
		Tag "Caduceus";
		Inventory.PickupMessage "You hold the Caduceus. Not your average plasma rifle.";
		Inventory.PickupSound "dcy/plasmariflepickup";
		Inventory.Icon "NNW3Z0";
		Obituary "%o couldn't surpass %k's Caduceus azure power.";
	}

	action void PBWP_CaduceusFire()
	{
		A_GunFlash();
		if (invoker.weaponmode)
		{
			A_StartSound("NeonicBall/Fire", CHAN_WEAPON);
			A_FireCustomMissile("PBWP_CA_NeonicBall", 0, 0);
			A_TakeInventory("PBWP_CaduceusMag", 4);
		}
		else
		{
			A_StartSound("Lazer/Fire", CHAN_WEAPON);
			A_RailAttack(75, 0, 0, flags: RGF_FULLBRIGHT, pufftype: "PBWP_CA_BFGPuff", sparsity: 30);
			PBWP_CA_DeferredRailHit(75, 'Plasma');
			A_TakeInventory("PBWP_CaduceusMag", 1);
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
		C_AD XYZ 1 Bright A_WeaponReady(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		C_AD A 1 Bright A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		Reload:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 PB_CheckReload(null, "DoReload", null, "Ready3", "Ready3", 60, 1);
		Goto Ready3;
	DoReload:
		TNT1 A 10 { PB_AmmoIntoMag("PBWP_CaduceusMag", "PB_Cell", 60, 1, 1); }
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
		C_AD B 1 Bright;
		C_AD C 1 Bright { PBWP_CaduceusFire(); }
		C_AD D 1 Bright;
		C_AD E 1 Bright A_Refire("Fire");
		Goto Ready3;

		Weaponspecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0
		{
			A_StartSound("NeonicWand/Switch", CHAN_WEAPON);
			invoker.weaponmode = !invoker.weaponmode;
		}
		C_AD BCD 2 Bright;
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
		TNT1 A 2 A_Light1();
		TNT1 A 1 A_Light0();
		Goto LightDone;
	}
}
