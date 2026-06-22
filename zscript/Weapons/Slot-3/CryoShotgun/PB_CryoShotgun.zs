// PB_CryoShotgun — PB Weapons Pack cryo shotgun + consolidated CatsFrozen fire modes.

class PB_CryoShotgun : PB_WeaponBase
{
	default
	{
		Weapon.BobRangeX 0.3;
		Weapon.BobRangeY 0.5;
		Weapon.BobStyle "InverseSmooth";
		Weapon.BobSpeed 2.0;
		Weapon.Kickback 100;
		Weapon.AmmoUse1 0;
		Weapon.AmmoGive1 36;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoType2 "CryoShotgunAmmo";
		Weapon.AmmoUse2 0;
		Weapon.AmmoGive2 0;
		Weapon.SlotNumber 3;
		Weapon.SlotPriority 1;
		Weapon.SelectionOrder 300;
		+WEAPON.NOALERT;
		+WEAPON.NOAUTOAIM;
		+WEAPON.NOAUTOFIRE;
		+DONTGIB;
		Scale 0.9;
		Inventory.PickupSound "weapons/golide/select";
		Inventory.PickupMessage "You got the Cryo Shotgun!";
		Inventory.Icon "FZSGA0";
		Inventory.AltHUDIcon "FZSGA0";
		Obituary "%o got frozen to death by %k's Cryo Shotgun.";
		Tag "TeiTenga C-2-1 Cryo Shotgun";
		PB_WeaponBase.RespectItem "CryoShotgunUp";
		PB_WeaponBase.WheelInfo "PB_CryoShotgunWheel";
		FloatBobStrength 0.5;
	}
	states
	{
		Spawn:
		"FZSG" A -1;
		Stop;

		Steady:
		TNT1 A 1;
		Goto Ready;

		Ready:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_RespectIfNeeded;
	WeaponRespect:
		TNT1 A 0 {
			A_GiveInventory("CryoShotgunUp", 1);
			A_GiveInventory("CryoShotgunAmmo", 120);
			A_GiveInventory("PB_LockScreenTilt", 1);
			A_PlaySound("weapons/golide/select", CHAN_AUTO);
		}
		"FZGS" ABCDE 1 {
			A_SetRoll(roll + 1.5, SPF_INTERPOLATE);
			return A_DoPBWeaponAction();
		}
		Goto Ready3;

		SelectAnimation:
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_PlaySound("weapons/golide/select", CHAN_AUTO);
		"FZGS" ABCDE 1 A_DoPBWeaponAction;
		Goto Ready3;

		Ready3:
		CryoShotgunReadyToFire:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_JumpIfInventory("GoWeaponSpecialAbility", 1, "WeaponSpecial");
		TNT1 A 0 A_JumpIfInventory("Reloading", 1, "Reload");
		TNT1 A 0 A_JumpIfInventory("Zoomed", 1, "ReadyZoom");
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			PB_HandleCrosshair(39);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		"FZGA" A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		ReadyZoom:
		TNT1 A 0 A_JumpIfInventory("GoWeaponSpecialAbility", 1, "WeaponSpecial");
		TNT1 A 0 A_JumpIfInventory("Reloading", 1, "Reload");
		"FZGA" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		Select:
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			PB_HandleCrosshair(98);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_TakeInventory("HasBarrel", 1);
		TNT1 A 0 A_TakeInventory("HasIceBarrel", 1);
		TNT1 A 0 A_TakeInventory("HasBurningBarrel", 1);
		TNT1 A 0 A_TakeInventory("GrabbedBarrel", 1);
		TNT1 A 0 A_TakeInventory("GrabbedIceBarrel", 1);
		TNT1 A 0 A_TakeInventory("GrabbedBurningBarrel", 1);
		Goto SelectFirstPersonLegs;

		SelectContinue:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_WeapTokenSwitch("ASGSelected");
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Buck", 1, "SelectAnimation");
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Pellet", 1, "SelectAnimation");
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Orb", 1, "SelectAnimation");
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Electric", 1, "SelectAnimation");
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Wind", 1, "SelectAnimation");
		TNT1 A 0 A_GiveInventory("PB_CryoShotgun_Buck", 1);
			TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
			Goto Ready3;

		Fire:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 { return PB_FireExecuteCheck(); }
		TNT1 A 0 {
			if (CountInv("PB_CryoShotgun_Pellet") >= 1) return ResolveState("FirePellet");
			if (CountInv("PB_CryoShotgun_Orb") >= 1) return ResolveState("FireOrb");
			if (CountInv("PB_CryoShotgun_Electric") >= 1) return ResolveState("FireElectric");
			if (CountInv("PB_CryoShotgun_Wind") >= 1) return ResolveState("FireWind");
			return ResolveState(null);
		}
		TNT1 A 0 A_JumpIfInventory("ReloadingCryoShotty", 2, "ReloadDone2");
		TNT1 A 0 A_JumpIfInventory("ReloadingCryoShotty", 1, "ReloadDone1");
		TNT1 A 0 A_JumpIfInventory("CryoShotgunAmmo", 1, 3);
		Goto Reload;
		TNT1 A 0 A_FireCustomMissile("SmokeSpawner", 0, 0, 0, 0);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("weapons/sg", CHAN_WEAPON);
		TNT1 A 0 A_PlaySound("weapons/CryoRifle/missile", CHAN_WEAPON);
		TNT1 A 0 A_SpawnItemEx("PlayerMuzzle1", 30, 5, 30);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAss", 0, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("CryoShotgunAmmo", 12);
		TNT1 A 0 A_JumpIfInventory("Zoomed", 1, "FireZoom");
		"FZGF" A 1 Bright A_GiveInventory("HasFreezerWeapon", 1);
		TNT1 AAAAA 0 A_FireCustomMissile("IceFlak1", frandom(-1.5, 1.5), 0, 0, 0, 0, frandom(-1.5, 1.5));
		TNT1 A 0 A_SetPitch(-7.0 + pitch);
		"FZGF" B 1 Bright A_SetPitch(1.65 + pitch);
		"FZGF" CEF 1 A_SetPitch(1.65 + pitch);
		"FZGA" A 4;
		"FZGP" AB 1;
		"FZGR" ABCDE 1;
		"FZGR" F 1 A_PlaySound("weapons/sgpump", CHAN_AUTO, 0.8);
		"FZGR" FGHIJ 1;
		"FZGR" KL 1;
		TNT1 A 0 A_FireCustomMissile("ShotCaseSpawn", 5, 0, 6, -24);
		"FZGR" MNEFFEDCBA 1;
		"FZGP" B 1 A_TakeInventory("HasFreezerWeapon", 1);
		"FZGP" A 1 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		FireZoom:
		TNT1 A 0 A_GiveInventory("HasFiredWithZoom", 1);
		TNT1 A 0 A_ZoomFactor(1.4);
		TNT1 A 0 A_PlaySound("weapons/sg", CHAN_WEAPON);
		TNT1 A 0 A_PlaySound("weapons/CryoRifle/missile", CHAN_WEAPON);
		"FZGA" F 1 Bright A_GiveInventory("HasFreezerWeapon", 1);
		TNT1 AAAAA 0 A_FireCustomMissile("IceFlak1", frandom(-0.5, 0.5), 0, 0, 0, 0, frandom(-0.5, 0.5));
		TNT1 AAA 0 A_FireCustomMissile("IceSpear", frandom(-1, 1), 0, 0, 0, 0, frandom(-1, 1));
		TNT1 A 0 A_SetPitch(-6.2 + pitch);
		"FZGA" G 1 Bright A_SetPitch(1.5 + pitch);
		TNT1 A 0 A_ZoomFactor(1.5);
		"FZGA" HIJ 1 A_SetPitch(1.5 + pitch);
		"FZGA" E 4;
		"FZGA" K 2;
		"FZGA" K 1 A_PlaySound("weapons/sgpump", CHAN_AUTO, 0.8);
		"FZGA" LMN 1;
		"FZGA" MLL 1;
		TNT1 A 0 A_FireCustomMissile("ShotCaseSpawn", 5, 0, 4, -4);
		"FZGA" K 2;
		TNT1 A 0 A_TakeInventory("HasFreezerWeapon", 1);
		TNT1 A 0 PB_ReFire;
		"FZGA" E 1 A_DoPBWeaponAction;
		Goto ReadyZoom;

		FirePellet:
		TNT1 A 0 A_JumpIfInventory("PB_Shell", 1, "FirePelletGo");
		Goto Reload;
		FirePelletGo:
		TNT1 A 0 A_TakeInventory("PB_Shell", 1);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("weapons/golide/fire_db", CHAN_WEAPON);
		"FZGF" A 1 Bright;
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, 4, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, -4, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, 5, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, -5, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, 3, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, -3, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, 6, frandom(-3, 3));
		TNT1 A 0 A_FireCustomMissile("PBCF_CryoPellet", frandom(-5, 5), 0, -6, frandom(-3, 3));
		"FZGF" CEF 1 A_DoPBWeaponAction(WRF_NOFIRE | WRF_NOBOB);
		"FZGA" A 4;
		"FZGP" AB 1;
		"FZGR" ABCDE 1;
		"FZGR" F 1 A_PlaySound("weapons/sgpump", CHAN_AUTO, 0.8);
		"FZGR" FGHIJ 1;
		"FZGR" KL 1;
		TNT1 A 0 A_FireCustomMissile("ShotCaseSpawn", 5, 0, 6, -24);
		"FZGR" MNEFFEDCBA 1;
		"FZGP" A 1 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		FireOrb:
		TNT1 A 0 A_JumpIfInventory("PB_CryoCells", 1, "FireOrbGo");
		Goto Reload;
		FireOrbGo:
		TNT1 A 0 A_TakeInventory("PB_CryoCells", 1);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("weapons/CryoRifle/missile", CHAN_WEAPON);
		"FZGF" A 1 Bright A_FireCustomMissile("PBCF_IceOrbCryo", 0, 1, 0, -3);
		"FZGF" CEF 1;
		"FZGA" A 4;
		"FZGP" A 1 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		FireElectric:
		TNT1 A 0 A_JumpIfInventory("PB_CryoCells", 1, "FireElectricGo");
		Goto Reload;
		FireElectricGo:
		TNT1 A 0 A_TakeInventory("PB_CryoCells", 1);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("weapon/HMG/Fire", CHAN_WEAPON);
		"FZGF" A 1 Bright A_FireCustomMissile("LightningMissile2", 0, 1, 0, -5);
		"FZGF" CEF 1;
		"FZGA" A 4;
		"FZGP" A 1 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		FireWind:
		TNT1 A 0 A_JumpIfInventory("PB_CryoCannonCells", 12, "FireWindGo");
		Goto Reload;
		FireWindGo:
		TNT1 A 0 A_TakeInventory("PB_CryoCannonCells", 12);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("weapons/CryoRifle/missile", CHAN_WEAPON);
		"FZGF" A 3 Bright A_FireCustomMissile("PBCF_CryoWind", 0, 1, 0, 8);
		"FZGF" C 4;
		"FZGP" A 1 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		AltFire:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 { return PB_FireExecuteCheck(); }
		TNT1 A 0 A_GiveInventory("GoSpecial", 1);
		TNT1 A 0 A_JumpIfInventory("Zoomed", 1, "ZoomOut");
		TNT1 A 0 A_GiveInventory("Zoomed", 1);
		TNT1 A 0 A_ZoomFactor(1.5);
		TNT1 A 0 A_GiveInventory("ADSmode", 1);
		"####" ABCD 1;
		"####" A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		"####" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		"####" A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		"####" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		"####" A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		"####" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		"####" A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		"####" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		"####" A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		"####" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		"####" A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		"####" E 2 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		TNT1 A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		TNT1 A 0 A_JumpIfInventory("FiredSecondary", 1, "HoldAim");
		Goto ReadyZoom;

