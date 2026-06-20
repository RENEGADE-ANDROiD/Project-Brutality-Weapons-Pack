// PB_SideFusil - ZScript port (DECORATE PB_Weapon retired).

class PB_SideFusil : PB_WeaponBase
{
	default
	{
    Weapon.AmmoUse1 0;
    Weapon.AmmoGive1 0;
    Weapon.AmmoType2 "PB_FusilMag";
    Weapon.AmmoUse2 0;
    Weapon.AmmoGive2 0;
    Weapon.SlotNumber -1;
    Weapon.AmmoType1 "PB_HighCalMag";
    Obituary "%o was shot down by %k's Fusil.";
    AttackSound "None";
    +WEAPON.NOAUTOAIM;
    +WEAPON.NOALERT;
    +WEAPON.NOAUTOFIRE;
    +WEAPON.NO_AUTO_SWITCH;
    +WEAPON.CHEATNOTWEAPON;
    +FORCEXYBILLBOARD;
    Weapon.SelectionOrder 2449;
    Scale 1.0;
    Tag "Fusil Sidearm";
	}
	states
	{
		Steady:
        TNT1 A 1;
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 SetPlayerProperty(0,0,0);
        TNT1 A 0 SetPlayerProperty(0,0,PROP_TOTALLYFROZEN);
        Goto Ready3;

		NoAmmo:
        "SIDE" A 1;
        TNT1 A 0 A_PlaySound("DRYFIRE");
        Goto Ready3;

		ReadySeen:
        TNT1 A 0 A_PlaySound("CLIPIN");
        "RPTF" "GHI" 1 A_WeaponReady;
        Goto RealReady;

		Ready:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        TNT1 A 2 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 A_JumpIfInventory("PB_SideFusilSeen", 1, "ReadySeen");
        TNT1 A 0 A_GiveInventory("PB_SideFusilSeen", 1);
        "ANIM" "AAAAA" 5 A_WeaponReady;
        "ANIM" "CEGI" 1 A_WeaponReady;
        TNT1 A 0 A_PlaySound("ENTEIN");
        "ANIM" J 5 A_WeaponReady;
        "ANIM" "KLMN" 1 A_WeaponReady;
        Goto RealReady;

		RealReady:
		Ready3:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        "SIDE" A 0 PB_WeapTokenSwitch("RifleSelected");
        "SIDE" A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        Loop;

		DualWield:
        TNT1 A 0;
        Goto WeaponSpecial;

		Deselect:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        TNT1 A 0 A_TakeInventory("Zoomed",1);
        TNT1 A 0 A_TakeInventory("UseEquipment", 1);
        TNT1 A 0 A_ZoomFactor(1.0);
        TNT1 A 0 A_TakeInventory("ADSmode",1);
        "RPTF" "IHG" 1;
        TNT1 A 1 A_Lower(120);
        Wait;

		Select:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        Goto SelectFirstPersonLegs;
		SelectContinue:
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 PB_WeaponRaise("ENTEIN");
        TNT1 A 0 A_GiveInventory("PB_Fusil", 1);
        TNT1 A 0 PB_WeapTokenSwitch("RifleSelected");
        Goto Ready3;

		Fire:
        TNT1 A 0 {
            if (CountInv("GoFatality") >= 1) {
                SetPlayerProperty(0,1,0);
            }
            else
            {
                SetPlayerProperty(0,0,0);
                SetPlayerProperty(0,0,PROP_TOTALLYFROZEN);
            }
        }
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",1,2);
        Goto Reload;
        TNT1 A 0 A_FireCustomMissile("SmokeSpawner",0,0,0,5);
        TNT1 A 0 A_FireCustomMissile("YellowFlareSpawn",-5,0,0,0);
        "SIDE" A 1 {
            A_TakeInventory("PB_FusilMag",1);
            A_StartSound("MG42FIR", CHAN_WEAPON, CHANF_OVERLAP, 1.0, 0, frandom(0.98, 1.02));
            A_SetPitch(-1.2 + pitch);
        }
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        "SIDE" B 1 BRIGHT A_AlertMonsters();
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        TNT1 A 0 A_FireCustomMissile("PBWP_Tracer_Rifle", random(-2, 2), 0, -1, 0, 0, random(-2, 2));
        "SIDE" C 1 A_FireBullets (4, 3, -1, 12, "HitPuff");
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        "SIDE" D 1 A_FireCustomMissile("RifleCaseSpawn",-5,0,8,-4);
        "SIDE" C 1;
        "SIDE" B 1;
        "SIDE" A 1;
        TNT1 A 0 A_Refire;
        Goto Ready3;

		AltFire:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        "CUCH" "AB" 1;
        "CUCH" C 1;
        "CUCH" "DEF" 1;
        "CUCH" A 0 A_StartSound("weapons/gswing", CHAN_AUTO);
        "CUCH" A 0 A_Saw("", "", 3, "AxePuffs", 0, 120, 0,16);
        "CUCH" G 1 A_SetPitch(pitch+2);
        "CUCH" H 1 A_SetPitch(pitch+2);
        "CUCH" I 1 A_SetPitch(pitch+2);
        TNT1 AA 1 A_SetPitch(pitch+2);
        TNT1 A 2;
        TNT1 AAAA 1 A_SetPitch(pitch-2);
        TNT1 A 1;
        Goto Ready3;

		Reload:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(5);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
            A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        }
        TNT1 A 0 A_SetCrosshair(0);
        TNT1 A 1;
        TNT1 A 0 A_ZoomFactor(1.0);
        TNT1 A 0 A_TakeInventory("Reloading",1);
        TNT1 A 0 A_TakeInventory("ADSmode",1);
        TNT1 A 0 A_TakeInventory("Zoomed",1);
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",24,"Ready3");
        TNT1 A 0 A_JumpIfInventory("PB_HighCalMag",1,3);
        Goto NoAmmo;
        TNT1 A 0 A_GiveInventory("Pumping", 1);
        "ASUN" "ABCDE" 1;
        "M901" "DE" 2;
        TNT1 A 0 PB_JumpIfMagUnloaded("SideFusilReloadMagIn");
        TNT1 A 0 A_FireCustomMissile("EmptyClipSpawn",-5,0,8,-4);
        TNT1 A 0 A_PlaySound("Reload");
        "M901" "FFFFFFFFF" 2;
        TNT1 A 0 A_PlaySound("RIFCL_CL", 3);
        TNT1 A 0 PB_SetMagUnloaded(false);
		SideFusilReloadMagIn:
        TNT1 A 0 PB_AmmoIntoMag("PB_FusilMag","PB_HighCalMag",24,1);
        "M901" "FFFFF" 1;
        "ASUN" "IHG" 1;
        "ASUN" "GF" 1;
        "M901" A 1;
        "ASUN" "ECDBA" 1;
        Goto Ready3;

