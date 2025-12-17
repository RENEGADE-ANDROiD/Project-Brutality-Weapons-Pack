class PB_CalamityBlade : PBWP_Weapon
{
 Int ChargeLevel;
	default
	{
		weapon.slotnumber 8;
		weapon.ammotype1 "PB_Cell";
		weapon.ammogive1 100;	
		weapon.slotpriority 0;
		PB_WeaponBase.respectItem "RespectPB_CalamityBlade";
		Inventory.PickupSound "CLIPIN";
		inventory.pickupmessage "Calamity Blade (slot 9)";
		Obituary "Got roasted by the Calamity Blade. Ouch!";
		Inventory.AltHUDIcon "WP0PA0";
		PB_WeaponBase.TailPitch 0.6;
		+weapon.noalert;
		+weapon.noautofire;
		+weapon.noautoaim;
		+DONTGIB
		Scale 0.999;
		Tag "Calamity Blade";
		FloatBobStrength 0.5;
	}
	
	states
	{
	
		Spawn:
		 WP0P A -1;
		 Stop;
	Steady:
		TNT1 A 0 A_SetRoll(0);
		TNT1 A 1 {
				A_TakeInventory("GoWeaponSpecialAbility",1);
				A_TakeInventory("Grabbing_A_Ledge",1);
				A_TakeInventory("UseEquipment",1);
				A_TakeInventory("ToggleEquipment",1);
				A_TakeInventory("Taunting",1);
				A_TakeInventory("Salute1",1);
				A_TakeInventory("Salute2",1);
				A_TakeInventory("Kicking",1);
			}
	    Goto Ready;
		WeaponRespect:
			TNT1 A 0 A_DoPBWeaponAction();
			TNT1 A 0 {
				A_SetInventory("PB_LockScreenTilt",1);
				A_SetCrosshair(5);
				}			
			goto ready3;
			
		Select:
			TNT1 A 0 A_Raise();
			TNT1 A 0 {PB_HandleCrosshair(69);}
			TNT1 A 0 A_SetInventory("RandomHeadExploder",1);
			TNT1 A 0 PB_RespectIfNeeded();
			TNT1 A 0 A_weaponoffset(0,32);
			goto SelectFirstPersonLegs;
		SelectContinue:
			TNT1 A 0 PB_RespectIfNeeded();
		SelectAnimation:
			TNT1 A 0
		{
			A_ZoomFactor(1);
			A_StartSound("WP9/UP1",7);
		}
		WP0G A 1 A_WeaponOffset(0, 99,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(0, 66,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(0, 33,WOF_INTERPOLATE);
			goto ready;
		
		Deselect:
			TNT1 A 0 {PB_HandleCrosshair(69);}
			TNT1 A 0 A_ClearOverlays(10,11);
			TNT1 A 0 PB_jumpIfHasBarrel("PlaceBarrel","PlaceFlameBarrel","PlaceIceBarrel");
			TNT1 A 0
		{
			A_StopSound(6);
			A_StopSound(7);
			A_ZoomFactor(1);
		}
		WP0G A 1 A_WeaponOffset(0, 33,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(0, 66,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(0, 99,WOF_INTERPOLATE);
			TNT1 A 0 A_lower;
			wait;
		
		Ready:
			TNT1 A 0 A_WeaponOffset(0,32);
			TNT1 A 0 PB_HandleCrosshair(42);
		Ready3:
			WP0G A 1
		{
			//A_SetInventory("PB_LockScreenTilt",0);
			//A_SetInventory("CantDoAction",0);
				PB_CoolDownBarrel(0, 0, 3);
				return A_DoPBWeaponAction();
		}
			loop;		
		
		////////////////////////////////////////////////////////////////////////
		// Main Attacks states
		////////////////////////////////////////////////////////////////////////
		Charge1:
		WP0C ABCD 3 BRIGHT A_Light1;
		Goto LightDone;
	Charge2:
		WP0C EFGH 3 BRIGHT A_Light1;
		Goto LightDone;
	Charge3:
		WP0C IJKL 3 BRIGHT A_Light1;
		Goto LightDone;
	Charge4:
		WP0C MNOP 3 BRIGHT A_Light1;
		Goto LightDone;
	Charge5:
		WP0C QRST 3 BRIGHT A_Light1;
		Goto LightDone;
		
		Fire:
		TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "ThrowBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "ThrowFlameBarrel");
		TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "ThrowIceBarrel");
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(42);
				A_SetInventory("PB_LockScreenTilt",0);
				PB_WeaponRecoil(-4,frandom(-1.5,1.5));
			}
			TNT1 A 0 A_JumpIfInventory("PB_Cell",1,1);
		Goto DryFire;
	Charging:
		TNT1 A 0;
		TNT1 A 0 A_ChargeShow();
		WP0G A 10 A_CalamityBladeCharge();
		TNT1 A 0
		{
			If(Invoker.ChargeLevel >= 5 || CountInv("PB_Cell") < 10)
			Return ResolveState("Unleash");
			Return ResolveState(Null);
		}
			TNT1 A 0 PB_Refire("Charging");
			Goto Unleash;
			
			Unleash:
		TNT1 A 0
		{
			A_LoudFlash();
			A_CalamityBladeFire();
			A_FireProjectile("NLSmokeSpawner",0,0,0,-3);
			A_OverlayPivotAlign(1,PSPA_CENTER,PSPA_CENTER);
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),56,WOF_INTERPOLATE);
			//If(CVar.FindCVar("ZoomEffects").GetBool()) { A_ZoomFactor(1.030);}
			A_ZoomFactor(1.030);
		}
		WP0F A 2 BRIGHT
		{
			A_GunFeedback();
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),52,WOF_INTERPOLATE);
			//If(CVar.FindCVar("ZoomEffects").GetBool()) { A_ZoomFactor(1.020);}
			A_ZoomFactor(1.020);
		}

		WP0F B 3 BRIGHT
		{
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),48,WOF_INTERPOLATE);
		}
		WP0G D 3
		{
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),44,WOF_INTERPOLATE);
		}
		WP0G C 3
		{
			A_CheckReload();
			A_OverlayScale(PSP_WEAPON,+0.05,+0.05,WOF_ADD);
			A_WeaponOffset(Random(-1,1),40,WOF_INTERPOLATE);
		}
		WP0G B 2
		{
			A_ZoomFactor(1);
			A_OverlayScale(PSP_WEAPON,1,1);
			A_OverlayRotate(OverlayID(),0);
		}
		TNT1 A 0 A_Refire();
		Goto Ready;
	Dryfire:
		WP0G A 1
		{
			A_StartSound("WP9/DF1",7);
			A_WeaponOffset(0,34,WOF_INTERPOLATE);
		}
		WP0G A 1;
		//TNT1 A 0 A_JumpIf(ACS_NamedExecuteWithResult("AutoReloadToggle")==1,"Reload");
		TNT1 A 0 A_DoPBWeaponAction(WRF_ALLOWRELOAD|WRF_NOFIRE);
		TNT1 A 0 A_JumpIf(ACS_NamedExecuteWithResult("AutoReloadToggle")==1,"Reload");
		Goto Ready;
	AfterStates:
		TNT1 A 5 A_WeaponOffset(-7, 99,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(-5, 68,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(-3, 47,WOF_INTERPOLATE);
		WP0G A 1 A_WeaponOffset(-1, 34,WOF_INTERPOLATE);
		Goto Ready;
		
		
		WeaponSpecial:
			TNT1 A 0 A_setinventory("GoWeaponSpecialAbility",0);
			TNT1 A 0 PB_WeaponRecoil(-4,frandom(-1.5,1.5));
			TNT1 A 0 {
				A_SetInventory("GoWeaponSpecialAbility",0);
				A_SetInventory("Zoomed",0);
				A_SetInventory("ADSmode",0);
				A_SetInventory("PB_LockScreenTilt",1);
				A_WeaponOffset(0,32);
				PB_HandleCrosshair(42);
				A_ZoomFactor(1.0);
				A_ClearOverlays(10,11);
				}
			TNT1 A 0 A_Print("No WeaponSpecial!");
			Goto Ready3;
		
		////////////////////////////////////////////////////////////////////////
		//	kick flashes
		////////////////////////////////////////////////////////////////////////
		
		FlashPunching:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			TNT1 ABCDEFGGFEDCBA 1;
			stop;
		
		FlashKicking:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			WP0K ABCDEFGGGFEDCBA 1;
			goto ready;
			
		FlashAirKicking:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			WP0K ABCDEFGGGGFEDCBA 1;
			goto ready;
			
		FlashSlideKicking:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			WP0K ABCDEFGGGGGGGGGGGGGGGFEDCBA 1;
			goto ready;
			
		FlashSlideKickingStop:
			TNT1 A 0 A_ClearOverlays(10,11);
TNT1 A 0 A_JumpIfInventory ("GrabbedBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
			TNT1 A 0 A_JumpIfInventory ("GrabbedIceBarrel", 1, "FlashBarrelPunching");
			WP0K GFEDCBA 1;
			goto ready;
	}
	
	Action Void A_CalamityBladeCharge()
	{
		A_StartSound("WP0/FR1",0);
		If(Invoker.ChargeLevel < 5 && CountInv("PB_Cell") >= 10)
		{
			If(!sv_infiniteammo)
			A_TakeInventory("PB_Cell",10);
			Invoker.ChargeLevel++;	
		}
	}

	Action Void A_ChargeShow()
	{
		If(Invoker.ChargeLevel == 0)
			A_Overlay(2,"Charge1",FALSE);
		If(Invoker.ChargeLevel == 1)
			A_Overlay(2,"Charge2",FALSE);
		If(Invoker.ChargeLevel == 2)
			A_Overlay(2,"Charge3",FALSE);
		If(Invoker.ChargeLevel == 3)
			A_Overlay(2,"Charge4",FALSE);
		If(Invoker.ChargeLevel >= 4)
			A_Overlay(2,"Charge5",FALSE);	
	}

	Action Void A_CalamityBladeFire()
	{
		A_StartSound("WP0/FR2",7);
		If(Invoker.ChargeLevel == 1)
		{	
			A_FireProjectile("CalamitySlice",5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",0, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-5,0,Flags:FPF_NOAUTOAIM);	
		}
		If(Invoker.ChargeLevel == 2)
		{	
			A_FireProjectile("CalamitySlice",12.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 7.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 2.5, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice",-2.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-7.5, 0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-12.5,0,Flags:FPF_NOAUTOAIM);		
		}
		If(Invoker.ChargeLevel == 3)
		{	
			A_FireProjectile("CalamitySlice",20, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice",15, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",10, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 0, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-10,0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-15,0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-20,0,Flags:FPF_NOAUTOAIM);			
		}
		If(Invoker.ChargeLevel == 4)
		{	
			A_FireProjectile("CalamitySlice",27.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",22.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",17.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",12.5, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice", 7.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 2.5, 0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-2.5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-7.5, 0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-12.5,0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-17.5,0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-22.5,0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-27.5,0,Flags:FPF_NOAUTOAIM);			
		}
		If(Invoker.ChargeLevel >= 5)
		{	
			A_FireProjectile("CalamitySlice",35, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice",30, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice",25, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice",20, 0,Flags:FPF_NOAUTOAIM);	
			A_FireProjectile("CalamitySlice",15, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",10, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice", 0, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-5, 0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-10,0,Flags:FPF_NOAUTOAIM);			
			A_FireProjectile("CalamitySlice",-15,0,Flags:FPF_NOAUTOAIM);
			A_FireProjectile("CalamitySlice",-20,0,Flags:FPF_NOAUTOAIM);				
			A_FireProjectile("CalamitySlice",-25,0,Flags:FPF_NOAUTOAIM);				
			A_FireProjectile("CalamitySlice",-30,0,Flags:FPF_NOAUTOAIM);				
			A_FireProjectile("CalamitySlice",-35,0,Flags:FPF_NOAUTOAIM);				
		}
			Invoker.ChargeLevel = 0;
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

	Action void A_LoudFlash() 
	{
		A_GunFlash();
		A_AlertMonsters();
	}

	Action void A_GunIdle() 
	{
		If (GetCvar("IdleEffects") == 1)
		{
			A_SetAngle(Angle -FRandom(-0.03,0.03));
			A_SetPitch(Pitch -FRandom(-0.03,0.03));	
		}
	}

	Action void A_GunFeedback() 
	{
		If (GetCvar("RecoilEffects") == 1)
		{
			A_Quake(1,2,0,1,0);
			A_SetPitch(Pitch - FRandom(0.400, 0.800),SPF_INTERPOLATE);
			A_SetAngle(Angle + FRandom(-0.500, 0.500),SPF_INTERPOLATE);
		}
	}
}

Class RespectPB_CalamityBlade : Inventory
{
	default
	{
		Inventory.maxamount 1;
	}
}

Class CalamitySlice : Actor
{
	Default
	{
		Speed  25;
		Damage 30;
		Height 8;
		Radius 16;
		Projectile;
		+RIPPER
		+RANDOMIZE
		+DOHARMSPECIES
		Alpha 0.9;
		RenderStyle "Add";
		DamageType "Fire";
		DeathSound "WPX/XP1";
	}
	Override void Tick() 
	{	
		Super.Tick();
		If (isFrozen())
		Return;
	}	
	States
	{
	Spawn:
		WP0B ABC 2 BRIGHT
		{
			A_SpawnProjectile("NLSmokeSpawner",7,0,FRandom(0,360),2,FRandom(60,130));
			A_SpawnItemEx("NLWeaponSmoke",Random(-8,8),Random(-3,3),Random(-5,5),0,0,6,0,0,0);
			A_SpawnProjectile("LBWP0FlameTrails",0,0,FRandom(0,360),2,FRandom(60,130));
		}
		Loop;
	Death:
		WP0B DEFGHI 2 BRIGHT
		{
		    A_SpawnProjectile("LBWP0FlameImpact",0,0,Random(0,360),2,Random(-60,60));
			A_SpawnProjectile("EXPlosmokes",0,0,Random(0,360),2,FRandom(-20,-30));
		}
		Stop;
	}
}

Class LBWP0FlameTrails : Actor
{
	Default
	{
		+MISSILE
		+NOBLOCKMAP
		+NOTELEPORT
		+DONTSPLASH
		+NOINTERACTION
		+CLIENTSIDEONLY
		+FORCEXYBILLBOARD
		Speed   3;
		Alpha   0.600;
		Radius  1;
		Height  1;
		Damage  0;
		Gravity 0;
		Projectile;
		RenderStyle "Add";
		DamageType "Fire";
		Decal "None";
		Scale 0.3;
	}
	States
	{
	Spawn:
		TNT1 A 1;
		FTX1 ABCDEFGHIJKLMNOPQ 1 BRIGHT A_Fadeout(0.05);
		Stop;
	}
}

Class LBWP0FlameImpact : NLExplode
{
	Default { Scale  0.8; Alpha 0.7; }
	States
	{
    Spawn:
		FTX1 EFGHIJKLMNOPQ 1 BRIGHT
		{
			A_FadeOut(0.02,1);
			A_SetScale(Scale.X+0.01,Scale.Y+0.01);
			A_SetRoll(Roll+fRandom(8,15),SPF_INTERPOLATE);
		}
		Stop;
    }
}

// EXPLOSION FLAMES
Class NLExplode : Actor
{
	Default
	{
		-SPRITEFLIP
		+NOBLOCKMAP
		+NOCLIP
		+BRIGHT
		+NOGRAVITY
		Speed 3;
		Scale 1.2;
		Alpha 0.5;
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		FTX1 A 1;
		FTX1 AABBCCDEFGHIJKLMNOOPP 1 A_SetScale(Scale.X+0.060,Scale.Y+0.060);
		FTX1 QQQQQQQQQQQQQQQQQQQQQ 1 A_FadeOut(0.05,1);
		Stop;
	}
}

Class NLSmokeSpawner : Actor
{
	Default
	{
		+NOCLIP
		Speed 20;
	}
	States
    {
	Spawn:
		TNT1 A 0 NoDelay A_SpawnProjectile("NLWeaponSmoke",9,0,Random(0,360),2,Random(0,180));
        Stop;
    }
}

Class NLWeaponSmoke : Actor
{
	Default
	{
		+NOGRAVITY
		+NOBLOCKMAP
		+FLOORCLIP
		+FORCEXYBILLBOARD
		+CLIENTSIDEONLY
		+NOINTERACTION
		+DONTSPLASH
		+MISSILE
		RenderStyle "Add";
		Scale  0.200;
		Alpha  0.3;
		Radius 0;
		Height 0;
		Speed  1;
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay; //A_JumpIf(CVar.FindCVar("SmokeEffects").GetBool() == 0,"Vanish");
		SMOK ABCDEFGHIJKLMNOPQR 2
		{
			If (self is "NLCasingSmoke") { A_SetTics(1); A_SetScale(0.02,0.06); A_FadeOut(0.005); }
			Else if (self is "NLCasingSmokeEnd") { A_SetTics(1); A_SetScale(0.02,0.095); A_FadeOut(0.005); ThrustThingZ(0,1,0,0); }
			Else { A_FadeOut(0.005); ThrustThingZ(0,2,0,0);}
			Return ResolveState(null);
		}
	Vanish:
		TNT1 A 0 A_StopSound(2);
		Stop;
	}
}


Class NLCasingSmoke : NLWeaponSmoke { Default { Speed 1; } }
Class NLCasingSmokeEnd : NLWeaponSmoke { Default { Speed 8; } }

Class EXPlosmokes : Actor
{
	Default
	{
		+NOBLOCKMAP
		+THRUACTORS
		PROJECTILE;
		Radius 	1;
		Height 	1;
		Speed 	2;
		Damage 	0;
		Scale 	0.7;
	}
	States
	{
	Spawn:
		//TNT1 A 0 NoDelay A_JumpIf(ACS_NamedExecuteWithResult("SmokeToggle")==0,"Vanish");
		TNT1 A 0 NoDelay;
		SMOK ABCDEFGHIJKLMNOPQR 2 { A_SetTranslucent(0.250,1); A_FadeOut(0.1,1);}
		Stop;
	Vanish:
		TNT1 A 0;
		Stop;
	}
}