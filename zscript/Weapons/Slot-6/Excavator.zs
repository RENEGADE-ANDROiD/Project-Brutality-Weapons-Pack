Class DropShotMode : Inventory{Default{Inventory.MaxAmount 1;}}
Class RespectExcavatorLauncher : Inventory{Default{Inventory.MaxAmount 1;}}
Class ExcavatorUnloaded : Inventory{Default{Inventory.MaxAmount 1;}}
Class ExcavatorRounds : Ammo{
	Default{
		Inventory.Amount 0;
		Inventory.MaxAmount 5;
		+INVENTORY.IGNORESKILL
		Inventory.Icon "5DUNA0";
	}
}
//5DKFE0.png
Class PB_Excavator : PB_WeaponBase
{
	//$Title Excavator
	//$Category Weapons
	//$Sprite 5DUNA0
	Default{
	////SpawnID 9530;
	Weapon.BobRangeX 0.3;
	Weapon.BobRangeY 0.5;
	Weapon.BobStyle "InverseSmooth";
	Weapon.BobSpeed 2.4;
	Weapon.AmmoUse1 0;
	Weapon.AmmoUse2 0;
	Weapon.AmmoGive 5;
	Weapon.AmmoType1 "PB_RocketAmmo";
	Weapon.AmmoType2 "ExcavatorRounds";
	Inventory.PickupSound "misc/ROCKBOXA";
	Inventory.PickupMessage "You got the Excavator!(Slot 6)";
	Obituary "Shattered Into Pieces By Excavator Launcher. Ouch!";
	+WEAPON.NOAUTOAIM
	+WEAPON.EXPLOSIVE
	+WEAPON.NOAUTOFIRE
	+FORCEXYBILLBOARD
	+FLOORCLIP
	+DONTGIB
	// Weapon.SlotNumber 6;
	Weapon.SlotPriority 0;
	Weapon.SelectionOrder 506;
	Scale 0.50;
	Tag "Excavator Launcher";
	Inventory.AltHudIcon "5DUNA0";
	PB_WeaponBase.RespectItem "RespectExcavatorLauncher";
	FloatBobStrength 0.5;
	}
	override void attachtoowner(actor other)
	{
		if(other && other.player)
		{
			if(other.countinv(ammotype2) < 1 &&(countinv(respectInventoryItem) < 1))other.A_giveinventory(ammotype2,GetAmmoCapacity(ammotype2));
		}
		super.attachtoowner(other);
	}
	Override void DoEffect(){
		if (!owner || !owner.player)
        return;

		Weapon rw = owner.player.ReadyWeapon;
		if (!rw)
        return;
		
		if( self.GetClass() is owner.player.readyweapon.GetClass() ){
			if( (owner.player.cmd.buttons & BT_ALTATTACK) && !owner.FindInventory("GrenadeDetonator") ){
				owner.A_SetInventory("GrenadeDetonator",1);owner.A_PlaySound("excavator/detonate");
			}
			if( !(owner.player.cmd.buttons & BT_ALTATTACK) && owner.FindInventory("GrenadeDetonator") ){
				owner.A_SetInventory("GrenadeDetonator",0);
			}
		}
	}
	States{
	Steady:
		TNT1 A 0;
		Goto Ready;

	Ready:
		TNT1 A 0;
	SelectAnimation:
		TNT1 A 0 A_PlaySound("RLANDRAW");
		5DKF IHGFE 1 ;
		//{return A_DoPBWeaponAction(WRF_ALLOWRELOAD);}
	Ready3:
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
			}
		TNT1 A 0;
		TNT1 A 0 A_JumpIfInventory("DropShotMode",1,"Ready2");
		TNT1 A 0 A_JumpIfInventory("ExcavatorUnloaded",1,"ExcavatorUnloaded");
	ExcavatorReadyToFire:
		TNT1 A 0 A_JumpIfInventory("ExcavatorUnloaded",1,"ExcavatorUnloaded");
		5DKF A 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		TNT1 A 0 A_JumpIfInventory("DropShotMode",1,"Ready2");
		TNT1 A 0 A_JumpIfInventory("GoFatality",1,"Steady");
		Loop;
	Ready2:
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
			}
		TNT1 A 0;
		TNT1 A 0 A_JumpIfInventory("ExcavatorUnloaded",1,"ExcavatorUnloaded");
	DrillChargeReadyToFire:
		TNT1 A 0 A_JumpIfInventory("ExcavatorUnloaded",1,"ReadyUnloaded");
		5DKF B 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		TNT1 A 0 A_JumpIfInventory("GoFatality",1,"Steady");
		Loop;
	ReadyUnloaded:
		5DKF S 1 A_DoPBWeaponAction(WRF_ALLOWRELOAD);
		Loop;
	SwitchToDigger:
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
			}
		TNT1 A 0;
		TNT1 A 0 A_Print("\cdDrill Charge \c-Mode Activated");
		TNT1 A 0 A_Takeinventory("GoWeaponSpecialAbility",1);
		TNT1 A 0 A_Takeinventory("DropShotMode");		
		7DKF LMNOP 1;
		TNT1 A 0 A_PlaySound("excavator/switch");		
		7DKF PONML 1 ;
		Goto Ready3	;

	Deselect:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
		}
		TNT1 A 0 A_PlaySound("weapons/changing", 1);
		5DKF EFGHI 1;
		TNT1 AAA 0 A_Lower;
		Wait;
	
	Select:
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
		}
		TNT1 A 0 A_TakeInventory("HasBarrel",1);
		TNT1 A 0 A_TakeInventory("HasIceBarrel",1);
		TNT1 A 0 A_TakeInventory("HasFlameBarrel",1);
		TNT1 A 0 A_TakeInventory("GrabbedBarrel",1);
		TNT1 A 0 A_TakeInventory("GrabbedIceBarrel",1);
		TNT1 A 0 A_TakeInventory("GrabbedFlameBarrel",1);
		Goto SelectFirstPersonLegs;
		SelectContinue:
		TNT1 AAAAAAAAAAAAAAAAAA 0 A_Raise;
		TNT1 AAAAAAAA 0 A_Raise;
		Wait;

	Fire:
		TNT1 A 0 PB_CheckBarrelThrow1();
		TNT1 A 0 {
				if(invoker.CountInv("NoFatality") == 0 && (ttwcfbex)) 
				{
					return PB_Execute();
				}
				return resolveState(null);
			}
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
		}
		TNT1 A 0 A_JumpIfInventory("ExcavatorRounds",1,1);
		Goto Reload;
		TNT1 AAAAAA 0 BRIGHT A_FireCustomMissile("ShotgunParticles", random(-16,16), 0, -1, random(-9,9));
		TNT1 A 0 A_FireBullets(0, 0, 1, 50, "shotpuff", 0, 130);
		TNT1 A 0 A_FireCustomMissile("RedFlareSpawn",-5,0,0,0);
		TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_FireCustomMissile("Alerter");
		TNT1 A 0 A_ZoomFactor(0.96);
		TNT1 A 0 {
			If(CountInv("DropShotMode")>0){
				A_StartSound("excavator/firedropshot", 0);A_FireProjectile("ExcavatorDropShot", 0, False, 0, 0, True, 0);
			}else{
				A_StartSound("excavator/firedigger", 18);A_FireProjectile("ExcavatorDrill", 0, False, 0, 0, True, 3);
			}
		}
		TNT1 A 0 PB_WeaponRecoil(-3.2,+1.61);//same as the SuperGL - sarge945
		6DKF A 2 BRIGHT ;
		5DKF JK 1 BRIGHT ;
		TNT1 A 0 A_TakeInventory("ExcavatorRounds",1);
		TNT1 A 0 A_FireCustomMissile("ShakeYourAssDouble", 0, 0, 0, 0);
		5DKF L 1 BRIGHT A_ZoomFactor(0.97);
		5DKF M 1 BRIGHT A_ZoomFactor(0.98);
		5DKF N 1 BRIGHT A_ZoomFactor(0.99);
		TNT1 A 0 A_ZoomFactor(1.0);
		5DKF OPQRDDD 1 A_WeaponReady(WRF_NOPRIMARY);
		TNT1 A 0 A_PlaySound("RLCYCLE2", 5);
		5DKF DDDDDD 1 A_WeaponReady(WRF_NOPRIMARY);
		5DKF D 0 A_ReFire;
		Goto Ready3;

	//AltFire:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "PlaceBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "PlaceFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "PlaceIceBarrel");
		TNT1 A 0 {
			A_WeaponOffset(0,32);
			A_SetRoll(0);
			A_TakeInventory("PB_LockScreenTilt",1);
		}
		//TNT1 A 0 A_JumpIfInventory("DropShotMode", 1, "DetonateDropShot");
		DETO B 0 A_PlaySound("excavator/detonate");
		TNT1 A 0 A_SetInventory("GrenadeDetonator",1);
		5DKF C 1 ;
		/*
		//TNT1 A 0 Thing_Projectile(1743,205,0,0,0);
		TNT1 A 0 Thing_Projectile(1743,"DrillBombExplode",0,0,0);
		//MGLG B 0 Thing_Projectile(1744,208,0,0,0);
		MGLG B 0 Thing_Projectile(1744,"DropShotExplode",0,0,0);
		TNT1 A 0 Thing_ReMove(1743);
		TNT1 A 0 Thing_ReMove(1744);
		*/
		TNT1 A 0 A_SetInventory("GrenadeDetonator",0);
		5DKF C 3;
		Goto Ready3;
	UnloadedReload:
		8DKF DCBA 1;
		TNT1 A 0 A_TakeInventory("ExcavatorUnloaded",1);
		goto ReloadFromUnload;
	Reload:
		"----" A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		"----" A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		"----" A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		"----" A 1 A_WeaponReady;
		TNT1 A 0 A_JumpIfInventory("ExcavatorRounds",0,"Ready3");
		TNT1 A 0 A_JumpIfInventory("PB_RocketAmmo",2,1);
		Goto Ready3;
		TNT1 A 0 A_JumpIfInventory("ExcavatorUnloaded",1,"UnloadedReload");
		6DKF A 1 A_PlaySound("Ironsights", 15);
		TNT1 A 0 A_SetRoll(roll-0.6,SPF_INTERPOLATE);
		6DKF BCDEF 1 ;
		TNT1 A 0 A_PlaySound("weapons/sgl/cycle", 14);
		TNT1 A 0 PB_SpawnCasing("SGL_Drum",25,0,20,Frandom(3,4),Frandom(3,4),1);
		//TNT1 A 0 A_FireCustomMissile("RocketCaseSpawn",-30,0,-4,-4);
		TNT1 A 0 A_SetRoll(roll+0.6,SPF_INTERPOLATE);
		6DKF GHIJK 1 ;
		TNT1 A 0 A_PlaySound("RLCYCLE2", 13);
		TNT1 A 0 A_SetRoll(0,SPF_INTERPOLATE);
		6DKF KKKKK 1 ;
		TNT1 A 0 A_PlaySound("weapons/minigun/respect1", 13);
		TNT1 A 0 A_SetRoll(roll-0.5,SPF_INTERPOLATE);
	ReloadFromUnload:
		TNT1 A 0 A_TakeInventory("ExcavatorUnloaded",1);
		6DKF LMNOPQRS 1 ;
		TNT1 A 0 A_PlaySound("weapons/nailgun/up", 10);
		TNT1 A 0 A_SetRoll(roll-0.5,SPF_INTERPOLATE);
		6DKF TUVWWWWW 1 ;
		TNT1 A 0 A_SetRoll(0,SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("Ironsights", 15);
		TNT1 A 0 A_SetRoll(roll+1.0,SPF_INTERPOLATE);
		6DKF XYZ 1 ;
		TNT1 A 0 A_PlaySound("weapons/sgl/inspect1", 15);
		7DKF A 1 PB_AmmoIntoMag("ExcavatorRounds","PB_RocketAmmo",5,2);
		TNT1 A 0 A_SetRoll(roll-1.0,SPF_INTERPOLATE);
		7DKF BCD 1 ;
		TNT1 A 0 A_SetRoll(0,SPF_INTERPOLATE);
		7DKF EFGHIJK 1 ;
		TNT1 A 0 A_PlaySound("excavator/detonate");
		5DKF CCDDCCDDCCDCDCD 1 ;
		Goto Ready3;
	Unload:
		6DKF A 1 A_PlaySound("Ironsights", 15);
		TNT1 A 0 A_SetRoll(roll-0.6,SPF_INTERPOLATE);
		6DKF BCDEF 1 ;
		TNT1 A 0 A_GiveInventory("ExcavatorUnloaded",1);
		TNT1 A 0 A_PlaySound("weapons/sgl/cycle", 14);
		//TNT1 A 0 A_FireCustomMissile("RocketCaseSpawn",-30,0,-4,-4);
		TNT1 A 0 A_SetRoll(roll+0.6,SPF_INTERPOLATE);
		6DKF GHI 1;
		6DKF J 1 PB_UnloadMag("ExcavatorRounds","PB_RocketAmmo",2);
		6DKF K 1;
		8DKF ABCD 1;
		goto ReadyUnloaded;
	Spawn:
		5DUN A -1;
		Stop;

	WeaponSpecial:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "IdleBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "IdleFlameBarrel");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "IdleIceBarrel");
		TNT1 A 0 {
			A_Takeinventory("GoWeaponSpecialAbility",1);
			A_GiveInventory("PB_LockScreenTilt",1);
			A_ClearOverlays(10,11);
			}
		TNT1 A 0 A_JumpIfInventory("DropShotMode", 1, "SwitchToDigger");
		TNT1 A 0 A_Print("\ciDrop Charge \c-Mode Activated");
		TNT1 A 0 A_GiveInventory("DropShotMode");		
		7DKF LMNOP 1;
		TNT1 A 0 A_PlaySound("excavator/switch");		
		7DKF PONML 1;
		Goto Ready2;

	FlashKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10,11);
		5DKF E 1 A_DoPBWeaponAction;
		5DKF FGHI 1 ;
		TNT1 A 4;
		5DKF IHGFE 1;
		Goto Ready3;

	FlashAirKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10,11);
		5DKF E 1 A_DoPBWeaponAction;
		5DKF FGHI 1 ;
		TNT1 A 8;
		5DKF IHGFE 1;
		Goto Ready3;

	FlashSlideKicking:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10,11);
		5DKF E 1 A_DoPBWeaponAction;
		5DKF EFGHI 1 ;
		TNT1 A 16;
	FlashSlideKickingStop:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10,11);
		5DKF I 1 A_DoPBWeaponAction;
		5DKF IIHGFE 1;
		Goto Ready3;

	FlashPunching:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10,11);
		7DKF L 1 A_DoPBWeaponAction;
		7DKF MNOP 1;
		7DKF P 4;
		7DKF PONML 1;
		Stop;
	FlashPunchingStop:
		TNT1 A 0 A_JumpIfInventory("GrabbedBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedFlameBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_JumpIfInventory("GrabbedIceBarrel", 1, "FlashBarrelPunching");
		TNT1 A 0 A_ClearOverlays(10,11);
		7DKF L 1 A_DoPBWeaponAction;
		Stop;
	}
}
Class DiggerTrail : Actor{
	Default{
		Scale 1.1;
		+noteleport
		+NOINTERACTION
		+DOOMBOUNCE
		+RANDOMIZE
		height 1;
		radius 1;
	}
	States{
	Spawn:
		TNT1 A 0 A_SetScale(ScaleX*frandom(0.85,1.35), ScaleY*frandom(0.9,1.25));
		SPIK ABBCCBBA 2;
		SPIK A 60;
		SPIK AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 1 A_FadeOut(0.02);
		Stop;
	}
}
Class ExcavatorExplode : Actor{
	Default{
		Projectile;
		Scale 1.15;
		DamageType "ExplosiveImpact";
		+THRUSPECIES
		+MTHRUSPECIES
		Species "Marines";
	}
	States{
	Death:
		TNT1 A 0 A_SpawnItemEx("DetectFloorCrater",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("DetectCeilCrater",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		//TNT1 A 0 A_SpawnItemEx("UnderwaterExplosion",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("NewGroundExplosionSmoke",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 AAAA 0 A_CustomMissile("FireworkSFXType2", 0, 0, random(0, 360), 2, random(30, 60));
		TNT1 A 0 A_CustomMissile("ExcavatorExploFX", random(1,5), random(-10,10), random(0, 360), 2, random(0, 360));
		TNT1 A 0 A_SpawnItemEx("LiquidExplosionEffectSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_Playsound("excavator/explode", 1);
		TNT1 A 0 A_PlaySound("FAREXPL", 3);
		Stop;
	}
}
Class ExcavatorExplosion : actor{
	Default{
		Radius 2;
		Height 2;
		Damagetype "ExplosiveImpact";
		+THRUSPECIES
		+MTHRUSPECIES
		Species "Marines";
		+FORCERADIUSDMG
		+NOBLOCKMAP
		+MISSILE
	}
	States{
	Spawn:
		Goto Death;
	Death:
		TNT1 A 2 NODELAY A_SpawnItem("WhiteShockwaveBig");
		TNT1 A 0 A_Explode(200, 100, xf_hurtsource, 0, 90,0,0,"None","Explosive");
		TNT1 A 0 A_Explode(125,140, xf_hurtsource, 0, 100);
		Stop;
	}
}
Class DropShotExplode : ExcavatorExplode{
	Default{
		Radius 20;
		Height 10;
		Speed 25;
		//SpawnID 208;
		Damagetype "ExplosiveImpact";
		+MISSILE
		+Ripper
		+NOBOSSRIP
		+SKYEXPLODE
		Damage 20;
	}
	States{
	Spawn:
		TNT1 A 0 NODELAY A_ChangeFlag("Thruactors", 1);
		5DKP A 2 A_SpawnItem("YellowFlareSmall",-2,0);
		5DKP B 4 A_Playsound("Weapons/StickyBombTick", 3);
		5DKP C 2 A_SpawnItem("YellowFlareSmall",-2,0);
		5DKP D 4;
		TNT1 A 0 A_ChangeFlag("Thruactors", 0);
		TNT1 A 0 A_SpawnItem("YellowFlareSmall",-2,0);
	Fall:
		5DKP D 1 A_CheckFloor("Boom");
		//TNT1 A 0 A_Explode(20, 30)
		TNT1 A 0 ThrustThingZ(0, 30, 1, 1);
		Loop;
	Boom:
	Death:
		TNT1 A 0 A_Playsound("superbaron/spike");
		TNT1 AAAAA 0 NODELAY {A_CustomMissile("MudDust", 0, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("DirtChunk1", 0, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("DirtChunk2", 10, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("BrownCloud", 0, 0, random(0, 90), 2, random(30, 150));}
		XXXX A 0 A_CustomMissile("ExplosionQuake", 1, 0, random(0, 360), 2, random(0, 160));
		TNT1 A 0 {A_SpawnItemEx("DiggerTrail",random(-3, 0),random(-3, -1),0,0,0,0,0,SXF_NOCHECKPOSITION,0);A_SpawnItemEx("DiggerTrail",random(0, 3),random(1, 3),0,0,0,0,0,SXF_NOCHECKPOSITION,0);}
		5DKP DDDDDDDDDDDDDD 1 A_CustomMissile("HeavyExplosionSmoke", 2, 0, random(0, 360), 2, random(0, 360));
		EXPL A 0 Radius_Quake(3, 24, 0, 15, 0);//(intensity, duration, damrad, tremrad, tid)
		//TNT1 A 0 A_CustomMissile("BigRicoChet");
		//TNT1 A 0 A_SpawnItem("BigRicoChet", 0, -30);
		
		TNT1 AAAAAAAAA 0 {A_CustomMissile("ExplosionParticleHeavy", 0, 0, random(0, 360), 2, random(0, 180));A_CustomMissile("ExplosionParticleVeryFast", 0, 0, random(0, 360), 2, random(0, 360));}
		TNT1 AAAAA 0 {A_CustomMissile("MediumExplosionFlames", 0, 0, random(0, 360), 2, random(0, 360));A_CustomMissile("ExplosionSmokeFast22", 0, 0, random(0, 360), 2, random(0, 360));}
		TNT1 A 0 A_SpawnItemEx("ExcavatorExplosion",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		goto Super::Death;
	}
}
Class DrillBombExplode : ExcavatorExplode{
	Default{
		SeeSound "superbaron/spike";
		Radius 2;
		Height 1;
		Speed 0;
		//SpawnID 205;
		+NOCLIP
		+Thruactors
	}
	States{
	Spawn:
	Death:
		TNT1 AAAAA 0 NODELAY {A_CustomMissile("MudDust", 0, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("DirtChunk1", 0, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("DirtChunk2", 10, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("BrownCloud", 0, 0, random(0, 90), 2, random(30, 150));}
		XXXX A 0 A_CustomMissile("ExplosionQuake", 1, 0, random(0, 360), 2, random(0, 160));
		TNT1 A 0 A_Explode(15, 32, 0, 12);
		5DKP EFGHIJIKLMNOONNML 1 BRIGHT ;
		EXPL A 0 Radius_Quake(3, 8, 0, 15, 0);//(intensity, duration, damrad, tremrad, tid)
		//TNT1 A 0 A_CustomMissile("BigRicoChet");
		//TNT1 A 0 A_SpawnItem("BigRicoChet", 0, -30);
		
		
		TNT1 AAAAAAAAA 0 {A_CustomMissile("ExplosionParticleHeavy", 12, 0, random(0, 360), 2, random(0, 180));A_CustomMissile("ExplosionParticleVeryFast", 12, 0, random(0, 360), 2, random(0, 360));}
		TNT1 AAAAA 0 {A_CustomMissile("MediumExplosionFlames", 12, 0, random(0, 360), 2, random(0, 360));A_CustomMissile("ExplosionSmokeFast22", 12, 0, random(0, 360), 2, random(0, 360));}
		TNT1 A 0 A_SpawnItemEx("ExcavatorExplosion",0,0,12,0,0,0,0,SXF_NOCHECKPOSITION,0);
		goto Super::Death;
	}
}
Class ExcavatorDrillBomb : Actor{
	Default{
		Radius 8;
		Height 4;
		Speed 12;
		Damage 1;
		DamageType "ExplosiveImpact";
		+Ripper
		+FloorHugger
		+BloodlessImpact
		+THRUSPECIES
		+MTHRUSPECIES
		Species "Marines";
		Projectile;
		Missileheight 0;
	}
	Override Void Tick(){
		if(target.CountInv("GrenadeDetonator")){A_StopSound(5);A_SpawnItemEx("DrillBombExplode",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);Destroy();}
		Super.Tick();
	}
	States{
	Spawn:
		TNT1 A 1 NODELAY A_StartSound("excavator/digloop", 5, CHANF_OVERLAP,1.0,ATTN_NONE);
	Travel:
		TNT1 A 3 ;
		TNT1 A 0 {A_SpawnItemEx("DiggerTrail",random(-2, 2),random(-1, 1),0,0,0,0,0,SXF_NOCHECKPOSITION,0);A_CustomMissile("MudDust", 0, 0, random(0, 360), 2, random(30, 150));Radius_Quake(2, 8, 0, 8, 0);}
		TNT1 AA 0 {A_CustomMissile("DirtChunk1", 0, 0, random(0, 360), 2, random(30, 150));A_CustomMissile("DirtChunk2", 0, 0, random(0, 360), 2, random(30, 150));}
		Loop;
	Death:
		TNT1 A 0 {A_StopSound(5);A_SpawnItemEx("DrillBombExplode",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);}
		Stop;
	}
}
Class ExcavatorDrill : Actor{
	Default{
		+MISSILE
		//+Ripper
		+SOLID
		+BOUNCEONWALLS
		+BOUNCEONFLOORS
		+BOUNCEONCEILINGS
		+CANBOUNCEWATER
		+MOVEWITHSECTOR
		+USEBOUNCESTATE
		+DONTSPLASH
		+SKYEXPLODE
		+THRUSPECIES
		+MTHRUSPECIES
		Species "Marines";
		Scale 1.15;
		Speed 25;
		Radius 6;
		Height 6;
		Gravity 1.25;
		Damage 50;
		DamageType "ExplosiveImpact";
		Decal "Scorch";
	}
	States{
	Spawn:
		TNT1 A 0 NODELAY A_CheckFloor("Dig");
		5DKP A 2 BRIGHT A_SpawnItem("RocketSmokeTrail52");
		TNT1 A 0 A_SpawnItem("RocketFlare",-2,0);
		TNT1 A 0 A_CheckFloor("Dig");
		5DKP A 2 BRIGHT A_SpawnItem("RocketSmokeTrail52");
		TNT1 A 0 A_CheckFloor("Dig");
		Loop;
	Dig:
	Bounce.Floor:
	Death:
		TNT1 A 0 ;
		TNT1 A 0 A_Playsound("excavator/digging");
		TNT1 A 0 A_CustomMissile("ExcavatorDrillBomb", 1, 0, 180);
		Stop;
	Crash:
	Bounce.Ceiling:
	Bounce.Walls:
		TNT1 A 0 A_StopSound(6);
		EXPL A 0 Radius_Quake(3, 24, 0, 15, 0);//(intensity, duration, damrad, tremrad, tid)
		//TNT1 A 0 A_CustomMissile("BigRicoChet");
		//TNT1 A 0 A_SpawnItem("BigRicoChet", 0, -30);
		TNT1 A 0 A_SpawnItemEx("DetectFloorCrater",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("DetectCeilCrater",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		//TNT1 A 0 A_SpawnItemEx("UnderwaterExplosion",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("NewGroundExplosionSmoke",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 AAAAAAAAA 0 {A_CustomMissile("ExplosionParticleHeavy", 0, 0, random(0, 360), 2, random(0, 180));A_CustomMissile("ExplosionParticleVeryFast", 0, 0, random(0, 360), 2, random(0, 360));}
		TNT1 AAAAA 0 {A_CustomMissile("MediumExplosionFlames", 0, 0, random(0, 360), 2, random(0, 360));A_CustomMissile("ExplosionSmokeFast22", 0, 0, random(0, 360), 2, random(0, 360));}
		TNT1 A 0 A_CustomMissile("ExcavatorExploFX", random(1,5), random(-10,10), random(0, 360), 2, random(0, 360));
		TNT1 A 0 A_SpawnItemEx("ExcavatorExplosion",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_SpawnItemEx("LiquidExplosionEffectSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
		TNT1 A 0 A_Playsound("excavator/explode", 1);
		TNT1 A 0 A_PlaySound("FAREXPL", 3);
		Stop;
	}
}
Class ExcavatorDropShot : Actor{
	Default{
		Projectile;
		+MISSILE
		//+Ripper
		+NOGRAVITY
		+MOVEWITHSECTOR
		+EXPLODEONWATER
		+USEBOUNCESTATE
		+DONTSPLASH
		+SKYEXPLODE
		+THRUSPECIES
		+MTHRUSPECIES
		Species "Marines";
		Speed 35;
		Radius 6;
		Height 6;
		Damage 50;
		Scale 1.15;
		DamageType "ExplosiveImpact";
		Decal "Scorch";
	}
	Override Void Tick(){
		if(target.CountInv("GrenadeDetonator")){A_StopSound(5);A_SpawnItemEx("DropShotExplode",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);Destroy();}
		Super.Tick();
	}
	States{
	Spawn:
		TNT1 A 0 A_StartSound("excavator/digloop", 5, CHANF_OVERLAP,1.0,ATTN_NONE);
		//TNT1 A 0 Thing_ChangeTid(0,1744);
	Travel:
		5DKP A 2 BRIGHT A_SpawnItem("RocketSmokeTrail52");
		TNT1 A 0 A_SpawnItem("GreenFlareSmall",-2,0);
		TNT1 A 0 A_CustomMissile("ShotgunParticles", 0, 0, random(0, 360), 2, random(30, 150));
		5DKP A 2 BRIGHT A_SpawnItem("RocketSmokeTrail52");
		Loop;
	Death:
	Crash:
	Bounce.Ceiling:
	Bounce.Walls:
	Bounce.Floor:
		TNT1 A 0 A_SpawnItemEx("DropShotExplode",0,0,-5,0,0,0,0,SXF_NOCHECKPOSITION,0);
		Stop;
	}
}