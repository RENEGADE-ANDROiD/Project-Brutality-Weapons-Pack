// PB_DarkMatterRifle - ZScript port (DECORATE PB_Weapon retired).

class PB_DarkMatterRifle : PB_WeaponBase
{
	default
	{
	Weapon.BobRangeX 0.3;
	Weapon.BobRangeY 0.5;
		Weapon.BobStyle "InverseSmooth";
	Weapon.BobSpeed 2.4;
	Weapon.AmmoUse1 0;
	Weapon.AmmoGive1 60;
	Weapon.AmmoUse2 0;
	Weapon.AmmoGive2 0;
	Weapon.AmmoType1 "Cell";
	Weapon.AmmoType2 "PB_DarkMatterMag";
	Inventory.PickupSound "7LSPICK";
	Weapon.SelectionOrder 7150;
	+WEAPON.NOAUTOAIM;
	+WEAPON.NOALERT;
	+INVENTORY.ALWAYSPICKUP;
	+FLOORCLIP;
	+DONTGIB;
	Inventory.PickupMessage "$PB_PICKUP_PB_DARKMATTERRIFLE";
	Inventory.Icon "PLCUA0";
	Obituary "%o was vaporized by %k's Dark Matter Rifle.";
	Tag "UAC Prototype Dark Matter Rifle";
	Weapon.SlotNumber 8;
	Weapon.SlotPriority 0.085;
	PB_WeaponBase.WheelInfo "PB_DarkMatterRifleWheel";
	}
	states
	{
		Steady:
		TNT1 A 1;
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
		Goto Ready3;

		Ready:
		Goto Ready3;

		SelectAnimation:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		"PZC9" ABC 1 A_DoPBWeaponAction(WRF_NOFIRE);
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		Goto Ready3;

		Ready3:
		TNT1 A 0 SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_JumpIfInventory("GoWeaponSpecialAbility", 1, "WeaponSpecial");
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			PB_HandleCrosshair(76);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_PlaySound("PLSIDLE", 6, 1, 1);
		Goto ReadyLoop;

		ReadyLoop:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_JumpIfInventory("GoWeaponSpecialAbility", 1, "WeaponSpecial");
		"PZC4" ABCDEDCBA 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;

		GunEmpty:
		"PZCR" A 1 A_DoPBWeaponAction;
		"PZCR" A 1 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 AA 0;
		TNT1 A 0 A_JumpIfInventory("UseEquipment", 1, "UseEquipment");
		TNT1 A 0 A_JumpIfInventory("ToggleEquipment", 1, "SwitchEquipment");
		"PZCR" A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD, PBWEAP_UNLOADED);
		Goto GunEmpty+3;

		DontNeedToReload:
		Goto Ready3;

		WeaponSpecial:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0 A_JumpIfInventory("Select_PB_DMR_SuperBall", 1, "WSpecSuperBall");
		TNT1 A 0 A_JumpIfInventory("Select_PB_DMR_GravityBomb", 1, "WSpecGravity");
		Goto Ready3;

		WSpecSuperBall:
		TNT1 A 0 { A_TakeInventory("Select_PB_DMR_SuperBall", 1); A_TakeInventory("Select_PB_DMR_GravityBomb", 1); A_SetInventory("PB_DMR_GravityAltMode", 0); A_PlaySound("menu/choose", CHAN_AUTO); }
		Goto Ready3;

		WSpecGravity:
		TNT1 A 0 { A_TakeInventory("Select_PB_DMR_SuperBall", 1); A_TakeInventory("Select_PB_DMR_GravityBomb", 1); A_SetInventory("PB_DMR_GravityAltMode", 1); A_PlaySound("menu/choose", CHAN_AUTO); }
		Goto Ready3;

		Deselect:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 A_TakeInventory("HasPlasmaWeapon", 1);
		TNT1 A 0 A_TakeInventory("PlasmaGunSelected", 1);
		TNT1 A 0 A_ZoomFactor(1.0);
		TNT1 A 0 A_StopSound(6);
		TNT1 A 0 A_PlaySound("PLSOFF", 4);
		TNT1 A 0 A_JumpIfInventory("GotMeatShield", 1, "GrabEnemy");
		"PZC9" CBA 1;
		TNT1 AAAAAAAAAAAAAAAAAA 0 A_Lower(120);
		Wait;

