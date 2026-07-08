// Fire & Ice Dragon Slayer — ZScript port (Craneo / PBWP).
// Tap fire: forward SLAY swing. Hold + release: lock-on lunge + reverse SLBY swing.

class PB_FireAndIceDragonSlayerBase : PB_WeaponBase
{
	int holdCharge;

	default
	{
		Weapon.Kickback 800;
		Scale 0.8;
		Inventory.PickupSound "Weapons/Slayerpickup";
		Inventory.AltHUDIcon "DSLCP0";
		FloatBobStrength 0.5;
		DamageType "Gutsdamage";
		Inventory.PickupMessage "You got the Fire and Ice Dragon Slayer!";
		Tag "Fire and Ice Dragon Slayer";
		Obituary "%o was obliterated by %k's Dragon Slayer.";
		+WEAPON.AMMO_OPTIONAL;
		+WEAPON.NOAUTOAIM;
		+WEAPON.NOAUTOFIRE;
		+FORCEXYBILLBOARD;
		+WEAPON.NOALERT;
		+WEAPON.MELEEWEAPON;
		+WEAPON.AXEBLOOD;
		+DONTGIB;
		Weapon.SlotNumber 5;
		Weapon.SlotPriority 5.4;
		Weapon.AmmoType "DragonSlayerEnergy";
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 15;
		Weapon.AmmoType2 "PB_NailgunAmmo";
		Weapon.AmmoGive2 90;
		Weapon.AmmoUse2 1;
	}

	action void PBWP_DS_ResetHold()
	{
		invoker.holdCharge = 0;
	}

	action state PBWP_DS_HoldLoop()
	{
		invoker.holdCharge++;
		A_BDPMeleeStart(200);

		if (invoker.holdCharge >= 20)
			A_WeaponOffset(Random(-1, 1), 32 + Random(-1, 1));

		if (PressingFire() || IsHoldingInput(BT_ATTACK))
			return ResolveState("Hold");

		if (invoker.holdCharge >= 6 && CountInv("DragonSlayerEnergy") >= 3)
			return ResolveState("HoldRelease");

		return ResolveState("TapSwingForward");
	}