		HoldAim:
		TNT1 A 0 A_JumpIfInventory("HasFiredWithZoom", 1, 2);
		TNT1 A 0 A_JumpIfInventory("FiredPrimary", 1, "Fire");
		TNT1 A 0 A_JumpIfInventory("FiredPrimary", 1, 2);
		TNT1 A 0 A_TakeInventory("HasFiredWithZoom", 1);
		"FZGA" E 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		TNT1 A 0 A_JumpIfInventory("FiredSecondary", 1, "HoldAim");
		Goto ReadyZoom;

		ZoomOut:
		TNT1 A 0 A_TakeInventory("Zoomed", 1);
		TNT1 A 0 A_ZoomFactor(1.0);
		TNT1 A 0 A_GiveInventory("GoSpecial", 1);
		TNT1 A 0 A_TakeInventory("ADSmode", 1);
		"FZGA" DCB 1;
		Goto CryoShotgunReadyToFire;

		Reload:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 {
			if (CountInv("PB_CryoShotgun_Pellet") >= 1) return ResolveState("ReloadPellet");
			if (CountInv("PB_CryoShotgun_Orb") >= 1 || CountInv("PB_CryoShotgun_Electric") >= 1) return ResolveState("ReloadCryoCells");
			if (CountInv("PB_CryoShotgun_Wind") >= 1) return ResolveState("ReloadCannonCells");
			return ResolveState(null);
		}
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_JumpIfInventory("CryoShotgunAmmo", 120, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 12, 1);
		Goto CryoShotgunReadyToFire;
		TNT1 A 0 A_JumpIfInventory("TurboReload", 1, "TurboReloadLoop");
		TNT1 A 0 A_JumpIfInventory("Zoomed", 1, 2);
		TNT1 A 0 A_Jump(256, 9);
		"FZGA" DCBA 1;
		TNT1 A 0 A_ZoomFactor(1.0);
		TNT1 A 0 A_TakeInventory("Zoomed", 1);
		TNT1 A 0 A_TakeInventory("ADSmode", 1);
		TNT1 A 0 A_GiveInventory("Pumping", 1);
		"FZGA" A 1;
		"FZGP" ABCDEFGGG 1;
		TNT1 A 0 A_GiveInventory("ReloadingCryoShotty", 1);
		TNT1 A 0 A_JumpIfInventory("CryoShotgunAmmo", 120, "ReloadLoop1");
		TNT1 A 0 A_GiveInventory("ReloadingCryoShotty", 1);
		Goto ReloadLoop2;