		Select:
		TNT1 A 0 {
			A_WeaponOffset(0, 32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt", 1);
		}
		TNT1 A 0 A_TakeInventory("HasBarrel", 1);
		TNT1 A 0 A_TakeInventory("HasIceBarrel", 1);
		TNT1 A 0 A_TakeInventory("HasFlameBarrel", 1);
		TNT1 A 0 A_TakeInventory("GrabbedBarrel", 1);
		TNT1 A 0 A_TakeInventory("GrabbedIceBarrel", 1);
		TNT1 A 0 A_TakeInventory("GrabbedFlameBarrel", 1);
		Goto SelectFirstPersonLegs;

		SelectContinue:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_WeaponRaise("PLSDRAW");
		TNT1 A 0 PB_WeapTokenSwitch("PlasmaGunSelected");
		TNT1 A 0 PB_SetMagUnloaded(false);
		TNT1 A 0 A_GiveInventory("HasPlasmaWeapon", 1);
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		TNT1 A 0 { return PB_RespectIfNeeded(); }

		Fire:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "ThrowIceBarrel");
		TNT1 A 0 {
			if (CountInv("GoFatality") >= 1) { SetPlayerProperty(0, 1, 0); }
			else { SetPlayerProperty(0, 0, 0); }
		}
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_WeaponOffset(0, 32);
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 1, 2);
		Goto Reload;
		TNT1 AAAA 0;
		TNT1 A 0 A_PlaySound("PAILGF2", 3);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_ZoomFactor(.985);
		"PZCF" A 1 BRIGHT A_FireCustomMissile("PB_DMR_PulseBall", 0, 1, 0, 0);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		TNT1 A 0 A_SpawnItem("PinkIonFlare", 14, 30, 0, 0);
		TNT1 A 0 PB_WeaponRecoil(-0.72, -0.18);
		"PZCF" B 1 A_ZoomFactor(.970);
		"PZCF" C 1 A_ZoomFactor(.965);
		"PZCF" B 0 A_ZoomFactor(.985);
		TNT1 A 0 A_TakeInventory("PB_DarkMatterMag", 1);
		TNT1 A 0 A_Refire();
		TNT1 A 0 A_ZoomFactor(1.0);
		TNT1 A 0 A_JumpIf(GetCvar("pb_nocooldown"), "Ready3");
		TNT1 A 0 A_PlaySound("PLSRD", 1);
		"PZCU" BCD 1;
		"PZCU" FFFFFF 3 A_FireCustomMissile("SmokeSpawner", 0, 0, 0, 5);
		"PZCU" DCB 1;
		TNT1 A 0 A_PlaySound("BEPBEP");
		Goto Ready3;

		AltFire:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			if (CountInv("GoFatality") >= 1) { SetPlayerProperty(0, 1, 0); }
			else { SetPlayerProperty(0, 0, 0); }
		}
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 PB_TryAutoFatalityOnFire();
		TNT1 A 0 A_JumpIfInventory("PB_DMR_GravityAltMode", 1, "GravityAltFire");
		TNT1 A 0 A_WeaponOffset(0, 32);
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 30, 13);
		Goto Reload;
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 0;
		TNT1 A 0 A_StopSound(6);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("CHRGA", 0);
		"PZCR" A 5;
		TNT1 A 0 A_FireCustomMissile("ShakeYourAss", 0, 0, 0, 0);
		TNT1 A 0 A_ZoomFactor(0.995);
		"PZC4" A 5 BRIGHT A_PlaySound("PLSC_1", 1);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" B 5 BRIGHT A_PlaySound("PLSC_2", 2);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" C 5 BRIGHT A_PlaySound("PLSC_3", 3);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" D 5 BRIGHT A_PlaySound("PLSC_4", 4);
		"PZC4" EF 1 BRIGHT A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" GH 1 BRIGHT A_FireCustomMissile("ShakeYourAss", 0, 0, 0, 0);
		"PZC4" I 1 BRIGHT;
		PZCS ABCD 1 BRIGHT {
			if (JustPressed(BT_RELOAD)) { return ResolveState("DeCharge"); }
			return ResolveState(null);
		}
		TNT1 A 0 A_Refire();
		AltHold:
		TNT1 A 0 A_PlaySound("PLSFULL", 0, 1, 1);
		TNT1 A 0 A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		TNT1 A 0 A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		TNT1 A 0 A_JumpIfInventory("Reloading", 1, "DeCharge");
		TNT1 A 0 A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
		PZCS BCDC 1 BRIGHT {
			A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
			A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
			A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
			A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
			if (JustPressed(BT_RELOAD)) { return ResolveState("DeCharge"); }
			return ResolveState(null);
		}
		TNT1 A 0 A_Refire();
		TNT1 A 0 A_StopSound(0);
		"PZCF" A 2 BRIGHT A_Recoil(1);
		TNT1 A 0 A_FireCustomMissile("PurplePlasmaFlare", -5, 0, 0, 0);
		TNT1 A 0 A_PlaySound("CHGX", 0);
		TNT1 A 0 A_ZoomFactor(0.85);
		TNT1 A 0 A_FireCustomMissile("PB_DMR_SuperBall", 0, 0, 0, 0);
		CoolAfterAltFire:
		TNT1 A 0 PB_WeaponRecoilBasic(-1.15);
		TNT1 A 0 A_TakeInventory("PB_DarkMatterMag", 30);
		"PZCR" A 1 A_ZoomFactor(0.90);
		"PZCR" A 1 A_ZoomFactor(0.95);
		"PZCR" A 1 A_ZoomFactor(0.975);
		"PZCR" A 1 A_ZoomFactor(0.99);
		"PZCR" A 1 A_ZoomFactor(1.0);
		"PZCR" BC 1;
		"PZCG" DE 1;
		"PZCG" EEEEEEEEEE 2 A_FireCustomMissile("SmokeSpawner", 0, 0, 0, 5);
		"PZCG" DCB 1;
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 1, 2);
		Goto Reload;
		TNT1 AAAA 0;
		TNT1 A 0 A_PlaySound("BEPBEP");
		Goto Ready3;

		Flash:
		TNT1 A 1;
		Stop;

		Spawn:
		"PLCU" A 10;
		Loop;

		DeCharge:
		TNT1 A 0 A_StopSound(0);
		TNT1 A 0 A_PlaySound("PLSDEARG");
		TNT1 A 0 A_ZoomFactor(1.0);
		"PZCS" C 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" D 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" C 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" B 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" A 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZC4" IHGFEDCB 1 BRIGHT;
		"PZCR" A 2 BRIGHT;
		TNT1 A 0 A_PlaySound("BEPBEP", 5, 1.2);
		TNT1 A 0 A_ClearReFire;
		Goto Ready3;

		GravityAltFire:
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 20, 13);
		Goto Reload;
		TNT1 A 0;
		TNT1 A 0 A_StopSound(6);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_PlaySound("CHRGA", 0);
		"PZCR" A 5;
		TNT1 A 0 A_FireCustomMissile("ShakeYourAss", 0, 0, 0, 0);
		TNT1 A 0 A_ZoomFactor(0.995);
		"PZC4" A 2 BRIGHT A_PlaySound("PLSC_1", 1);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" B 2 BRIGHT A_PlaySound("PLSC_2", 2);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" C 2 BRIGHT A_PlaySound("PLSC_3", 3);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" D 2 BRIGHT A_PlaySound("PLSC_4", 4);
		"PZC4" EF 1 BRIGHT A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		"PZC4" GH 1 BRIGHT A_FireCustomMissile("ShakeYourAss", 0, 0, 0, 0);
		"PZC4" I 1 BRIGHT;
		PZCS ABCD 1 BRIGHT {
			if (JustPressed(BT_RELOAD)) { return ResolveState("DeChargeII"); }
			return ResolveState(null);
		}
		TNT1 A 0 A_ReFire("AltHoldII");

		AltHoldII:
		TNT1 A 0 A_PlaySound("PLSFULL", 0, 1, 1);
		TNT1 A 0 A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
		TNT1 A 0 A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		TNT1 A 0 A_JumpIfInventory("Reloading", 1, "DeChargeII");
		TNT1 A 0 A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
		PZCS BCDC 1 BRIGHT {
			A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
			A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
			A_FireCustomMissile("ShakeYourAssMinor", 0, 0, 0, 0);
			A_SpawnItem("PlasmaGauntlet", 0, 1, 0, 0);
			if (JustPressed(BT_RELOAD)) { return ResolveState("DeChargeII"); }
			return ResolveState(null);
		}
		TNT1 A 0 A_ReFire("AltHoldII");
		TNT1 A 0 A_StopSound(0);
		"PZCF" A 2 BRIGHT A_Recoil(1);
		TNT1 A 0 A_FireCustomMissile("PurplePlasmaFlare", -5, 0, 0, 0);
		TNT1 A 0 A_PlaySound("weapons/bh_secondary", 0);
		TNT1 A 0 A_ZoomFactor(0.85);
		TNT1 A 0 A_FireCustomMissile("PB_DMR_GravityBomb", 0, 0, 0, 0);

		CoolAfterGravAlt:
		TNT1 A 0 PB_WeaponRecoilBasic(-1.15);
		TNT1 A 0 A_TakeInventory("PB_DarkMatterMag", 20);
		"PZCR" A 1 A_ZoomFactor(0.90);
		"PZCR" A 1 A_ZoomFactor(0.95);
		"PZCR" A 1 A_ZoomFactor(0.975);
		"PZCR" A 1 A_ZoomFactor(0.99);
		"PZCR" A 1 A_ZoomFactor(1.0);
		"PZCR" BC 1;
		"PZCG" DE 1;
		"PZCG" EEEEEEEEEE 2 A_FireCustomMissile("SmokeSpawner", 0, 0, 0, 5);
		"PZCG" DCB 1;
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 1, 2);
		Goto Reload;
		TNT1 AAAA 0;
		TNT1 A 0 A_PlaySound("BEPBEP");
		Goto Ready3;

		DeChargeII:
		TNT1 A 0 A_StopSound(0);
		TNT1 A 0 A_PlaySound("PLSDEARG");
		TNT1 A 0 A_ZoomFactor(1.0);
		"PZCS" C 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" D 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" C 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" B 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZCS" A 2 BRIGHT A_FireCustomMissile("PurplePlasmaFlare", 0, 0, 0, 0);
		"PZC4" IHGFEDCB 1 BRIGHT;
		"PZCR" A 2 BRIGHT;
		TNT1 A 0 A_PlaySound("BEPBEP", 5, 1.2);
		TNT1 A 0 A_ClearReFire;
		Goto Ready3;

		Reload:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 A_ClearReFire;
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 60, "DontNeedToReload");
		TNT1 A 0 A_PlaySound("BEEEP");
		TNT1 A 0 A_JumpIfInventory("Cell", 1, 3);
		Goto Ready3;
		TNT1 AAAA 0;
		"PZCR" A 1;
		"PZCR" B 2 A_PlaySound("CELLPKUP", 6);
		"PZCR" C 1;
		"PZCR" D 2;
		"PZCR" E 1;
		"PZCR" F 2 A_StopSound(6);
		"PZCR" G 1 A_PlaySound("PLSOFF", 1);
		TNT1 A 0 PB_JumpIfMagUnloaded("DMRReloadMagIn");
		TNT1 A 0 A_FireCustomMissile("PlasmaCaseSpawn", -5, 0, 8, -4);
		"PZCR" HHHHHHHHIJK 2;
		TNT1 A 0 PB_SetMagUnloaded(false);
		DMRReloadMagIn:
		"PZCR" L 1 A_PlaySound("PLREADY", 6);
		"PZCR" L 1 A_PlaySound("PLSRD", 0);
		"PZCR" LLMNO 2;
		"PZCR" C 1;
		"PZCR" B 2;
		TNT1 A 0 A_PlaySound("PLREADY");
		"PZCR" A 2;
		InsertBullets:
		TNT1 AAAA 0;
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 60, "Ready3");
		TNT1 A 0 A_JumpIfInventory("Cell", 1, 3);
		Goto Ready3;
		TNT1 AAAAAA 0;
		TNT1 A 0 A_GiveInventory("PB_DarkMatterMag", 1);
		TNT1 A 0 A_TakeInventory("Cell", 1, TIF_NOTAKEINFINITE);
		Goto InsertBullets;
		TNT1 AAAAAAAA 0;
		TNT1 A 0 A_Refire();
		TNT1 A 0 A_TakeInventory("Reloading", 1);
		Goto Ready3;

		AlreadyUnloaded:
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		Goto Ready3;

		Unload:
		TNT1 A 0 PB_JumpIfMagUnloaded("AlreadyUnloaded");
		TNT1 A 0 A_StopSound(6);
		TNT1 A 0 A_ZoomFactor(1.0);
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		TNT1 A 0 A_TakeInventory("ADSmode", 1);
		TNT1 A 0 A_TakeInventory("Zoomed", 1);
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 1, 3);
		Goto GunEmpty;
		TNT1 AAA 0;
		TNT1 A 0 A_TakeInventory("Zoomed", 1);
		"PZCR" A 1;
		"PZCR" B 2 A_PlaySound("CELLPKUP");
		"PZCR" MMLKJIH 2;
		"PZCR" G 1;
		"PZCR" F 2;
		"PZCR" E 1;
		"PZCR" D 2;
		"PZCR" C 1;
		"PZCR" B 2;
		"PZCR" A 1;
		TNT1 A 0 A_GiveInventory("Pumping", 1);
		TNT1 A 0 A_TakeInventory("Unloading", 1);

		RemoveBullets:
		TNT1 AAAA 0;
		TNT1 A 0 A_JumpIfInventory("PB_DarkMatterMag", 1, 3);
		Goto FinishUnload;
		TNT1 AAAAAA 0;
		TNT1 A 0 A_TakeInventory("PB_DarkMatterMag", 1);
		TNT1 A 0 A_GiveInventory("Cell", 1);
		Goto RemoveBullets;

		FinishUnload:
		TNT1 A 0 PB_SetMagUnloaded(true);
		TNT1 A 0 A_TakeInventory("Unloading", 1);
		Goto GunEmpty+6;

		FlashKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelKicking");
		"PZCG" W 1;
		"PZCG" X 1;
		"PZCG" Y 1;
		"PZCG" Y 3;
		"PZCG" Z 3;
		"PZCG" Y 3;
		"PZCG" X 1;
		"PZCG" W 1;
		"PZCG" A 1;
		"PZCG" AAA 1;
		Goto Ready3;

		FlashAirKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelAirKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelAirKicking");
		"PZCG" W 1;
		"PZCG" X 1;
		"PZCG" Y 1;
		"PZCG" Y 3;
		"PZCG" Z 3;
		"PZCG" Y 3;
		"PZCG" X 1;
		"PZCG" W 1;
		"PZCG" A 1;
		"PZCG" AAAA 1;
		Goto Ready3;

		FlashSlideKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelSlideKicking");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKicking");
		"PZCG" BC 2;
		"PZCG" DDDDDDEEEFF 2;
		FlashSlideKickingStop:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelSlideKickingStop");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelSlideKickingStop");
		"PZCG" FEDCB 1;
		"PZCG" A 1;
		Goto Ready3;

		FlashPunching:
		"PZCG" W 1;
		"PZCG" X 1;
		"PZCG" Y 1;
		"PZCG" Y 3;
		"PZCG" Z 3;
		"PZCG" Y 3;
		"PZCG" X 1;
		"PZCG" W 1;
		"PZCG" A 1;
		"PZCG" AAA 1;
		TNT1 A 0 A_WeaponOffset(0, 32);
		TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
		Goto Ready3;

		PDA_Preview_DMRReady:
		"PZC4" A 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZC4" B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZC4" C 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZC4" D 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Stop;
		PDA_Preview_DMRFire:
		"PZCF" A 1 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCF" B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCF" C 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCU" B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCU" C 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCU" D 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Stop;
		PDA_Preview_DMRAltCharge:
		"PZC4" A 5 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZC4" B 5 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZC4" C 5 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZC4" D 5 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCS" A 1 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCS" B 1 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCS" C 1 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		Stop;
		PDA_Preview_DMRAltFire:
		"PZCF" A 2 BRIGHT A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCR" A 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCR" B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCG" D 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCG" C 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCG" B 1 A_DoPBWeaponAction(WRF_NOFIRE);
		Stop;
		PDA_Preview_DMRReload:
		"PZCR" A 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCR" B 2 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCR" C 1 A_DoPBWeaponAction(WRF_NOFIRE);
		"PZCR" D 2 A_DoPBWeaponAction(WRF_NOFIRE);
		Stop;
	}
}
