// PB_Fusil - ZScript port (DECORATE PB_Weapon retired).

class PB_Fusil : PB_WeaponBase
{
	default
	{
		// Game Doom (DECORATE only)
    Weapon.AmmoUse1 0;
    Weapon.AmmoGive1 20;
    Weapon.AmmoUse2 0;
    Weapon.AmmoGive2 24;
    Weapon.SlotNumber 4;
    Weapon.SlotPriority 0.18;
    Weapon.AmmoType1 "PB_HighCalMag";
    Weapon.AmmoType2 "PB_FusilMag";
    Obituary "%o was shot down by %k's Fusil.";
    AttackSound "None";
    Weapon.SelectionOrder 2450;
    +WEAPON.NOAUTOAIM;
    +WEAPON.NOALERT;
    +WEAPON.NOAUTOFIRE;
    +FORCEXYBILLBOARD;
    +WEAPON.NO_AUTO_SWITCH;
    +FLOORCLIP;
    +DONTGIB;
    Inventory.PickupSound "CLIPIN";
    Inventory.PickupMessage "$PB_PICKUP_PB_Fusil";
    Inventory.Icon "FUSIF0";
    Inventory.AltHUDIcon "FUSIF0";
    PB_WeaponBase.respectItem "PB_FusilSeen";
    Scale 1.0;
    Tag "Fusil";
	}
	states
	{
		Steady:
        TNT1 A 1;
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 SetPlayerProperty(0,0,0);
        TNT1 A 0 SetPlayerProperty(0,0,PROP_TOTALLYFROZEN);
        Goto Ready3;

		ReadySeen:
        "RPTG" A 0 A_PlaySound("CLIPIN");
        "FUSI" "ABCDE" 1 A_WeaponReady;
        Goto RealReady;

		Ready:
        Goto Ready3;

		RealReady:
		Ready3:
        TNT1 A 0 { PB_RespectIfNeeded(); }
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
            A_OverlayScale(PSP_WEAPON,1.0,1.0);
        }
        TNT1 A 0 A_SetCrosshair(0);
        TNT1 A 0 PB_WeapTokenSwitch("RifleSelected");
        TNT1 A 0 A_JumpIfInventory("Zoomed",1,"Ready2");
        "RPTG" A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        "RPTG" A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
        Loop;

		Deselect:
        "RPTG" A 0;
        "RPTG" A 0 A_TakeInventory("Zoomed",1);
        "RPTG" A 0 A_TakeInventory("UseEquipment", 1);
        "RPTG" A 0 A_TakeInventory("ADSmode",1);
        "RPTG" A 0 A_TakeInventory("Kicking",1);
        "RPTG" A 0 A_TakeInventory("Taunting",1);
        "RPTG" A 0 A_TakeInventory("Reloading",1);
        "RPTG" A 0 A_TakeInventory("Unloading",1);
        "RPTG" A 0 A_TakeInventory("Salute1", 1);
        "RPTG" A 0 A_TakeInventory("Salute2", 1);
        "RPTG" A 0 A_ZoomFactor(1.0);
        "RPTG" A 0 A_OverlayScale(PSP_WEAPON,1.0,1.0);
        "FUSI" "EDCBA" 1;
        TNT1 A 0 A_Lower(120);
        Wait;