		ReloadPellet:
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_JumpIfInventory("GotAPack_h", 1, "ReloadPelletCapBP");
		TNT1 A 0 A_JumpIfInventory("GotAPack", 1, "ReloadPelletCapBP");
		TNT1 A 0 A_JumpIfInventory("PB_Shell", 50, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("NewShell", 1, "ReloadPelletLoop");
		Goto CryoShotgunReadyToFire;
		ReloadPelletCapBP:
		TNT1 A 0 A_JumpIfInventory("PB_Shell", 100, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("NewShell", 1, "ReloadPelletLoop");
		Goto CryoShotgunReadyToFire;
		ReloadPelletLoop:
		TNT1 A 0 A_JumpIfInventory("GotAPack_h", 1, "ReloadPelletLoopBP");
		TNT1 A 0 A_JumpIfInventory("GotAPack", 1, "ReloadPelletLoopBP");
		TNT1 A 0 A_JumpIfInventory("PB_Shell", 50, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("NewShell", 1, "ReloadPelletInsert");
		Goto CryoShotgunReadyToFire;
		ReloadPelletLoopBP:
		TNT1 A 0 A_JumpIfInventory("PB_Shell", 100, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("NewShell", 1, "ReloadPelletInsert");
		Goto CryoShotgunReadyToFire;
		ReloadPelletInsert:
		"FZGP" K 1 {
			A_PlaySoundEx("insertshell", "Weapon");
			A_GiveInventory("PB_Shell", 1);
			A_TakeInventory("NewShell", 1, TIF_NOTAKEINFINITE);
		}
		"FZGP" L 2;
		Goto ReloadPelletLoop;

		ReloadCryoCells:
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_JumpIfInventory("PB_CryoCells", 300, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 1, "ReloadCryoCellsGo");
		Goto CryoShotgunReadyToFire;
		ReloadCryoCellsGo:
		TNT1 A 0 A_PlaySound("CELLIN2", CHAN_AUTO);
		TNT1 A 0 A_GiveInventory("PB_CryoCells", 40);
		TNT1 A 0 A_TakeInventory("PB_Cell", 1, TIF_NOTAKEINFINITE);
		Goto CryoShotgunReadyToFire;

		ReloadCannonCells:
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_JumpIfInventory("PB_CryoCannonCells", 120, "CryoShotgunReadyToFire");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 1, "ReloadCannonCellsGo");
		Goto CryoShotgunReadyToFire;
		ReloadCannonCellsGo:
		TNT1 A 0 A_PlaySound("CELLIN2", CHAN_AUTO);
		TNT1 A 0 A_GiveInventory("PB_CryoCannonCells", 30);
		TNT1 A 0 A_TakeInventory("PB_Cell", 1, TIF_NOTAKEINFINITE);
		Goto CryoShotgunReadyToFire;

		TurboReloadLoop:
		TNT1 A 0 A_JumpIfInventory("CryoShotgunAmmo", 120, "TurboReloadDone");
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 12, 1);
		Goto TurboReloadDone;
		TNT1 A 0 A_TakeInventory("PB_Cell", 12);
		TNT1 A 0 A_GiveInventory("CryoShotgunAmmo", 12);
		Loop;
		TurboReloadDone:
		TNT1 A 0 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		ReloadLoop1:
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 12, 1);
		Goto ReloadDone1;
		TNT1 A 0 A_JumpIfInventory("CryoShotgunAmmo", 120, "ReloadDone1");
		TNT1 A 0 A_GiveInventory("Pumping", 1);
		"FZGP" HIJ 1;
		"FZGP" K 1 A_PlaySoundEx("insertshell", "Weapon");
		TNT1 A 0 A_TakeInventory("PB_Cell", 12);
		TNT1 A 0 A_GiveInventory("CryoShotgunAmmo", 12);
		"FZGP" LMN 1;
		"FZGP" I 1 PB_ReFire;
		TNT1 A 0 A_JumpIfInventory("Kicking", 1, "ReloadKick");
		Loop;

		ReloadLoop2:
		TNT1 A 0 A_JumpIfInventory("PB_Cell", 12, 1);
		Goto ReloadDone2;
		TNT1 A 0 A_JumpIfInventory("CryoShotgunAmmo", 120, "ReloadDone2");
		TNT1 A 0 A_GiveInventory("Pumping", 1);
		"FZGP" HIJ 1;
		"FZGP" K 1 A_PlaySoundEx("insertshell", "Weapon");
		TNT1 A 0 A_TakeInventory("PB_Cell", 12);
		TNT1 A 0 A_GiveInventory("CryoShotgunAmmo", 12);
		"FZGP" LMN 1;
		"FZGP" I 1 PB_ReFire;
		Loop;

		ReloadDone1:
		"FZGP" FEDBC 1;
		"FZGR" BC 1;
		"FZGR" D 1 A_PlaySound("weapons/sgpump", CHAN_AUTO, 0.8);
		"FZGR" EFGHIJ 1;
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_TakeInventory("ReloadingCryoShotty", 2);
		TNT1 A 0 A_TakeInventory("CryoShottyWasEmpty", 1);
		TNT1 A 0 PB_ReFire;
		"FZGR" KLMNCBA 1 A_StopSound(CHAN_AUTO);
		"FZGP" BA 1;
		Goto CryoShotgunReadyToFire;

		ReloadDone2:
		TNT1 A 0 A_GiveInventory("Pumping", 1);
		"FZGP" FEDBC 1;
		"FZGR" BC 1;
		"FZGR" D 1 A_PlaySound("weapons/sgpump", CHAN_AUTO, 0.8);
		"FZGR" EFGHIJ 1;
		"FZGR" KLMNCBA 1 A_StopSound(CHAN_AUTO);
		"FZGP" BA 1;
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_TakeInventory("ReloadingCryoShotty", 2);
		TNT1 A 0 A_TakeInventory("CryoShottyWasEmpty", 1);
		TNT1 A 0 PB_ReFire;
		Goto CryoShotgunReadyToFire;

		ReloadKick:
		TNT1 A 0 A_JumpIfInventory("ReloadingCryoShotty", 2, 1);
		Goto ReloadKickAlt;
		TNT1 A 0 A_GiveInventory("Pumping", 1);
		"FZGP" IJK 1;
		TNT1 A 0 A_PlaySound("weapons/golide/select", CHAN_AUTO);
		TNT1 A 0 A_TakeInventory("PB_Cell", 12);
		TNT1 A 0 A_GiveInventory("CryoShotgunAmmo", 12);
		"FZGP" LLMN 1;
		ReloadKickAlt:
		"FZGA" A 1;
		Goto CryoShotgunReadyToFire;

		Deselect:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			PB_HandleCrosshair(39);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_PlaySound("weapons/changing");
		TNT1 A 0 A_TakeInventory("Zoomed", 1);
		TNT1 A 0 A_ZoomFactor(1.0);
		TNT1 A 0 A_TakeInventory("ADSmode", 1);
		TNT1 A 0 A_SetCrosshair(0);
		"FZGS" EDCBA 1;
		TNT1 A 0 A_Lower(120);
		Wait;

		WheelCancel:
		TNT1 A 0 A_SetInventory("Select_PB_CryoShotgun_Buck", 0);
		TNT1 A 0 A_SetInventory("Select_PB_CryoShotgun_Pellet", 0);
		TNT1 A 0 A_SetInventory("Select_PB_CryoShotgun_Orb", 0);
		TNT1 A 0 A_SetInventory("Select_PB_CryoShotgun_Electric", 0);
		TNT1 A 0 A_SetInventory("Select_PB_CryoShotgun_Wind", 0);
		Stop;

		AlreadyLoaded:
		TNT1 A 0 A_Print("Ammo type already selected");
		Goto CryoShotgunReadyToFire;

		WeaponSpecial:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 {
			A_SetInventory("GoWeaponSpecialAbility", 0);
			A_TakeInventory("Zoomed", 1);
			A_TakeInventory("ADSmode", 1);
			A_ZoomFactor(1.0);
			A_ClearOverlays(10, 11);
		}
		TNT1 A 0 {
			if (CountInv("Select_PB_CryoShotgun_Buck") == 1) { A_Overlay(-12, "WheelCancel"); return ResolveState("SwitchToBuck"); }
			if (CountInv("Select_PB_CryoShotgun_Pellet") == 1) { A_Overlay(-12, "WheelCancel"); return ResolveState("SwitchToPellet"); }
			if (CountInv("Select_PB_CryoShotgun_Orb") == 1) { A_Overlay(-12, "WheelCancel"); return ResolveState("SwitchToOrb"); }
			if (CountInv("Select_PB_CryoShotgun_Electric") == 1) { A_Overlay(-12, "WheelCancel"); return ResolveState("SwitchToElectric"); }
			if (CountInv("Select_PB_CryoShotgun_Wind") == 1) { A_Overlay(-12, "WheelCancel"); return ResolveState("SwitchToWind"); }
			return ResolveState(null);
		}
		Goto CryoShotgunReadyToFire;

		SwitchToBuck:
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Buck", 1, "AlreadyLoaded");
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Buck", 1);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Pellet", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Orb", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Electric", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Wind", 0);
		TNT1 A 0 A_PlaySound("menu/choose", CHAN_AUTO);
		TNT1 A 0 A_Print("Cryo Buckshot");
		Goto CryoShotgunReadyToFire;

		SwitchToPellet:
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Pellet", 1, "AlreadyLoaded");
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Buck", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Pellet", 1);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Orb", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Electric", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Wind", 0);
		TNT1 A 0 A_PlaySound("menu/choose", CHAN_AUTO);
		TNT1 A 0 A_Print("Cryo Pellets");
		Goto CryoShotgunReadyToFire;

