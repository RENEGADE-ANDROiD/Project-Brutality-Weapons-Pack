// Sirius Crisis Roscoe — Cyberaugumented Renegade Cannon BFG (folded from DCY_SiriusCrisis).

class PBWP_SiriusCrisis : PBWP_CA_WeaponBase
{
	double chargeMeter;
	double shakeMeter;

	default
	{
		Weapon.SlotNumber 7;
		Weapon.SlotPriority 0.24;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive1 45;
		Weapon.AmmoUse1 5;
		Weapon.Kickback 150;
		+WEAPON.BFG;
		+WEAPON.NOAUTOFIRE;
		+WEAPON.NOAUTOAIM;
		Tag "Sirius Crisis Roscoe";
		Inventory.PickupMessage "Your hands handle the great Sirius Crisis Roscoe.";
		Inventory.PickupSound "SiriusBFG/Pickup";
		Weapon.UpSound "SiriusBFG/Up";
		Inventory.Icon "S1R_Z0";
		Inventory.AltHudIcon "S1R_Z0";
		Obituary "%o could not handle the power of %k's Sirius Crisis Roscoe.";
	}

	action void PBWP_SiriusBlast()
	{
		A_SetBlend("Cyan", 0.5, 20, "Blue");
		A_GunFlash();
		A_StartSound("SiriusBFG/Fire", CHAN_WEAPON, CHANF_DEFAULT, 1.0, 0.5);
		A_FireCustomMissile("PBWP_CA_SiriusBFGBall", 0, 0);
		A_TakeInventory("PB_Cell", 45);
		A_QuakeEx(4, 4, 4, 40, 0, 600, "none", QF_RELATIVE | QF_SCALEDOWN);
		A_QuakeEx(2, 2, 2, 50, 0, 600, "none", QF_RELATIVE | QF_SCALEDOWN);
		A_QuakeEx(1, 1, 1, 60, 0, 600, "none", QF_RELATIVE | QF_SCALEDOWN);
		PB_QuakeCamera(40, 0.8);
		A_AlertMonsters();
	}

	action void PBWP_SiriusLaser()
	{
		A_SetBlend("Cyan", 0.5, 10 + int(invoker.chargeMeter / 5), "Blue");
		A_GunFlash();
		if (invoker.chargeMeter > 0)
			A_FireCustomMissile("PBWP_CA_SiriusLaser", 0, 0);
		A_TakeInventory("PB_Cell", 5);
		A_StartSound("Eradicator/Laser", CHAN_WEAPON, CHANF_DEFAULT, 1.0, 0.5,
			1.253 - (invoker.chargeMeter / 23));
		A_AlertMonsters();
	}

	states
	{
	Spawn:
		S1R_ Z -1;
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
		TNT1 A 0 PB_WeaponRaise("SiriusBFG/Up");
		TNT1 A 0 PB_WeapTokenSwitch("BFGSelected");
		TNT1 A 0 PBWP_CA_SelectPose();
		Goto SelectAnimation;
	SelectAnimation:
		SRB0 ABCB 1 Bright A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 PBWP_CA_DeselectCleanup();
		SRB0 A 1 Bright { A_StopSound(CHAN_WEAPON); A_StopSound(CHAN_BODY); }
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 { PBWP_CA_ReadyPose(); }
		SRB0 ABCB 1 Bright A_DoPBWeaponAction();
		Loop;

		Fire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 5, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		SRB0 A 10 Bright
		{
			A_StopSound(CHAN_WEAPON);
			invoker.chargeMeter = 0;
			A_StartSound("MECHGRAB", CHAN_AUTO);
		}
		Goto FHold;

		FHold:
		SRB0 C 1 Bright
		{
			A_WeaponOffset(frandom(-1.0, 1.0) * (invoker.chargeMeter / 15),
				32 + (frandom(-1.0, 1.0) * (invoker.chargeMeter / 15)), WOF_INTERPOLATE);
			A_RailAttack(0, 0, 0, "Cyan", "Cyan",
				RGF_FULLBRIGHT | RGF_SILENT | RGF_NOPIERCING | RGF_NORANDOMPUFFZ, frandom(-5, 5),
				duration: 20, sparsity: 5, driftspeed: frandom(-2, 2),
				spawnclass: "PBWP_CA_SiriusTrack");
			A_StartSound("DIVLOOP", CHAN_WEAPON, CHANF_LOOPING);
			if (invoker.chargeMeter < 20)
				invoker.chargeMeter += 0.1;
		}
		TNT1 A 0 A_JumpIf(!PressingFire(), "HoldEnd");
		TNT1 A 0 { if (invoker.chargeMeter < 20) A_Refire("FHold"); }
		Goto HoldEnd;

		HoldEnd:
		SRB0 E 0 { A_StopSound(CHAN_WEAPON); }
		SRB0 EF 1 A_DoPBWeaponAction(WRF_NOFIRE);
		SRB0 G 2 Bright
		{
			PBWP_SiriusLaser();
			invoker.chargeMeter = 0;
			PBWP_CA_UnlockTilt();
		}
		SRB0 HIJKL 2 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		SRB0 MNO 2 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		SRB0 AAAAABBBCCBB 1 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		Goto Ready3;

		AltFire:
		TNT1 A 0 PBWP_CA_FatalityGate();
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 45, 2);
		Goto Ready3;
		TNT1 A 0 PBWP_CA_LockTilt();
		SRB0 A 1 Bright
		{
			A_StopSound(CHAN_WEAPON);
			invoker.shakeMeter = 0;
			A_QuakeEx(3, 3, 3, 45, 0, 500, "none", QF_RELATIVE | QF_SCALEUP);
			A_StartSound("SiriusBFG/Charge", CHAN_WEAPON, CHANF_DEFAULT, 1.0, 0.645);
		}
		SRB0 BCBABCBABCBABCBABCDEF 1 Bright
		{
			A_WeaponOffset(frandom(-2.0, 2.0) * invoker.shakeMeter,
				32 + frandom(-2.0, 2.0) * invoker.shakeMeter, WOF_INTERPOLATE);
			invoker.shakeMeter += 0.35;
		}
		SRB0 G 3 Bright
		{
			A_WeaponOffset(0, 32, WOF_INTERPOLATE);
			PBWP_SiriusBlast();
			PBWP_CA_UnlockTilt();
		}
		SRB0 HIJKL 3 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		SRB0 MNO 3 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
		SRB0 AAAAABBBCCBB 1 Bright A_DoPBWeaponAction(WRF_NOPRIMARY | WRF_NOSECONDARY);
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
		TNT1 A 0;
		TNT1 A 3 A_Light1();
		TNT1 A 5 A_Light2();
		TNT1 A 4 A_Light0();
		Goto LightDone;
	}
}