		Select:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
            A_OverlayScale(PSP_WEAPON,1.0,1.0);
        }
        Goto SelectFirstPersonLegs;
		SelectContinue:
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 PB_WeaponRaise("MOVIN");
        TNT1 A 0 A_GiveInventory("PB_SideFusil", 1);
        TNT1 A 0 PB_WeapTokenSwitch("RifleSelected");
			TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
			Goto Ready3;
		SelectAnimation:
        TNT1 A 0 A_PlaySound("CLIPIN");
        "RPTG" "AAAAAAAAA" 4 A_WeaponReady;
        "MIRA" "CCCBBB" 1 A_WeaponReady;
        "MIRA" "AAAAAAAAAAA" 2 A_WeaponReady;
        "MIRA" "BC" 2 A_WeaponReady;
        Goto Ready3;

		WeaponRespect:
        TNT1 A 0 A_GiveInventory("PB_FusilSeen", 1);
        "FUSI" "ABCDE" 1 A_WeaponReady;
        Goto SelectAnimation;

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
        TNT1 A 0 A_JumpIfInventory("Zoomed",1,"Fire2");
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",1,2);
        Goto Reload;
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(44);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
        }
        TNT1 A 0 A_TakeInventory("PB_FusilMag",1);
        TNT1 A 0 A_FireCustomMissile("SmokeSpawner",0,0,0,5);
        TNT1 A 0 A_FireCustomMissile("YellowFlareSpawn",-5,0,0,0);
        "RPTF" A 1 {
            A_StartSound("MG42FIR", CHAN_WEAPON, CHANF_OVERLAP, 1.0, 0, frandom(0.98, 1.02));
            A_SetPitch(-1.2 + pitch);
        }
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        "RPTF" B 1 BRIGHT A_AlertMonsters();
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        TNT1 A 0 A_FireCustomMissile("PBWP_Tracer_Rifle", random(-2, 2), 0, -1, 0, 0, random(-2, 2));
        "RPTF" C 1 A_FireBullets (4, 3, -1, 12, "HitPuff");
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        "RPTF" D 1 A_FireCustomMissile("RifleCaseSpawn",-5,0,8,-4);
        "RPTF" E 1;
        "RPTF" F 1;
        TNT1 A 0 A_Refire;
        Goto Ready3;

		Fire2:
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
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",1,2);
        Goto Reload;
        TNT1 A 0 A_FireCustomMissile("SmokeSpawner",0,0,0,5);
        TNT1 A 0 A_FireCustomMissile("YellowFlareSpawn",-5,0,0,0);
        "SHGA" K 1 {
            A_TakeInventory("PB_FusilMag",1);
            A_StartSound("MG42FIR", CHAN_WEAPON, CHANF_OVERLAP, 1.0, 0, frandom(0.98, 1.02));
            A_SetPitch(-1.2 + pitch);
        }
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        "SHGA" K 1 BRIGHT A_AlertMonsters();
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        TNT1 A 0 A_FireCustomMissile("PBWP_Tracer_Rifle", random(-2, 2), 0, -1, 0, 0, random(-2, 2));
        "SHGA" K 1 A_FireBullets (1.5, 1.5, -1, 12, "HitPuff");
        TNT1 A 0 A_SetPitch(-1.0 + pitch);
        "SHGA" A 1 A_FireCustomMissile("RifleCaseSpawn",-5,0,8,-4);
        TNT1 A 0 A_SetPitch(-0.5 + pitch);
        "SHGA" K 1;
        "SHGA" A 1;
        TNT1 A 0 A_SetPitch(+0.5 + pitch);
        TNT1 A 0 {
            if (GetCvar("pb_toggle_aim_hold"))
            {
                if (!PressingAltfire() || JustReleased(BT_ALTATTACK))
                {
                    return ResolveState("StopAim");
                }
                if (PressingFire() && PressingAltfire() && CountInv("PB_FusilMag") > 0) {
                    return ResolveState("Fire2");
                }
            }
            else
            {
                if (PressingAltfire())
                {
                    return ResolveState("StopAim");
                }
                A_Refire("Fire2");
            }
            return ResolveState(null);
        }
        Goto Ready2;

		Ready2:
        TNT1 A 0 {
            A_WeaponOffset(-2,32);
            A_SetRoll(0);
            PB_HandleCrosshair(98);
            A_TakeInventory("PB_LockScreenTilt",1);
        }
        TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
        TNT1 A 0 A_JumpIfInventory("PB_FusilMag",1,2);
        Goto Reload;
        SHGA A 6 { return PB_ReadyFire("Fire2", "Fire2", "StopAim", true, true); }
        SHGA B 6 { return PB_ReadyFire("Fire2", "Fire2", "StopAim", true, true); }
        SHGA C 6 { return PB_ReadyFire("Fire2", "Fire2", "StopAim", true, true); }
        SHGA D 6 { return PB_ReadyFire("Fire2", "Fire2", "StopAim", true, true); }
        Loop;

		AltFire:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("Zoomed",1,"StopAim");
        TNT1 A 0 A_GiveInventory("Zoomed",1);
        TNT1 A 0 A_ZoomFactor(1.3);
        TNT1 A 0 A_GiveInventory("ADSmode",1);
        "MIRA" "CB" 2;
        Goto Ready2;

		StopAim:
        "MIRA" A 2;
        TNT1 A 0 A_TakeInventory("Zoomed",1);
        TNT1 A 0 A_ZoomFactor(1.0);
        TNT1 A 0 A_TakeInventory("ADSmode",1);
        TNT1 A 0 A_OverlayScale(PSP_WEAPON,1.0,1.0);
        Goto Ready3;

		Reload:
        TNT1 A 0 {
            A_WeaponOffset(0,32);
            A_SetRoll(0);
            PB_HandleCrosshair(5);
            A_TakeInventory("PB_LockScreenTilt",1);
            A_ClearOverlays(10,11);
            A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
            A_OverlayScale(PSP_WEAPON,1.0,1.0);
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
        TNT1 A 0 PB_JumpIfMagUnloaded("FusilReloadMagIn");
        TNT1 A 0 A_FireCustomMissile("EmptyClipSpawn",-5,0,8,-4);
        TNT1 A 0 A_PlaySound("Reload");
        "M901" "FFFFFFFFF" 2;
        TNT1 A 0 A_PlaySound("RIFCL_CL", 3);
        TNT1 A 0 PB_SetMagUnloaded(false);
		FusilReloadMagIn:
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
            A_OverlayScale(PSP_WEAPON,1.0,1.0);
        }
        "RPTG" A 1 A_WeaponReady;
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
        "RPTG" A 2;
        TNT1 A 0 A_PlaySound("DryFire");
        TNT1 A 0 PB_SetMagUnloaded(true);
        Goto Ready3;

		PDA_Preview_Fusil_Hip:
        "RPTF" A 2 Bright;
        "RPTF" B 2;
        "RPTF" C 2;
        "RPTF" D 2;
        "RPTF" "GHI" 2;
        Stop;

		PDA_Preview_Fusil_ADS:
        "SHGA" K 2 Bright;
        "SHGA" A 2;
        "SHGA" "BCD" 2;
        Stop;

		PDA_Preview_Fusil_ModeSwap:
        "ANIM" A 2;
        "ANIM" C 2;
        "ANIM" E 2;
        "ANIM" G 2;
        "ANIM" I 2;
        "ANIM" J 2;
        "ANIM" K 2;
        "ANIM" L 2;
        "ANIM" M 2;
        "ANIM" N 2;
        Stop;

		PDA_Preview_Fusil_Sidearm:
        "SIDE" A 2;
        "SIDE" B 2;
        "SIDE" C 2;
        "SIDE" D 2;
        "SIDE" "CBA" 2;
        Stop;

		PDA_Preview_Fusil_Reload:
        "ASUN" "ABCDE" 2;
        "M201" "DEF" 2;
        "ASUN" "IHG" 2;
        "ASUN" "GF" 2;
        "M201" A 2;
        "ASUN" "ECDBA" 2;
        Stop;

		Spawn:
        "FUSI" F -1;
        Stop;

		DualWield:
        TNT1 A 0;
        Goto WeaponSpecial;

		WeaponSpecial:
        "SIDE" A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
        "SIDE" A 0 A_TakeInventory("Zoomed",1);
        "SIDE" A 0 A_TakeInventory("ADSmode",1);
        "SIDE" A 0 A_TakeInventory("UseEquipment", 1);
        "SIDE" A 0 A_TakeInventory("Kicking",1);
        "SIDE" A 0 A_TakeInventory("Taunting",1);
        "SIDE" A 0 A_TakeInventory("Reloading",1);
        "SIDE" A 0 A_TakeInventory("Unloading",1);
        "SIDE" A 0 A_TakeInventory("Salute1", 1);
        "SIDE" A 0 A_TakeInventory("Salute2", 1);
        "SIDE" A 0 A_ZoomFactor(1.0);
        "SIDE" A 0 A_OverlayScale(PSP_WEAPON,1.0,1.0);
        "SIDE" A 0 A_GiveInventory("PB_SideFusil", 1);
        "SIDE" A 0 A_SelectWeapon("PB_SideFusil");
        Goto Ready3;

		NoAmmo:
        "RPTG" A 1;
        TNT1 A 0 A_PlaySound("DRYFIRE");
        Goto Ready3;

		FlashPunching:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "EDCCDE" 1;
        TNT1 A 0 A_WeaponOffset(0, 32);
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashKicking:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "EDCCCCDE" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashAirKicking:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "EDCBBBCDE" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashSlideKicking:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "EDCBBBBBBBCDE" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;

		FlashSlideKickingStop:
        TNT1 A 0 A_ClearOverlays(10,11);
        "FUSI" "EDCBA" 1;
        TNT1 A 0 A_ClearOverlays(PSP_FLASH, PSP_FLASH, false);
        Goto Ready3;
	}
}