		SwitchToOrb:
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Orb", 1, "AlreadyLoaded");
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Buck", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Pellet", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Orb", 1);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Electric", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Wind", 0);
		TNT1 A 0 A_PlaySound("menu/choose", CHAN_AUTO);
		TNT1 A 0 A_Print("Cryo Orb");
		Goto CryoShotgunReadyToFire;

		SwitchToElectric:
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Electric", 1, "AlreadyLoaded");
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Buck", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Pellet", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Orb", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Electric", 1);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Wind", 0);
		TNT1 A 0 A_PlaySound("menu/choose", CHAN_AUTO);
		TNT1 A 0 A_Print("Electric Bolt");
		Goto CryoShotgunReadyToFire;

		SwitchToWind:
		TNT1 A 0 A_JumpIfInventory("PB_CryoShotgun_Wind", 1, "AlreadyLoaded");
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Buck", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Pellet", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Orb", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Electric", 0);
		TNT1 A 0 A_SetInventory("PB_CryoShotgun_Wind", 1);
		TNT1 A 0 A_PlaySound("menu/choose", CHAN_AUTO);
		TNT1 A 0 A_Print("Cryo Wind");
		Goto CryoShotgunReadyToFire;

		FlashPunching:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		"FZGH" ABCDE 1;
		"FZGH" F 4;
		"FZGH" EDCBA 1;
		Stop;

		FlashKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelKicking");
		"FZGH" ABCDE 1;
		"FZGH" F 4;
		"FZGH" EDCBA 1;
		Goto CryoShotgunReadyToFire;

		FlashAirKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelAirKicking");
		"FZGH" ABCDE 1;
		"FZGH" F 8;
		"FZGH" EDCBA 1;
		"FZGA" A 1;
		Goto CryoShotgunReadyToFire;

		FlashSlideKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKicking");
		"FZGH" ABCDE 1;
		"FZGH" F 6;
		FlashSlideKickingStop:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("GrabbedBurningBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKickingStop");
		"FZGH" EDCBA 2;
		"FZGA" A 1;
		Goto CryoShotgunReadyToFire;

		PDA_Preview_Fire:
		"FZGF" A 1 Bright;
		"FZGF" B 1 Bright;
		"FZGF" C 1;
		"FZGF" E 1;
		"FZGF" F 1;
		"FZGA" A 2;
		"FZGP" A 1;
		"FZGR" ABCDE 1;
		Stop;
		PDA_Preview_AltFire:
		"FZGA" ABCD 1;
		"FZGA" E 2;
		"FZGA" DCB 1;
		Stop;
		PDA_Preview_Reload:
		"FZGP" ABCDEFG 1;
		"FZGP" HIJK 1;
		"FZGR" ABCDEF 1;
		Stop;
	}
}
