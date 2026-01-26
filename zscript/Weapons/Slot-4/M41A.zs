const m41a_ammoFull = 95; //ammo in mag, its here just to make it easier to change later

Class M41A : PB_WeaponBase
{
	
	default
	{
		weapon.slotnumber 4;
		weapon.ammotype1 "PB_HighCalMag";
		Weapon.AmmoGive1 30;
		weapon.ammotype2 "M41AChamberAmmo";								//ammo in the mag
		PB_WeaponBase.AmmoTypeLeft "M41AChamberAmmoLeft";
		
		PB_WeaponBase.unloadertoken "M41AUnloaded";	//unloaded token
		PB_WeaponBase.respectItem "M41ARespect";		//respect token
		PB_WeaponBase.DualWieldToken "M41ADueling";		//in case it has dual wield
		inventory.pickupsound "";
		inventory.pickupmessage "got the M41A pulse rifle! (slot 4)";
		inventory.pickupsound "M41A/PickUp";
		tag "M41A";
		Inventory.AltHUDIcon "PMAWA0";		
		inventory.maxamount 2;
		scale 0.7;
	}
	
	states
	{
		spawn:
			PMAW A -1;
			stop;
		
		WeaponRespect:
			TNT1 A 0 A_setInventory(invoker.respectInventoryItem,1);
			TNT1 A 1 A_DoPBWeaponAction();
			Goto Ready;
		
		Select:
			TNT1 A 0 PB_WeaponRaise("M41A/PickUp");
			TNT1 A 0 PB_WeapTokenSwitch("RifleSelected");
			TNT1 A 0 PB_RespectIfNeeded();
		SelectContinue:
			TNT1 A 0;
		SelectAnimation:
			TNT1 A 0 cleardualoverlays();
			TNT1 A 0 A_JumpIf(A_CheckAkimbo(), "SelectAnimationDualWield");
			PMAU ABCD 1;
			goto ready;
		
		
		Deselect:
			TNT1 A 0 PB_jumpIfHasBarrel("PlaceBarrel","PlaceFlameBarrel","PlaceIceBarrel");
			TNT1 A 0 A_JumpIf(A_CheckAkimbo(), "DeselectAnimationDualWield");
			PMAD ABCD 1;
			TNT1 A 0 A_lower(120);
			wait;
		
		
		
		Ready:
		Ready3:
			TNT1 A 0 A_JumpIf(A_CheckAkimbo(), "ReadyDualWield");	
			PMAF A 1 {
				PB_CoolDownBarrel(0, 0, -1);
				return A_DoPBWeaponAction();
			}
			loop;
		
		NoAmmo:
			PMAF A 1;
			goto ready;
		
		Fire:
			TNT1 A 0 PB_jumpIfHasBarrel("ThrowBarrel","ThrowFlameBarrel","ThrowIceBarrel");
			TNT1 A 0 {
				if(invoker.CountInv("NoFatality") == 0 && (ttwcfbex)) 
				{
					return PB_Execute();
				}
				return resolveState(null);
			}
			TNT1 A 0 PB_jumpIfNoAmmo("Reload",1);
			PMAF B 1 bright FireM41A();
			PMAF C 1 bright;
			TNT1 A 0 A_Zoomfactor(1.0);
			PMAF D 1 A_refire("FireAnim2");
			//TNT1 A 0 A_refire();
			goto ready;
		
		FireAnim2:
			TNT1 A 0 PB_jumpIfHasBarrel("ThrowBarrel","ThrowFlameBarrel","ThrowIceBarrel");
			PMAF C 1 bright FireM41A();
			PMAF D 1 bright;
			TNT1 A 0 A_Zoomfactor(1.0);
			PMAF A 1 A_refire("Fire");
			goto ready;
			
		AltFire:	//no altfire for you
			TNT1 A 0 PB_jumpIfHasBarrel("PlaceBarrel","PlaceFlameBarrel","PlaceIceBarrel");
			goto ready;
		
		Weaponspecial:
			TNT1 A 0 A_setinventory("GoWeaponSpecialAbility",0);	
			TNT1 A 0 A_jumpif(invoker.amount > 1,"SwitchToDualWield");
			TNT1 A 0 A_print("you need 2 \cv"..invoker.gettag().."\c- to dual wield.");
			goto ready;
		SwitchToDualWield:
				TNT1 A 0 cleardualoverlays();
				TNT1 A 0 {
						A_Startsound("Ironsights",15,CHANF_OVERLAP);
						if (A_CheckAkimbo()) 
						{
							A_SetAkimbo(False);
							A_SetInventory(invoker.DualWieldToken,0); 
							return resolvestate("SwitchFromDualWield");
						}
						
						A_SetAkimbo(True);
						A_SetInventory(invoker.DualWieldToken,1); 
						return resolvestate(null);
					}
				PMDT ABCD 1;
				PMDT E 1;
				PMDT FGHI 1;
				Goto ReadyDualWield;
		SwitchFromDualWield:
				PMDT IHGFEDCBA 1;
				goto ready;
				TNT1 ABCDE 1;
				TNT1 E 1;
				TNT1 EFGHI 1;
				Goto Ready;
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		//	Reload/Unload
		////////////////////////////////////////////////////////////////////////////////////////////////
	
		
		Reload:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_WeaponOffset(0,32);
			}
			TNT1 A 0 PB_jumpIfHasBarrel("IdleBarrel","IdleFlameBarrel","IdleIceBarrel");
			TNT1 A 0 A_JumpIf(A_CheckAkimbo(), "ReloadDualWield");	
			TNT1 A 0 PB_checkReload(null,"Ready","NoAmmo",m41a_ammoFull,1);
			PMAR ABCD 1;
			PMAR EFGH 1;
			PMAR IJKL 1;
			PMAR MNOP 1;
			PMAR QQRST 1;
			TNT1 A 0 A_Startsound("M41A/MagTake",33);
			PMAR UVWX 1;
			PMAR YZZZZZZZZ 1;
			TNT1 A 0 A_Startsound("M41A/MagIn",34);
			PMAT ABCD 1;
			TNT1 A 0 PB_AmmoIntoMag(invoker.ammo2.getclassname(),invoker.ammo1.getclassname(),m41a_ammoFull,1);
			TNT1 A 0 A_takeinventory(invoker.UnloaderToken,1);
			PMAT EFGH 1;
			PMAT IJKL 1;
			
			PMAT MNOP 1;
			TNT1 A 0 A_Startsound("M41A/Bolt",35);
			PMAT QRRRST 1;
			PMAT UVWX 1;
			PMAT YYYY 1;
			
			PMAR KJIH 1;
			PMAR GFEDCBA 1;
			goto ready;
		
		Unload:
			TNT1 A 0 A_Takeinventory("Unloading",1);
			TNT1 A 0 A_JumpIf(A_CheckAkimbo(), "UnloadDualWield");	
			PMAR ABCD 1;
			PMAR EFGH 1;
			PMAR IJKL 1;
			PMAR MNOP 1;
			PMAR QQRST 1;
			TNT1 A 0 A_Startsound("M41A/MagTake",33);
			PMAR UVWX 1;
			PMAR YZZZZZZZZ 1;
			TNT1 A 0 A_Startsound("M41A/MagIn",34);
			PMAT ABCD 1;
			TNT1 A 0 PB_UnloadMag(invoker.ammo2.getclassname(),invoker.ammo1.getclassname(),1);
			TNT1 A 0 A_giveinventory(invoker.UnloaderToken,1);
			PMAT EFGH 1;
			PMAT IJKL 1;
			
			PMAT MNOP 1;
			TNT1 A 0 A_Startsound("M41A/Bolt",35);
			PMAT QRRRST 1;
			PMAT UVWX 1;
			PMAT YYYY 1;
			
			PMAR KJIH 1;
			PMAR GFEDCBA 1;
			goto ready;
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		//	Flashes
		////////////////////////////////////////////////////////////////////////////////////////////////
	
		
		FlashPunching:
			TNT1 A 0 cleardualoverlays();
			PMAK ABCDEFGHFEDCBA 1 m41a_setspriteifdual("TNT1");
			stop;
		
		FlashKicking:
			TNT1 A 0 cleardualoverlays();
			PMAK ABCDEFGHHFEDCBA 1 m41a_setspriteifdual("PMDK");
			goto ready3;
			
		FlashAirKicking:
			TNT1 A 0 cleardualoverlays();
			PMAK ABCDEFGHHHFEDCBA 1  m41a_setspriteifdual("PMDK");
			goto ready3;
			
		FlashSlideKicking:
			TNT1 A 0 cleardualoverlays();
			PMAK ABCDEFGHHHHHHHHHHHHHGFEDCBA 1  m41a_setspriteifdual("PMDK");
			goto ready3;
			
		FlashSlideKickingStop:
			TNT1 A 0 cleardualoverlays();
			PMAK GFEDCBA 1  m41a_setspriteifdual("PMDK");
			goto ready3;
		
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		//	dual things
		////////////////////////////////////////////////////////////////////////////////////////////////
	
		SelectAnimationDualWield:
			PMDU ABCD 1;
			goto ReadyDualWield;
		
		DeselectAnimationDualWield:
			TNT1 A 0 cleardualoverlays();
			PMDU DCBA 1;
			TNT1 A 0 A_lower(120);
			wait;
			
		ReadyDualWield:
			TNT1 A 0 {
					A_SetRoll(0);
					//PB_HandleCrosshair(42);
					A_SetFiringRightWeapon(False);
					A_SetFiringLeftWeapon(False);
					A_overlay(10,"IdleLeft_Overlay",false);
					A_overlay(11,"IdleRight_Overlay",false);
				}
		ReadyToFireDualWield:
			TNT1 A 1 {
				if(invoker.ammo1.amount > 0)
				{
					if(invoker.AmmoLeft.Amount  <=0 || invoker.Ammo2.Amount <=0)
					{
						if(invoker.AmmoLeft.Amount  <=0 && invoker.Ammo2.Amount <=0)
							A_SetInventory("DualFireReload",2);
						else
							A_SetInventory("DualFireReload",1);
					}
				}
				return A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOFIRE);
			}
			Loop;
		
		
		IdleLeft_Overlay:
			PMLF A 1 {
				PB_CoolDownBarrel(13, 0, -2);
				if(invoker.AmmoLeft.Amount  <=0 && invoker.Ammo2.Amount > 0)
					A_GiveInventory("DualFiring",1);
				int firemodecvar = Cvar.GetCvar("SingleDualFire",player).GetInt();
				if((PressingAltFire() || JustPressed(BT_ALTATTACK)) && !A_IsFiringLeftWeapon() && firemodecvar == 2)
				{
						if(invoker.AmmoLeft.Amount  > 0)
							return resolvestate("FireLeft_Overlay");
						else 
						{
							A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
							return resolvestate(null);
						}
				}
				if(CountInv("DualFiring")==0 || (CountInv("DualFiring")==0 && invoker.Ammo2.Amount <=0) || firemodecvar == 1)
				{
					if((PressingFire() || JustPressed(BT_ATTACK)) && !A_IsFiringLeftWeapon() && firemodecvar < 2)
					{
						if(invoker.AmmoLeft.Amount  > 0)
							return resolvestate("FireLeft_Overlay");
						else 
						{
							A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
							return resolvestate(null);
						}
					}
				}
				return resolvestate(null);
			}
			Loop;
			
		IdleRight_Overlay:
			PMRF A 1 {
				PB_CoolDownBarrel(-13, 0, -2);
				if(invoker.AmmoLeft.Amount >0 && invoker.Ammo2.Amount <=0)
					A_TakeInventory("DualFiring",1);
				int firemodecvar = Cvar.GetCvar("SingleDualFire",player).GetInt();
				if(CountInv("DualFiring")==1 || (CountInv("DualFiring")==1 && invoker.AmmoLeft.Amount <=0))
				{
					if((PressingFire() || JustPressed(BT_ATTACK)) && !A_IsFiringLeftWeapon() && firemodecvar==0)
					{
						if(invoker.Ammo2.Amount  > 0)
							return resolvestate("FireRight_Overlay");
						else 
						{
							A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
							return resolvestate(null);
						}
					}
				}
				if((PressingAltfire() || JustPressed(BT_ALTATTACK)) && !A_IsFiringRightWeapon() && firemodecvar==1){
					if(invoker.Ammo2.Amount  > 0)
						return resolvestate("FireRight_Overlay");
					else 
					{
						A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
						return resolvestate(null);
					}
				}
				if((Pressingfire() || JustPressed(BT_ATTACK)) && !A_IsFiringRightWeapon() && firemodecvar==2){
					if(invoker.Ammo2.Amount  > 0)
						return resolvestate("FireRight_Overlay");
					else 
					{
						A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
						return resolvestate(null);
					}
				}
				return resolvestate(null);
			}
			Loop;
		
		FireLeft_Overlay:
			PMLF B 1 BRIGHT {	
				FireDualM41A(true);
				A_SetFiringLeftWeapon(True);
			}
			//PMLF C 1;
			PMLF C 1 bright {
				A_SetFiringLeftWeapon(False);
				if(invoker.AmmoLeft.Amount <=0 || invoker.Ammo2.Amount >0 )
					A_GiveInventory("DualFiring",1);
			}
			PMLF D 1 {
				//refire for dual wield
				int firemodecvar = Cvar.GetCvar("SingleDualFire",player).GetInt();
				if(JustPressed(BT_ALTATTACK) && !A_IsFiringRightWeapon() && firemodecvar == 2){
					if(invoker.AmmoLeft.Amount  > 0)
						return resolvestate("FireLeft_Overlay");
					else 
					{
						A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
						return resolvestate(Null);
					}
				}
				if(JustPressed(BT_ATTACK) && !A_IsFiringLeftWeapon())
				{
					if(invoker.AmmoLeft.Amount  > 0)
					{
						return resolvestate("FireLeft_Overlay");
					}
					else 
					{
						A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
						return resolvestate(null);
					}
				}
				return resolvestate(Null);
			}
			TNT1 A 0 {
				if(invoker.AmmoLeft.Amount <=0)
					A_GiveInventory("DualFireReload",1);
			}
			Goto IdleLeft_Overlay;
	
		FireRight_Overlay:
			PMRF B 1 BRIGHT {	
					FireDualM41A();
					A_SetFiringRightWeapon(True);
				}
			//PMRF C 1 bright;
			PMRF C 1 bright {
				A_SetFiringRightWeapon(False);
				if(invoker.AmmoLeft.Amount >0 || invoker.Ammo2.Amount <=0 )
					A_TakeInventory("DualFiring",1);
			}
			PMRF D 1 {
				//refire for dual wield
				int firemodecvar = Cvar.GetCvar("SingleDualFire",player).GetInt();
				if(JustPressed(BT_ATTACK) && !A_IsFiringRightWeapon() && firemodecvar == 2){
					if(invoker.Ammo2.Amount  > 0)
						return resolvestate("FireRight_Overlay");
					else 
					{
						A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
						return resolvestate(null);
					}
				}
				if(JustPressed(BT_ALTATTACK) && !A_IsFiringRightWeapon() && firemodecvar > 2){
					if(invoker.Ammo2.Amount  > 0)
						return resolvestate("FireRight_Overlay");
					else 
					{
						A_StartSound("weapons/empty", 10,CHANF_OVERLAP);
						return resolvestate(null);
					}
				}
				return resolvestate(null);
			}
			TNT1 A 0 {
				if(invoker.Ammo2.Amount <=0)
					A_GiveInventory("DualFireReload",1);
			}
			Goto IdleRight_Overlay;
		
		
		NoAmmoDual:
			TNT1 A 1;
			goto ready;
		
		////////////////////////////////////////////////////////////////////////
		// Dual Reload
		////////////////////////////////////////////////////////////////////////
		
		
		ReloadDualWield:
			TNT1 A 0 cleardualoverlays();
			TNT1 A 0 {
				int am1 = invoker.ammo1.amount; //countinv(invoker.ammotype1);
				int am2 = invoker.ammo2.amount; //countinv(invoker.ammotype2);
				int tr = invoker.ammoLeft.amount; 
				
				if(am1 < 1)
					return resolvestate("NoAmmoDual");	// some futureproofing
				
				if(tr >= m41a_ammoFull && am2 >= m41a_ammoFull)
					return resolvestate("Ready");
				
				A_setinventory("DualFireReload",0);
				return resolvestate(null);
			}
		ReloadRight:
			TNT1 A 0 A_jumpif(invoker.ammo2.amount >= m41a_ammoFull,"startreloadfromleft"); //no need to reload right
			TNT1 A 0 A_Startsound("Ironsights",15,CHANF_OVERLAP);
			PMDE ABCD 1;
			PMDE EFGH 1;
			
			PMAR P 1;
			PMAR QQRST 1;
			TNT1 A 0 A_Startsound("M41A/MagTake",33);
			PMAR UVWX 1;
			PMAR YZZZZZZZZ 1;
			TNT1 A 0 A_Startsound("M41A/MagIn",34);
			PMAT ABCD 1;
			TNT1 A 0 PB_AmmoIntoMag(invoker.ammo2.getclassname(),invoker.ammo1.getclassname(),m41a_ammoFull,1);
			TNT1 A 0 A_takeinventory(invoker.UnloaderToken,1);
			PMAT EFGH 1;
			PMAT IJKL 1;
			
			PMAT MNOP 1;
			TNT1 A 0 A_Startsound("M41A/Bolt",35);
			PMAT QRRRST 1;
			PMAT UVWX 1;
			PMAT YYYY 1;
			TNT1 A 0 A_jumpif(invoker.ammo1.amount < 1 || invoker.ammoLeft.amount >= m41a_ammoFull,"BackToReadyDualFromRight");
			
			PMDX EEDCBA 1;
			TNT1 A 5;
			
			//TNT1 A 0 A_jumpif(invoker.ammo1.amount < 1,"BackToReadyDualFromRight");
			
		ReloadLeft:
			TNT1 A 0 A_jumpif(invoker.ammoLeft.amount >= m41a_ammoFull,"BackToReadyDual"); //no need to reload left
			TNT1 A 0 A_Startsound("Ironsights",15,CHANF_OVERLAP);
			PMDX ABCDEE 1;
			
			PMAR P 1;
			PMAR QQRST 1;
			TNT1 A 0 A_Startsound("M41A/MagTake",33);
			PMAR UVWX 1;
			PMAR YZZZZZZZZ 1;
			TNT1 A 0 A_Startsound("M41A/MagIn",34);
			PMAT ABCD 1;
			TNT1 A 0 PB_AmmoIntoMag(invoker.ammoLeft.getclassname(),invoker.ammo1.getclassname(),m41a_ammoFull,1);
			TNT1 A 0 A_takeinventory(invoker.UnloaderToken,1);
			PMAT EFGH 1;
			PMAT IJKL 1;
			
			PMAT MNOP 1;
			TNT1 A 0 A_Startsound("M41A/Bolt",35);
			PMAT QRRRST 1;
			PMAT UVWX 1;
			PMAT YYYY 1;
			
			
		BackToReadyDUalFromLeft:
			PMDL ABCDEF 1;
			TNT1 A 0 A_Startsound("Ironsights",15,CHANF_OVERLAP);
			PMDL GHI 1;
			goto ReadyDualWield;
			
			
		BackToReadyDual:
			PMDU ABCD 1;
			goto ReadyDualWield;
			
		BackToReadyDualFromRight:
			PMDE HGFE 1;
			TNT1 A 0 A_Startsound("Ironsights",15,CHANF_OVERLAP);
			PMDE DCBA 1;
			goto ReadyDualWield;
		
		startreloadfromleft:
			TNT1 A 0 A_jumpif(invoker.ammoLeft.amount >= m41a_ammoFull,"BackToReadyDual");
			PMDU DCBA 1;
			TNT1 A 3;
			goto ReloadLeft;
		
		UnloadDualWield:
			TNT1 A 0 cleardualoverlays();
			PMDU DCBA 1;
			TNT1 A 15;
			TNT1 A 0 A_Startsound("M41A/MagTake",33);
			TNT1 A 0 PB_UnloadMag(invoker.ammo2.getclassname(),invoker.ammo1.getclassname(),1);
			TNT1 A 0 A_giveinventory(invoker.UnloaderToken,1);
			TNT1 A 15;
			TNT1 A 0 A_Startsound("M41A/MagTake",33);
			TNT1 A 0 PB_UnloadMag(invoker.ammoLeft.getclassname(),invoker.ammo1.getclassname(),1);
			TNT1 A 0 A_giveinventory(invoker.UnloaderToken,1);
			goto BackToReadyDual;
			
		MuzzleFlash:
			TNT1 A 0 A_overlayFlags(overlayid(),PSPF_FLIP|PSPF_MIRROR,random(0,1));
			PMAF EF 1 bright;
			stop;
		
		MuzzleDualL:
			PMLF EF 1 bright;
			stop;
		MuzzleDualR:
			PMRF EF 1 bright;
			stop;
		
		LoadSprites:
			PMDK A 0;
			stop;
	}
	
	action void cleardualoverlays()
	{
		A_Clearoverlays(10,11);
		A_Clearoverlays(-8,-7);
	}
	
	action void FireM41A()
	{
		if(invoker.ammo2.amount <= 0)
			return;
		
		PB_FireBullets("PB_762x51mm", 1, 3, 0, 0, 2.5); 
		PB_FireOffset();
		PB_LowAmmoSoundWarning("hdmr");
		A_Zoomfactor(0.99);
		A_overlay(-7,"MuzzleFlash");
		PB_IncrementHeat(2);
		PB_WeaponRecoil(-0.75,frandom(-0.3,0.3));
		A_Startsound("M41A/Fire",99,pitch:frandom(0.98,1.02));
		PB_DynamicTail("smg", "smg");
		PB_GunSmoke(0,0,0); 
		PB_MuzzleFlashEffects(0,0,0);
		PB_SpawnCasing("PB_EmptyBrass",22,2,26,Frandom(-4,1),Frandom(6,9),Frandom(0,2), true, true);
		
		invoker.ammo2.amount--;
		
		
	}
	
	action void FireDualM41A(bool Left = false)
	{
		if(Left)
		{
			PB_FireBullets("PB_762x51mm", 1, 3, -3, 0, 2.5);
			PB_IncrementHeat(2, true);
			PB_WeaponRecoil(-0.85,frandom(0.3,0.8));
			A_Startsound("M41A/Fire",99,pitch:frandom(0.98,1.02));
			A_overlay(-8,"MuzzleDualL");
			PB_SpawnCasing("PB_EmptyBrass",22,-16,35,Frandom(-4,1),Frandom(5,8),Frandom(1,2), true, true);
			PB_GunSmoke(4,0,0); 
			PB_MuzzleFlashEffects(4,0,0);
			PB_DynamicTail("smg", "smg");
			
			PB_LowAmmoSoundWarning("hdmr",invoker.ammoLeft.getclassname());
			if(invoker.ammoLeft.amount > 0)
				invoker.ammoLeft.amount--;
		}
		else
		{
			PB_FireBullets("PB_762x51mm", 1, 3, 3, 0, 2.5);
			PB_IncrementHeat(2);
			PB_WeaponRecoil(-0.85,frandom(-0.8,-0.3));
			A_Startsound("M41A/Fire",100,pitch:frandom(0.98,1.02));
			A_overlay(-9,"MuzzleDualR");
			PB_SpawnCasing("PB_EmptyBrass",22,16,35,Frandom(-4,1),Frandom(5,8),Frandom(1,2), true, true);
			PB_GunSmoke(-4,0,0); 
			PB_MuzzleFlashEffects(-4,0,0);
			PB_DynamicTail("smg", "smg");
			
			PB_LowAmmoSoundWarning("hdmr");
			if(invoker.ammo2.amount > 0)
				invoker.ammo2.amount--;

		}
	}
	
	action void m41a_setspriteifdual(string spt = "")
	{
		if(!A_checkAkimbo())
			return;
		let psp = player.findpsprite(overlayid());
		if(psp)
			psp.sprite = getspriteindex(spt);
	}
	
	override void attachtoowner(actor other)
	{
		if(other && other.player)
		{
			if(other.countinv(ammotype2) < 1 && (countinv(respectInventoryItem) < 1))
			{
				other.A_giveinventory(ammotype2,m41a_ammoFull);
				other.A_giveinventory(ammotypeLeft,m41a_ammoFull);
			}
		}
		super.attachtoowner(other);
	}
}

Class M41AChamberAmmo : Ammo
{
	default
	{
		inventory.maxamount m41a_ammoFull;
		ammo.backpackamount 0;
		ammo.backpackmaxamount m41a_ammoFull;
	}
}

Class M41AChamberAmmoLeft : Ammo
{
	default
	{
		inventory.maxamount m41a_ammoFull;
		ammo.backpackamount 0;
		ammo.backpackmaxamount m41a_ammoFull;
	}
}

Class M41ARespect : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}



Class M41AUnloaded:inventory
{
	default
	{
		inventory.maxamount 1;
	}
}

Class M41ADueling:inventory
{
	default
	{
		inventory.maxamount 1;
	}
}