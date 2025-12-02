

Class HeavySniperRifle : PBWP_Weapon
{
	default
	{
		weapon.slotnumber 4;
		Tag "UAC-50S Heavy Sniper Rifle - Daemon Murderer";
		inventory.pickupsound "CLIPIN";
		inventory.pickupmessage "\cj UAC-50S Heavy Sniper Rifle \ck:-{Daemon Murderer}-:! \cj(Slot 4, Overpowered)";
		weapon.ammotype1 "PB_HighCalMag";
		weapon.ammogive1 20;
		weapon.ammotype2 "MetalSniperAmmo";
		PB_WeaponBase.unloadertoken "SniperUnloaded"; 
		PB_WeaponBase.respectItem "MetalSniperRespect";
		PB_WeaponBase.UsesWheel true;
		PB_WeaponBase.WheelInfo "MetalSniperWheel";
		scale 0.62;
		+weapon.noalert;
		+weapon.noautofire;
		+weapon.noautoaim;
	}
	
	bool grenadeloaded;
	bool AltMode;
	bool isZooming;
	bool ExplosiveMode;
	const SniperMode = 0;
	const GrenadeMode = 1;
	const NormalMode = 2;
	const ExplosiveMod = 3;
	const muzzlelayer = -52;
	states
	{
		Spawn:
			MSNW A -1;
			stop;
		
		Steady:
			TNT1 A 1;
			Goto Ready;
		
		WeaponRespect:	//no respect yet
			MSNI ABCD 1 A_DoPBWeaponAction();
			MSNI EFGH 1 A_DoPBWeaponAction();
			MSNI IJKL 1 A_DoPBWeaponAction();
			MSNI MNOP 1 A_DoPBWeaponAction();
			MSNI QRS 1 A_DoPBWeaponAction();
			TNT1 A 0 A_JumpIfInventory("INMGUpgrade",1,"ChangeNow"); //Triggering To Changing The Explosive Immediately!
			MSNI TUVWX 1 A_DoPBWeaponAction();
			MSNI YZ 1 A_DoPBWeaponAction();
			MSNJ AAB 1 A_DoPBWeaponAction();
			TNT1 A 0 A_startsound("MS/BoltDown",24);
			MSNJ BCDEEF 1 A_DoPBWeaponAction();
			TNT1 A 0 A_startsound("MS/BoltUp",25);
			MSNJ GHIJKL 1 A_DoPBWeaponAction();
			goto ready3;
		
		Select:
			TNT1 A 0 A_weaponoffset(0,32);
			goto SelectFirstPersonLegs;
		SelectContinue:
			TNT1 A 0 PB_WeapTokenSwitch("RifleSelected");
			TNT1 A 0 PB_RespectIfNeeded();
		SelectAnimation:
			TNT1 A 0 A_zoomfactor(1.0);
			TNT1 A 0 A_setroll(0);
			TNT1 A 0 A_startsound("MS/Up",29);
			MSNU ABCD 1;
			TNT1 A 0 A_jumpif(invoker.ExplosiveMode,"Ready3");
			TNT1 A 0 A_JumpIfInventory("INMGUpgrade",1,"ChangeNow");
			goto ready3;
		Deselect:
			TNT1 A 0 cleanmodetokens();
			TNT1 A 0 PB_CheckBarrelPlace1();
			TNT1 A 0 A_Zoomfactor(1.0);
			TNT1 A 0 A_takeinventory("Zoomed",10);
			TNT1 A 0 setZoom(false);
			MSND ABCD 1;
			TNT1 A 0 A_lower;
			wait;
		
		ChangeNow:
			TNT1 A 0 HSR_SetMode(ExplosiveMod);
			MSU1 ABCD 1;
			MSU1 EFGH 1;
			MSU1 IJKL 1;
			MST1 ABCD 1;
			TNT1 A 0 A_startsound("MS/Button",22);
			MST1 E 1;
			TNT1 A 0 A_startsound("MS/TakeMag",23);
			MST1 FGH 1;
			MST1 IJKL 1;
			MSNR ABCD 1;
			MSNR EFG 1;
			TNT1 A 0 A_startsound("MS/InsertMag",20);
			MSNR HIJKL 1;
			MSNR MNOPQ 1;
			MSNR QR 1;
			//lower
			MSU1 LKJIHGFEDCBA 1;
			Goto Ready3;
		
		Ready:
		Ready3:
			TNT1 A 0 A_jumpif(countinv("zoomed") > 0,"Ready_ADS");
			MSNF A 1 {
				PB_CoolDownBarrel(-4,0,6,0,1);
				PB_CoolDownBarrel(4,0,6,0,-1);
				return A_DoPBWeaponAction(WRF_ALLOWRELOAD);
			}
			loop;
		
		Fire:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "ThrowIceBarrel");

			TNT1 A 0 PB_CheckAmmoFire(1);
			TNT1 A 0 A_jumpifinventory("zoomed",1,"Fire_ADS");
			TNT1 A 0 A_jumpif(invoker.ExplosiveMode,"FireExp");
			MSNF B 1 bright {
				A_AlertMonsters();
				A_overlay(muzzlelayer,"MuzzleFlash");
				A_startsound("MS/Fire",20,CHANF_OVERLAP);
			
				PB_DynamicTail("lmg", "lmg");
				A_FireProjectile("IN_105x68mmHAR", frandom(-0.2,0.2),0,0,0, FPF_NOAUTOAIM, frandom(-0.1,0.1));
				PB_LowAmmoSoundWarning("sniper");
				A_takeinventory(invoker.ammotype2,1);
				PB_IncrementHeat(4);
				PB_IncrementHeat(4,true);
				PB_FireOffset();
				PB_WeaponRecoil(-4,frandom(-1.5,1.5));
			}
			MSNF C 1 bright {
				PB_GunSmoke(0,0,-2);
				PB_SpawnCasing("LMGCasingStandard",26,2,28,0,Frandom(5,8),Frandom(1,4));
				PB_WeaponRecoil(-3,frandom(-0.5,0.5));
			}
			MSNF DDDEF 1;
			MSNF GHAAAAAAAAAA 1 A_Jumpif(PlayerPressedOnce(BT_ATTACK),"Fire");
			TNT1 A 0 A_refire("Fire");
			goto ready3;
			
		FireExp:
			TNT1 A 0 A_jumpifinventory("zoomed",1,"Fire_ADS");
			MSNF B 1 bright {
				A_AlertMonsters();
				A_overlay(muzzlelayer,"MuzzleFlash");
				A_startsound("MS/Fire",20,CHANF_OVERLAP);
				A_startsound("DSRMFIRE",30,CHANF_OVERLAP);
			
				PB_DynamicTail("lmg", "lmg");
				PB_FireBullets("HMGExplosiveProjectile",2,0,0,0,0);
				A_FireProjectile("IN_105x68mmHAR", frandom(-0.2,0.2),0,0,0, FPF_NOAUTOAIM, frandom(-0.1,0.1));
				PB_LowAmmoSoundWarning("sniper");
				A_takeinventory(invoker.ammotype2,1);
				PB_IncrementHeat(5);
				PB_IncrementHeat(5,true);
				PB_FireOffset();
				PB_WeaponRecoil(-4,frandom(-1.5,1.5));
			}
			MSNF C 1 bright {
				PB_GunSmoke(0,0,-2);
				PB_SpawnCasing("LMGCasingStandard",26,2,28,0,Frandom(5,8),Frandom(1,4));
				PB_WeaponRecoil(-3,frandom(-0.5,0.5));
			}
			MSNF DDDEF 1;
			MSNF GHAAAAAAAAAA 1 A_Jumpif(PlayerPressedOnce(BT_ATTACK),"Fire");
			TNT1 A 0 A_refire("Fire");
			goto ready3;
		
		AltFire:
			TNT1 A 0 PB_CheckBarrelPlace1();
			TNT1 A 0 A_jumpif(MS_getmode() == GrenadeMode,"AltFire_Grenade");
		AltFire_Zoom:
			TNT1 A 0 A_Jumpif(countinv("Zoomed") > 0 && iszoom(),"ZoomOut");
		ZoomIn:
			TNT1 A 0 A_giveinventory("Zoomed",1);
			TNT1 A 0 setZoom(true);
			TNT1 A 0 A_startsound("IronSights",29);
			MSNA A 1 A_zoomfactor(1.1);
			MSNA B 1 A_zoomfactor(1.5);
			MSNA C 1 A_zoomfactor(1.8);
			MSNA D 1 A_zoomfactor(2.0);
			MSNA E 1 A_zoomfactor(2.2);
			MSNA F 1 A_zoomfactor(2.5);
			goto Ready_ADS;
		ZoomOut:
			TNT1 A 0 A_takeinventory("Zoomed",1);
			TNT1 A 0 setZoom(false);
			TNT1 A 0 A_startsound("IronSights",29);
			MSNA F 1 A_zoomfactor(2.4);
			MSNA E 1 A_zoomfactor(2.2);
			MSNA D 1 A_zoomfactor(2.0);
			MSNA C 1 A_zoomfactor(1.8);
			MSNA B 1 A_zoomfactor(1.5);
			MSNA A 1 A_zoomfactor(1.0);
			goto ready3;
			
		Ready_ADS:
			TNT1 A 0;
			MSNS A 1 {
				A_SetRoll(0);
				A_SetCrosshair(5);
				PB_CoolDownBarrel(-5,0,7,0,1);
				PB_CoolDownBarrel(5,0,7,0,-1);
				A_SetInventory("PB_LockScreenTilt",0);
				if(Cvar.GetCvar("pb_toggle_aim_hold",player).getint() == 1) 
				{
					if(!PressingAltfire() || JustReleased(BT_ALTATTACK))
						return resolvestate("Zoomout");
					
					if (PressingFire() && PressingAltfire() && CountInv("MetalSniperAmmo") > 0)
							return resolvestate("Fire_ADS");
					
					return A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOSECONDARY, CheckUnloaded("SniperUnloaded"));
					
				}
				else 
				{
					if (PressingFire() && CountInv("MetalSniperAmmo") > 0)
						return resolvestate("Fire_ADS");
					
					return A_DoPBWeaponAction(WRF_ALLOWRELOAD, CheckUnloaded("SniperUnloaded"));
				}
				return resolvestate(null);
			}
			loop;
			
		Fire_ADS:
			TNT1 A 0 PB_CheckAmmoFire(1,"ReloadFromADS");
			TNT1 A 0 A_jumpif(invoker.ExplosiveMode,"FireExp_ADS");
		ActualFireADS:
			MSNS B 1 bright 
			{
				A_weaponoffset(0,32);
				A_AlertMonsters();
				A_startsound("MS/Fire",20,CHANF_OVERLAP);
				PB_DynamicTail("lmg", "lmg");
				A_overlay(muzzlelayer,"MuzzleFlash_ADS");
				A_FireProjectile("IN_105x68mmHAR", frandom(-0.1,0.1),0,0,0, FPF_NOAUTOAIM, frandom(-0.1,0.1));
				PB_LowAmmoSoundWarning("sniper");
				A_takeinventory(invoker.ammotype2,1);
				A_SetInventory("CantDoAction",1);
				PB_IncrementHeat(4);
				PB_IncrementHeat(4,true);
			}
		FireADSContinue:
			MSNS C 1 bright {
				PB_FireOffset();
				PB_GunSmoke(0,0,-2);
				PB_WeaponRecoil(-5,frandom(-1.5,1.5));
				PB_SpawnCasing("LMGCasingStandard",26,2,28,0,Frandom(5,8),Frandom(1,4));
				}
			MSNS DDD 1;
			MSNS EFG 1;
			MSNS HIAAAAAAAAAA 1
			{
				A_SetInventory("CantDoAction",0);
				 
				if(Cvar.GetCvar("pb_toggle_aim_hold",player).getint()) 
				{
					if(JustReleased(BT_ALTATTACK))
						return resolvestate("Zoomout");
					if (JustPressed(BT_ATTACK) && PressingAltfire())
							return resolvestate("Fire_ADS");
				}
				else 
				{
					if(PressingAltfire())
						return resolvestate("Zoomout");
					if (JustPressed(BT_ATTACK))
							return resolvestate("Fire_ADS");
					A_Refire("Fire_ADS");
				}
				return A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOFIRE);
			}
			Goto Ready_ADS;
			
		FireExp_ADS:
			MSNS B 1 bright 
			{
				A_weaponoffset(0,32);
				A_AlertMonsters();
				A_startsound("MS/Fire",20,CHANF_OVERLAP);
				A_startsound("DSRMFIRE",30,CHANF_OVERLAP);
				PB_DynamicTail("lmg", "lmg");
				A_overlay(muzzlelayer,"MuzzleFlash_ADS");
				PB_FireBullets("HMGExplosiveProjectile",2,0,0,0,0);
				A_FireProjectile("IN_105x68mmHAR", frandom(-0.1,0.1),0,0,0, FPF_NOAUTOAIM, frandom(-0.1,0.1));
				PB_LowAmmoSoundWarning("sniper");
				A_takeinventory(invoker.ammotype2,1);
				A_SetInventory("CantDoAction",1);
				PB_IncrementHeat(5);
				PB_IncrementHeat(5,true);
			}
		FireExpADSContinue:
			MSNS C 1 bright {
				PB_FireOffset();
				PB_GunSmoke(0,0,-2);
				PB_WeaponRecoil(-5,frandom(-1.5,1.5));
				PB_SpawnCasing("LMGCasingStandard",26,2,28,0,Frandom(5,8),Frandom(1,4));
				}
			MSNS DDD 1;
			MSNS EFG 1;
			MSNS HIAAAAAAAAAA 1
			{
				A_SetInventory("CantDoAction",0);
				 
				if(Cvar.GetCvar("pb_toggle_aim_hold",player).getint()) 
				{
					if(JustReleased(BT_ALTATTACK))
						return resolvestate("Zoomout");
					if (JustPressed(BT_ATTACK) && PressingAltfire())
							return resolvestate("FireExp_ADS");
				}
				else 
				{
					if(PressingAltfire())
						return resolvestate("Zoomout");
					if (JustPressed(BT_ATTACK))
							return resolvestate("FireExp_ADS");
					A_Refire("FireExp_ADS");
				}
				return A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOFIRE);
			}
			Goto Ready_ADS;
			
		AltFire_Grenade:
			MSNG A 1 {
				PB_CoolDownBarrel(-4,0,6,0,1);
				PB_CoolDownBarrel(4,0,6,0-1);
				if(PlayerPressedOnce(BT_ATTACK))
				{
					if(getgrenqtty() > 0)
						return resolvestate("FireGrenade");
					else
						return resolvestate("Reload_Grenade");
				}
				return resolvestate(null);
			}
			TNT1 A 0 A_refire("AltFire_Grenade");
			goto ready3;
			
		FireGrenade:
			TNT1 A 0 A_overlay(muzzlelayer,"MuzzleFlash_Gren");
			TNT1 A 0 A_AlertMonsters();
			TNT1 A 0 A_startsound("RFGLLCH",20);
			MSNG B 1 bright A_Fireprojectile("PB_FragGrenade",0,0);
			TNT1 A 0 MS_SetGrenadeQ(0);
			TNT1 A 0 PB_FireOffset();
			TNT1 A 0 PB_GunSmoke(0,0,-2);
			TNT1 A 0 PB_WeaponRecoil(-3,frandom(-1.5,1.5));
			MSNG C 1 bright;
			MSNG D 1;
			MSNG E 1;
			MSNG FG 1;
			MSNG A 1;
			TNT1 A 0 A_jumpif(countinv("PB_RocketAmmo") > 0,"Reload_grenade");
			goto ready3;
		
		Reload_Grenade:
			MSNL ABCDEFGGG 1;
			TNT1 A 0 A_startsound("MS/GrenOpen",21);
			MSNL G 1;
			TNT1 A 0 PB_SpawnCasing("EmptyGrenadeBrass", 30, -2, 34, frandom(1.0, 2.0), frandom(-4.0,-2.0), 1.0);
			MSNL HIJKLMN 1;
			TNT1 A 0 {
				if(countinv("PB_RocketAmmo") > 0)
				{
					MS_SetGrenadeQ(1);
					A_takeinventory("PB_RocketAmmo",1);
				}
				A_startsound("MS/GrenClose",22);
			}
			MSNL OPQRSTU 1;
			MSNL GGG 1;
			MSNL FEDCBA 1;
			TNT1 A 0 A_refire("AltFire_Grenade");
			goto ready3;
		
		ReloadFromADS:
			TNT1 A 0 A_Zoomfactor(1.0);
			TNT1 A 0 A_takeinventory("Zoomed",10);
		Reload:
			TNT1 A 0 A_Zoomfactor(1.0);
			TNT1 A 0 A_takeinventory("Zoomed",10);
			TNT1 A 0 setZoom(false);
			TNT1 A 0 {
				int amr = countinv(invoker.ammotype2);	//mag
				int res = countinv(invoker.ammotype1);	//reserve
				
				if(res < 2)
					return resolvestate("Ready3");	//noammo
				
				if(amr >= 11)
					return resolvestate("Inspecting");
				
				if(findinventory(invoker.UnloaderToken))
					return resolvestate("RaiseFromEmpty");
				
				if(amr < 1)
					return resolvestate("ReloadEmpty");
					
				return resolvestate(null);
					
			}
			TNT1 A 0 A_Takeinventory("Unloading",10);
			TNT1 A 0 A_setinventory(invoker.UnloaderToken,0);
			//raise
			TNT1 A 0 A_startsound("IronSights",30);
			MSU1 ABCD 1;
			MSU1 EFGH 1;
			MSU1 IJKL 1;
			//take
			MST1 ABCD 1;
			TNT1 A 0 A_startsound("MS/Button",22);
			MST1 E 1;
			TNT1 A 0 A_startsound("MS/TakeMag",23);
			MST1 FGH 1;
			MST1 IJKL 1;
			//insert
			MST1 L 9;
			MSNR ABCD 1;
			MSNR EFG 1;
			TNT1 A 0 A_startsound("MS/InsertMag",20);
			MSNR HIJKL 1;
			TNT1 A 0 PB_AmmoIntoMag("MetalSniperAmmo","PB_HighCalMag",11,2);
			MSNR MNOP 1;
			MSNR QR 1;
			//lower
			MSU1 LKJIHGFEDCBA 1;
			goto ready3;
		
		ReloadEmpty:
			TNT1 A 0 A_Takeinventory("Unloading",10);
			TNT1 A 0 A_setinventory(invoker.UnloaderToken,0);
			TNT1 A 0 A_startsound("IronSights",30);
			MSU1 ABCD 1;
			MSU1 EFGH 1;
			MSU1 IJKL 1;
			//take
			MST0 ABCD 1;
			TNT1 A 0 A_startsound("MS/Button",22);
			MST0 E 1;
			TNT1 A 0 A_startsound("MS/TakeMag",23);
			MST0 FGH 1;
			MST0 IJKL 1;
			TNT1 A 0 PB_SpawnCasing("EmptyDMRMag",38,26,7,frandom(0.5, 3.5),frandom(2.3,4.2),frandom(1.0,2.0));
			MST0 L 9;
		InsertFromEmpty:
			//insert
			TNT1 A 0 A_setinventory(invoker.UnloaderToken,0);
			MSNR ABCD 1;
			MSNR EFG 1;
			TNT1 A 0 A_startsound("MS/InsertMag",20);
			TNT1 A 0 PB_AmmoIntoMag("MetalSniperAmmo","PB_HighCalMag",10,2);
			MSNR HIJKL 1;
			MSNR MNOPQ 1;
			//rechamber
			MSNC ABCD 1;
			MSNC EFG 1;
			TNT1 A 0 A_startsound("MS/BoltDown",24);
			MSNC HIJKL 1;
			TNT1 A 0 A_startsound("MS/BoltUp",25);
			MSNC M 1;
			MSU1 LKJIHGFEDCBA 1;
			goto ready3;
			
		RaiseFromEmpty:
			TNT1 A 0 A_startsound("IronSights",30);
			MSU0 ABCD 1;
			MSU0 EFGH 1;
			MSU0 IJKL 1;
			goto InsertFromEmpty;
			
		Inspecting:
			TNT1 A 0 A_startsound("IronSights",30);
			MSU1 ABCD 1;
			MSU1 EFGH 1;
			MSU1 IJKL 1;
			MSNC ABCD 1;
			MSNC EFG 1;
			TNT1 A 0 A_startsound("MS/BoltDown",24);
			MSNC HIJKL 1;
			TNT1 A 0 A_startsound("MS/BoltUp",25);
			MSNC M 1;
			MSU1 LKJIHGFEDCBA 1;
			goto ready3;
			
		Unload:
			TNT1 A 0 A_Takeinventory("Unloading",1);
			TNT1 A 0 A_Jumpif(countinv(invoker.UnloaderToken) > 0 || countinv(invoker.ammotype2) < 1,"Ready3");
			TNT1 A 0 A_giveinventory(invoker.UnloaderToken,1);
			
			TNT1 A 0 A_startsound("IronSights",30);
			MSU1 ABCD 1;
			MSU1 EFGH 1;
			MSU1 IJKL 1;
			MST1 ABCD 1;
			TNT1 A 0 A_startsound("MS/Button",22);
			MST1 E 1;
			TNT1 A 0 PB_UnloadMag("MetalSniperAmmo","PB_HighCalMag",2);
			TNT1 A 0 A_startsound("MS/TakeMag",23);
			MST1 FGH 1;
			MST1 IJKL 1;
			
			MSU0 LKJIHGFEDCBA 1;
			goto ready3;
		
		
		//
		WeaponSpecial:
			TNT1 A 0 A_takeinventory("GoWeaponSpecialAbility",1);
			TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "IdleBarrel");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "IdleIceBarrel");
			TNT1 A 0 {
				A_Takeinventory("GoWeaponSpecialAbility",1);
				A_Takeinventory("Zoomed",1);
				A_Takeinventory("ADSmode",1);
				A_ZoomFactor(1.0);
			}
			TNT1 A 0 {
				if((findinventory("MS_Select_AimMode") && MS_getmode() == 0) || 
				(findinventory("MS_Select_GrenMode") && MS_getmode() == 1))
				{
					A_print("Mode already selected");
					cleanmodetokens();
					return resolvestate("ready3");
				}
				
				if(findinventory("MS_Select_AimMode"))
				{
					MS_SetMode();
					A_SetInventory("MS_GrenMode",0);
					A_print("Aim secondary mode");
				}
				
				if(findinventory("MS_Select_GrenMode"))
				{
					MS_SetMode(GrenadeMode);
					A_SetInventory("MS_GrenMode",1);
					A_print("Grenade secondary mode");
				}
				
				return resolvestate(null);
			}
		ChangeAnim:
			TNT1 A 0 cleanmodetokens();
			TNT1 A 0 A_startsound("IronSights",30);
			MSSW ABCDEFF 1;
			TNT1 A 0 A_startsound("MS/Button",26);
			MSSW GHIJKLM 1;
			goto ready;
			
		MuzzleFlash:
			TNT1 A 0 A_overlayFlags(overlayID(),PSPF_MIRROR|PSPF_FLIP,random(0,1));
			TNT1 A 0 A_jump(128,"MF2");
			MSNM AB 1 bright;
			stop;
		MF2:
			MSNM AC 1 bright;
			stop;
		MuzzleFlash_ADS:
			TNT1 A 0 A_overlayFlags(overlayID(),PSPF_MIRROR|PSPF_FLIP,random(0,1));
			TNT1 A 0 A_jump(128,"MFADS2");
			MSNM DE 1 bright;
			stop;
		MFADS2:
			MSNM DF 1 bright;
			stop;
		MuzzleFlash_Gren:
			TNT1 A 0 A_overlayFlags(overlayID(),PSPF_MIRROR|PSPF_FLIP,random(0,1));
			MSNM G 1 bright;
			stop;
			
		FlashPunching:
			MSNQ ABCDEFGHFEDCBA 1; //14 frames
			stop;
		
		FlashKicking:
			MSNK ABCDEFGHGFEDCBA 1; //15 frames
			goto ready3;
			
		FlashAirKicking:
			MSNQ ABCDEFGHHGFEDCBA 1; //16 frames
			goto ready3;
			
		FlashSlideKicking:
			MSNK ABCDEFGHHHHHHHHHHHHHGFEDCBA 1; //27 frames
			goto ready3;
			
		FlashSlideKickingStop:
			MSNK GFEDCBA 1; //7 frames 
			goto ready3;
		
	}
	
	action bool iszoom()
	{
		return invoker.isZooming;
	}
	
	action void setZoom(bool set = false)
	{
		invoker.isZooming = set;
	}
	
	Action state PB_CheckAmmoFire(int min = 1, statelabel Relstate = "Reload")
	{
		if(countinv(invoker.ammotype2) < min)
			return resolvestate(Relstate);
		return resolvestate(null);
	}
	
	action void MS_SetGrenadeQ(bool q = 0)
	{
		invoker.grenadeloaded = q;
	}
	
	action int getgrenqtty()
	{
		return invoker.grenadeloaded;
	}
	
	action bool MS_getmode()
	{
		return invoker.AltMode;
	}
	
	action void MS_SetMode(bool set = SniperMode)
	{
		invoker.AltMode = set;
	}
	
	action bool HSR_getmode()
	{
		return invoker.ExplosiveMode;
	}
	
	action void HSR_SetMode(bool set = NormalMode)
	{
		invoker.ExplosiveMode = set;
	}
	
	action void cleanmodetokens()
	{
		A_Takeinventory("MS_Select_AimMode",1);
		A_takeinventory("MS_Select_GrenMode",1);
		A_takeinventory("HSR_Select_EXPMode",1);
		A_takeinventory("HSR_SelectNormMode",1);
	}
	
	action bool PlayerPressedOnce(int button)
	{
		int bt = player.cmd.buttons;
		int oldbt = player.oldbuttons;
		if((bt & button) && !(oldbt & button))
			return true;
		return false;
	}
	
	Action State PB_CheckBarrelThrow1()
	{
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("ThrowBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("ThrowFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("ThrowIceBarrel");
		//no barrel
		return resolvestate(null);
	}
	
	Action State PB_CheckBarrelPlace1()
	{
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("PlaceBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("PlaceFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("PlaceIceBarrel");
		//no barrel
		return resolvestate(null);
	}
	
	override void postbeginplay()
	{
		grenadeloaded = true;
		super.postbeginplay();
	}
	
	override void attachtoowner(actor other)
	{
		if(other && other.player)
		{
			if(other.countinv(ammotype2) < 1 && (countinv(respectInventoryItem) < 1))
				other.A_giveinventory(ammotype2,11);
			
		}
		super.attachtoowner(other);
	}
	
}

class MetalSniperAmmo : Ammo
{
	default
	{
		inventory.maxamount 11;
	}
}

class MetalSniperRespect : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

Class SniperUnloaded : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

class MS_Select_AimMode : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

class MS_Select_GrenMode : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

class MS_GrenMode : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

class HSR_Select_EXPMode : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

class HSR_SelectNO : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

class HSR_SelectNormMode : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}