	action void PBWP_DS_ForwardSwingFX(bool enhanced)
	{
		A_PlaySound("Weapons/Slayerswing", CHAN_WEAPON);
		A_CustomPunch(50, 0, 0, "SlayerPuff", 256);
		A_Quake(3, 10, 0, 10);
		A_RailAttack(50, 64, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_RailAttack(50, 10, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		if (enhanced)
		{
			A_FireCustomMissile("RealFlameTrailsSmall", 0, 0, 1, 0, 0);
			A_RailAttack(50, 24, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
			A_RailAttack(50, 2, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
			A_FireCustomMissile("DragonFire", 0, 0, 1, 0, 0);
			A_RailAttack(50, 24, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
			A_FireCustomMissile("SmallBlueFlameTrails", 0, 0, 1, 0, 0);
			A_RailAttack(50, 2, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
			A_FireCustomMissile("IceMissile", 0, 0, 1, 0, 0);
			A_RailAttack(50, 24, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
			A_RailAttack(50, 2, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		}
		else
		{
			A_FireCustomMissile("FastSmallFlameTrails", random(-2, 2), 0, 0, random(0, -1));
			A_RailAttack(50, 24, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
			A_RailAttack(50, 2, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		}
	}

	action void PBWP_DS_ReverseSwingFX()
	{
		A_PlaySound("Weapons/Slayerswing", CHAN_WEAPON);
		A_FireProjectile("FireballBlocker", 0, 0, 0, -7, 0);
		A_CustomPunch(50, 0, 0, "SlayerPuff", 256);
		A_FireCustomMissile("FireballBlocker", 0, 0, 0, 0);
		A_RailAttack(50, 64, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_RailAttack(50, 10, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_FireCustomMissile("FastSmallFlameTrails", random(-2, 2), 0, 0, random(0, -1));
		A_RailAttack(50, 24, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_RailAttack(50, 2, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_FireCustomMissile("RealFlameTrailsBlue", random(-2, 2), 0, 0, random(0, -1));
		A_RailAttack(50, -8, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_RailAttack(50, 0, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_FireCustomMissile("IceDust", random(-2, 2), 0, 0, random(0, -1));
		A_RailAttack(50, -32, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
		A_RailAttack(50, -64, 0, "", "", RGF_SILENT, 0, "SlayerPuff2", 0, 0, 256);
	}

	states
	{
	Spawn:
		SLAR A 0;
		SLAR AAAAAAAAAA 0 A_SpawnItemEx("Gibs", random(-64, 64), random(-64, 64));
		SLAR AAAAAA 0 A_SpawnItemEx("CrueltyBonus5health", 0, 0, 0, frandom(-3, 3), frandom(-3, 3), frandom(5, 15), random(0, 360), SXF_NOCHECKPOSITION);
		SLAR A 1;
		SLAR A -1;
		Stop;

	Steady:
		TNT1 A 0 A_SetRoll(0);
		TNT1 A 1 {
			A_TakeInventory("GoWeaponSpecialAbility", 1);
			A_TakeInventory("Grabbing_A_Ledge", 1);
			A_TakeInventory("UseEquipment", 1);
			A_TakeInventory("ToggleEquipment", 1);
			A_TakeInventory("Taunting", 1);
			A_TakeInventory("Salute1", 1);
			A_TakeInventory("Salute2", 1);
			A_TakeInventory("Kicking", 1);
		}
		Goto Ready;

	WeaponSpecial:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 A_TakeInventory("Punching", 1);
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		PUNS E 2;
		PUNS F 2 { A_PlaySound("KNUCKLED", CHAN_AUTO); }
		PUNS GFEK 2;
		PUNS L 2 { A_PlaySound("KNUCKLED", CHAN_AUTO); }
		PUNS MLK 2;
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		Goto Ready3;

	Ready:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		Goto Ready3;

	Ready3:
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			PB_HandleCrosshair(90);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		SLAY A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

	Select:
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			PB_HandleCrosshair(90);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		Goto SelectFirstPersonLegs;

	SelectContinue:
		TNT1 A 0 PB_WeaponRaise("AXEDRAW");
		TNT1 A 0 PB_WeapTokenSwitch("AddonSelected");
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		Goto SelectAnimation;

	SelectAnimation:
		SLAY A 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Goto Ready3;

	Deselect:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			PB_HandleCrosshair(90);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_Lower(120);
		Wait;

		Fire:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 { return PB_FireExecuteCheck(); }
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			A_SetCrosshair(90);
		}
		TNT1 A 0 PBWP_DS_ResetHold();
		SLAY D 1 Offset(-33, 33);
		SLAY D 1 Offset(-32, 32);
		SLAY D 1 A_BDPMeleeStart(200);
		Goto Hold;

		Hold:
		SLAY B 1 Offset(-33, 33);
		SLAY B 1 Offset(-32, 32);
		SLAY E 1;
		TNT1 A 0 { return PBWP_DS_HoldLoop(); }

		TapSwingForward:
		SLAY D 1 Offset(-33, 33);
		SLAY D 1 Offset(-32, 32);
		SLAY E 1 Offset(-33, 33);
		SLAY E 1 Offset(-32, 32);
		SLAY F 1;
		TNT1 A 0 A_JumpIfInventory("DragonSlayerEnergy", 5, "TapSwingEnhanced");
		Goto TapSwingBasic;

		TapSwingEnhanced:
		TNT1 A 0 A_TakeInventory("DragonSlayerEnergy", 5);
		SLAY G 1 { PBWP_DS_ForwardSwingFX(true); }
		SLAY H 1;
		SLAY I 1;
		SLAY J 1;
		SLAY K 1;
		SLAY L 1;
		TNT1 A 3;
		SLAY MN 2;
		TNT1 A 0 A_GiveInventory("DragonSlayerEnergy", 3);
		Goto Ready3;

		TapSwingBasic:
		SLAY G 1 { PBWP_DS_ForwardSwingFX(false); }
		SLAY H 1;
		SLAY I 1;
		SLAY J 1;
		SLAY K 1;
		SLAY L 1;
		TNT1 A 3;
		SLAY MN 2;
		Goto Ready3;

		HoldRelease:
		TNT1 A 0 A_TakeInventory("DragonSlayerEnergy", 3);
		SLAY E 1 Bright;
		TNT1 A 0 A_BDPMelee(200, "NULL", -7, true);
		TNT1 A 0 A_PlaySound("GRENEXPL", CHAN_AUTO);
		TNT1 A 0 {
			A_Quake(3, 10, 0, 10);
			A_FireCustomMissile("DSAttack", 1, 1, 1, 1, 1);
			A_FireCustomMissile("DSAttack2", 1, 1, 1, 1, 1);
			A_FireCustomMissile("DSAttack3", 1, 1, 1, 1, 1);
			A_FireCustomMissile("DSAttack4", 1, 1, 1, 1, 1);
			A_SpawnItemEx("DragonSlayerLungeImpact", 64, 0, 28, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
		}
		SLAY C 1 Offset(-50, 33);
		SLAY C 1 Offset(-120, 36);
		SLAY C 1 Offset(-260, 40);
		SLAY C 1 Offset(-320, 49);
		SLAY C 1 Offset(-490, 59);
		SLAY C 1 Offset(-620, 72);
		Goto ReverseSwing;

		ReverseSwing:
		SLBY D 1 Offset(-33, 33);
		SLBY D 1 Offset(-32, 32);
		SLBY E 1 Offset(-33, 33);
		SLBY E 1 Offset(-32, 32);
		SLBY F 1 { PBWP_DS_ReverseSwingFX(); }
		SLBY G 1;
		SLBY H 1;
		SLBY I 1;
		SLBY J 1;
		SLBY K 1;
		SLBY L 1;
		TNT1 A 3;
		SLBY MN 2;
		Goto Ready3;

		AltFire:
		TNT1 A 0 A_JumpIfInventory("PB_NailgunAmmo", 1, "HasNailgunAmmo");
		TNT1 A 0 A_PlaySound("weapons/dryfire", CHAN_WEAPON);
		TNT1 A 10;
		Goto Ready3;

	HasNailgunAmmo:
		SLY3 ABCD 2;
		SLY2 A 2;
		SLY2 B 2 A_PlaySound("Weapons/nailgun/fireloop");
		SLY2 C 2 {
			A_TakeInventory("PB_NailgunAmmo", 1);
			A_FireCustomMissile("PB_JavelinProjectile_Hot", 0, 1, -2);
		}
		SLY2 C 2 A_FireCustomMissile("Sparks", random(-4, 4), 0, 0, random(0, -1));
		SLY2 B 2 A_PlaySound("Weapons/NailFlight");
		SLY2 DA 3;
		SLY2 A 3 { return A_Refire("AltRefire"); }
		SLY3 DCBA 1;
		Goto Ready3;

	AltRefire:
		TNT1 A 0 A_JumpIfInventory("PB_NailgunAmmo", 1, "HasNailgunAmmoRefire");
		TNT1 A 0 A_PlaySound("weapons/dryfire", CHAN_WEAPON);
		TNT1 A 10;
		Goto Ready3;

	HasNailgunAmmoRefire:
		SLY2 A 2;
		SLY2 B 2 A_PlaySound("Weapons/nailgun/fireloop");
		SLY2 C 2 {
			A_TakeInventory("PB_NailgunAmmo", 1);
			A_FireCustomMissile("PB_MGNail", 0, 1, -2);
		}
		SLY2 B 2 A_PlaySound("Weapons/NailFlight");
		SLY2 DA 3 {
			PB_GunSmoke(0, -3, 0);
			PB_GunSmoke(0, -3, 0);
			PB_GunSmoke(0, -3, 0);
		}
		SLY2 A 2 { return A_Refire("AltRefire"); }
		SLY3 DCBA 1;
		Goto Ready3;

	FlashKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_ClearOverlays(10, 11);
		SLAY A 1 A_DoPBWeaponAction;
		SLAY B 4;
		SLAY C 4;
		Goto Ready;

	FlashAirKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_ClearOverlays(10, 11);
		SLAY A 1 A_DoPBWeaponAction;
		SLAY B 4;
		SLAY C 4;
		Goto Ready;

	FlashSlideKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_ClearOverlays(10, 11);
		SLAY A 1 A_DoPBWeaponAction;
		SLAY B 1;
		SLAY B 35;
		Goto Ready;

	FlashSlideKickingStop:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_ClearOverlays(10, 11);
		SLAY C 1 A_DoPBWeaponAction;
		SLAY C 5;
		Goto Ready;

	FlashPunching:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10, 11);
		TNT1 A 15;
		Stop;

	FlashPunchingDualWield:
		TNT1 A 15;
		Stop;

	FlashKickingDualWield:
		P3R0 ABCDEF 1;
		P3R0 F 2 A_WeaponOffset(0, 36);
		P3R0 FEDCBA 1 A_WeaponOffset(0, 32);
		Stop;

	FlashAirKickingDualWield:
		P3R0 ABCDEF 1;
		P3R0 F 4 A_WeaponOffset(0, 36);
		P3R0 FEDCBA 1 A_WeaponOffset(0, 32);
		Stop;

	FlashSlideKickingDualWield:
		P3R0 ABCDEF 1;
		P3R0 F 1 A_WeaponOffset(0, 34);
		P3R0 GHIIJJ 1;
		P3R0 KKLLM 1;
		P3R0 FF 1 A_WeaponOffset(0, 32);
		P3R0 EDCBA 1 A_WeaponOffset(0, 32);
		Stop;

	FlashSlideKickingStopDualWield:
		P3R0 FF 1 A_WeaponOffset(0, 32);
		P3R0 EDCBA 1 A_WeaponOffset(0, 32);
		Stop;
	}
}