		InsertBullets:
        Goto Ready3;

		Unload:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(5);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        "SIDE" A 1 A_WeaponReady;
        TNT1 A 0 A_ZoomFactor(1.0);
        TNT1 A 0 A_TakeInventory("Unloading",1);
        TNT1 A 0 A_TakeInventory("ADSmode",1);
        TNT1 A 0 A_TakeInventory("Zoomed",1);
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",1,3);
        Goto NoAmmo;
        TNT1 A 0 A_PlaySound("CLIPIN");
        "ASUN" "ABCDE" 1;
        "M901" A 1;
        "ASUN" "FG" 1;
        "M901" B 1;
        "ASUN" "GHI" 1;
        "M901" "CCCC" 1;
        "M901" "DE" 2;
        "M901" "FFFFF" 1;
        "ASUN" "IHG" 1;
        "M901" B 1;
        "ASUN" "GF" 1;
        "M901" A 1;
        "ASUN" "ECDBA" 1;
        TNT1 A 0 A_GiveInventory("Pumping", 1);
        Goto RemoveBullets;

		RemoveBullets:
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",1,2);
        Goto FinishUnload;
        TNT1 A 0 A_TakeInventory("PB_FusilMag",1);
        TNT1 A 0 A_GiveInventory("PB_HighCalMag",1);
        Goto RemoveBullets;

		FinishUnload:
        "SIDE" A 2;
        TNT1 A 0 A_PlaySound("DryFire");
        TNT1 A 0 PB_SetMagUnloaded(true);
        Goto Ready3;

		WeaponSpecial:
        "SIDE" A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
        "SIDE" A 0 A_TakeInventory("Zoomed",1);
        "SIDE" A 0 A_TakeInventory("ADSmode",1);
        "SIDE" A 0 A_TakeInventory("UseEquipment", 1);
        "SIDE" A 0 A_TakeInventory("Kicking",1);
        "SIDE" A 0 A_TakeInventory("Taunting",1);
        "SIDE" A 0 A_TakeInventory("Reloading",1);
        "SIDE" A 0 A_TakeInventory("Unloading",1);
        "SIDE" A 0 A_ZoomFactor(1.0);
        "SIDE" A 0 A_SelectWeapon("PB_Fusil");
        Goto Ready3;

		FlashPunching:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "YXEDCCCDEXY" 1;
        TNT1 A 0 A_WeaponOffset(0, 32);
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashKicking:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "YXEDCCCCCCDEXY" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashAirKicking:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "YXEDCBBBBBCDEXY" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashSlideKicking:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "YXEDCBBBBBBBCDEXY" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashSlideKickingStop:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "YXEDCBA" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		Spawn:
        "UPDT" A -1;
        Stop;
	}
}
