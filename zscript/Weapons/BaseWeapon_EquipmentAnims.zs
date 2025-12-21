extend class PB_WeaponBase
{
	States
	{
		// Freeze Bot
		ThrowFreezebot:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("FreezeBotAmmo", 1, 2);
			TNT1 A 0 A_Print("No Freeze Bot available");
			Goto GoingToReady;

			FZBW BCDEF 2;
			TNT1 A 0 A_PlaySound ("Plasma/Beep");
			TNT1 A 0 A_Giveinventory("PlayerIsThrowingAGrenade",1);
			FZBW GH 4;
			FZBW IJKL 2;
			TNT1 A 1;
			TNT1 A 0 A_PlaySound ("Plasma/Beep");
			FZBW M 1;
			TNT1 A 0 A_FireCustomMissile("FreezebotInactive", random(-2,2), 1, 0, 0, 0, 0);
			TNT1 A 0 A_TakeInventory("FreezeBotAmmo", 1);
			TNT1 A 0 A_TakeInventory("PlayerIsThrowingAGrenade", 1);
			FZBW NO 1;
			TNT1 A 3;

			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		// Beacon
		ThrowBeacon:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("BeaconAmmo", 1, 2);
			TNT1 A 0 A_Print("No Beacon available");
			Goto GoingToReady;
			
			BEAC D 1;
    		2YBF G 1 A_SpawnItemEx("ActiveBeacon",40,0,8,2,0,2,0,SXF_NOCHECKPOSITION,0);
			TNT1 A 0 A_TakeInventory("BeaconAmmo", 1);
			2YBF GGHIJKLMNOPQ 1;
			
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;

		// Caltrops
		ThrowCaltrops:
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(90);
			}
			TNT1 A 0 A_SetInventory("PB_LockScreenTilt",1);
			TNT1 A 0 A_JumpIfInventory("ShurikenAmmo", 1, 2);
			TNT1 A 0 A_Print("You Don't Have any Caltrops");
			Goto GoingToReady;
			TNT1 A 0 A_Overlay(799,"FlashPunching");

			SH1R A 2;
			SH1R ATT 1 A_GunFlash("CaltropsFlash");
			SH1R U 1 A_FireCustomMissile("CaltropsMissile", -3, 0, -5, -4);
			TNT1 A 0;
			SH1R U 1 A_FireCustomMissile("CaltropsMissile", 0, 0, -7, -4);
			TNT1 A 0;
			SH1R U 1 A_FireCustomMissile("CaltropsMissile", 3, 0, -9, -4);
			SH1R TA 1;

			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		// Shurikens
		ThrowShuriken:
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(90);
			}
			TNT1 A 0 A_SetInventory("PB_LockScreenTilt",1);
			TNT1 A 0 A_JumpIfInventory("ShurikenAmmo", 1, 2);
			TNT1 A 0 A_Print("You Don't Have any Shurikens");
			Goto GoingToReady;
			TNT1 A 0 A_Overlay(799,"FlashPunching");

			SH1R A 1;
			SH1R B 1;
			SH1R C 1;
			SH1R D 1;
			SH1R E 1{
				if (CountInv("PB_PowerStrength") == 1 ) 
				{ 
					A_FireCustomMissile("PowerSHURiken", -3, 0, -3);
					A_FireCustomMissile("PowerSHURiken", 0, 1, 0, 2);
					A_FireCustomMissile("PowerSHURiken", 3, 0, 3);
				}
				else 
				{ 
					A_FireCustomMissile("SHURiken", -3, 0, -3);
					A_FireCustomMissile("SHURiken", 0, 1, 0, 2);
					A_FireCustomMissile("SHURiken", 3, 0, 3);
				}
				A_TakeInventory("ShurikenAmmo", 1);
				A_PlaySound("PUNCH");
			}
			SH1R F 1;
			SH1R G 1;
        	SH1R H 1;

			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		//ShieldSaw
		ThrowShieldSaw:
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(90);
			}
			TNT1 A 0 A_SetInventory("PB_LockScreenTilt",1);
			TNT1 A 0 A_JumpIfInventory("ShieldSawAmmo", 1, 2);
			TNT1 A 0 A_Print("You Don't Have the Shield Saw");
			Goto GoingToReady;
			TNT1 A 0 A_Overlay(799,"FlashPunching");
			TNT1 AAA 0;
       		SHIE I 1 A_StopSoundEx("Soundslot5");
			SHIE J 1 A_WeaponOffset(-20,50, WOF_ADD);
			SHIE K 1 A_WeaponOffset(-50,50, WOF_ADD);
			SHIE J 1 A_WeaponOffset(-70,50, WOF_ADD);
			SHIE K 1 A_WeaponOffset(-100,50, WOF_ADD);
			SHIE J 2 A_WeaponOffset(-140,70, WOF_ADD);
			SHIE K 2 A_WeaponOffset(-160,90, WOF_ADD); 
			TNT1 A 0 A_PlaySoundEx("ShieldSawSwing","Soundslot6");
			SHIE K 1 A_AlertMonsters;
			SHIE K 1 A_StartSound("ShieldSawThrow",1,0.8);
			SHIE L 1 A_WeaponOffset(-160,200, WOF_ADD); 
			SHIE L 1 A_FireProjectile("ShieldSawProjectile",frandom(1.5,-1.5),0,7,-2,0,frandom(1.5,-1.5));
	   		TNT1 A 0 A_TakeInventory("ShieldsawAmmo",1);
			TNT1 A 0 A_GiveInventory("AlreadyThrownShieldSaw",1); // Gives the already thrown token
			SHIE LL 2 A_WeaponOffset(-160,200, WOF_ADD);
       		SHIE M 2 A_WeaponOffset(-140,220, WOF_ADD);
       		SHIE NO 2 A_WeaponOffset(-100,230, WOF_ADD);
			TNT1 A 0 PB_WeaponRecoil(-1.20,+0.20);
			SHIE O 1;
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;

		//MeatHook
		ThrowHook:
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(90);
			}
			TNT1 A 0 A_SetInventory("PB_LockScreenTilt",1);
			TNT1 A 0 A_JumpIfInventory("HookAmmo", 1, 2);
			TNT1 A 0 A_Print("You Don't Have the Meat Hook");
			Goto GoingToReady;
			TNT1 A 0 A_Overlay(799,"FlashPunching");
			GRTH OOPPQQ 1 A_StartSound("THRGRN", 1);
			GRTH Q 1 A_FireProjectile("HookShot",0,0,0,0,0,0);
			GRTH RRSSTTUU 1;
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;

		//Axe
		ThrowAxe:
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_SetRoll(0);
				PB_HandleCrosshair(90);
				A_Overlay(PSP_FLASH,"FlashPunching");
			}
			TNT1 A 0 A_SetInventory("PB_LockScreenTilt",1);
			TNT1 A 0 A_JumpIfInventory("PB_Axe", 1, 2);
			TNT1 A 0 A_Print("No Axe left");
			Goto GoingToReady;
			AX31 ABCDEFGHIJKLMNOPQ 0;
			AX32 ABCDEFGHIJKLMNOPQ 0;
			AX33 ABCDEFGHIJKLMNOPQ 0;
			TNT1 A 0 A_PlaySound("AXTHROW");
			AX30 ABCDEFGHIJKLMNOPQ 1 {
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX33"); }
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX32"); }
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX31"); }
				A_Setroll(roll+0.5, SPF_INTERPOLATE);
			}
			TNT1 A 0 {
			if(CountInv("PowerGreenBloodOnVisor") >=1 ) {A_FireCustomMissile("ThrownAxe_Green", 0, 0, 0, 0);}
			else if (CountInv("PowerBlueBloodOnVisor") >=1 ) {A_FireCustomMissile("ThrownAxe_Blue", 0, 0, 0, 0);}
            else if (CountInv("PowerBloodOnVisor") >=1 ) {A_FireCustomMissile("ThrownAxe_Red", 0, 0, 0, 0);}
            else {
			A_FireCustomMissile("ThrownAxe", 0, 0, 0, 0);
			}
			}
			TNT1 A 0 A_TakeInventory("PB_Axe", 1);
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		
		//Electric Pod
		ThrowElecPod:	
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("ElecPodAmmo", 1, 2);
			TNT1 A 0 A_Print("No Electrid Pods left");
			Goto GoingToReady;
			XPFF FEDCBA 1;
			XPFS B 4 A_StartSound("weapons/pbarm", 2);
			XHFF A 0 {
				A_StartSound("MINE002", 3);
				A_ThrowGrenade("ElectricPodSet",4,11,1,0);
				A_TakeInventory("ElecPodAmmo", 1);
			}
			XHFF MNOPQRSTUVWXYZ 1;
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//Acid Charge
		ThrowAcidCharge:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(CountInv("AcidChargeAmmo") < 1, "Detonator");
			
			REMT ABCD 1;
			REMT EFG 1{
			// Check during animation — if player presses again, flag UseEquipment
			if (JustPressed(BT_USER1)) A_GiveInventory("QuickDetonator", 1);
			}
			REMT HIJKLMNOPQ 1{
			if (JustPressed(BT_USER1)) A_GiveInventory("QuickDetonator", 1);
			}
			// Before firing projectile, see if player triggered alt behavior
			TNT1 A 0 A_JumpIfInventory("QuickDetonator", 1, "Detonator");
			
			//REMT ABCDEFGHIJKLMNOPQ 1;
			THRO ABCD 1;
			TNT1 A 0 {
				A_PlaySound("charge/place/remote", 3);
				A_FireCustomMissile("ThrownAcidCharge",0,0,0,-1);
				A_TakeInventory("AcidChargeAmmo", 1);
			}
			THRO EEEEFGHI 1;
		
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//Laser Charge
		ThrowLaserCharge:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(CountInv("LaserChargeAmmo") < 1, "Detonator");
			
			LSRC ABCD 1;
			LSRC EFG 1{
			// Check during animation — if player presses again, flag UseEquipment
			if (JustPressed(BT_USER1)) A_GiveInventory("QuickDetonator", 1);
			}
			LSRC HIJKLMNOPQ 1{
			if (JustPressed(BT_USER1)) A_GiveInventory("QuickDetonator", 1);
			}
			// Before firing projectile, see if player triggered alt behavior
			TNT1 A 0 A_JumpIfInventory("QuickDetonator", 1, "Detonator");
			
			//LSRC ABCDEFGHIJKLMNOPQ 1;
			THRO ABCD 1;
			TNT1 A 0 {
				A_PlaySound("charge/place/laser", 3);
				A_FireCustomMissile("ThrownLaserCharge",0,0,0,-1);
				A_TakeInventory("LaserChargeAmmo", 1);
			}
			THRO EEEEFGHI 1;
			
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//Swarm Pod
		ThrowSwarmer:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(CountInv("SwarmerAmmo") < 1, "Detonator");

			SWRM ABCD 1;
			SWRM EFG 1{
			// Check during animation — if player presses again, flag UseEquipment
			if (JustPressed(BT_USER1)) A_GiveInventory("QuickDetonator", 1);
			}
			SWRM HIJLMNOPQ 1{
			if (JustPressed(BT_USER1)) A_GiveInventory("QuickDetonator", 1);
			}
			// Before firing projectile, see if player triggered alt behavior
			TNT1 A 0 A_JumpIfInventory("QuickDetonator", 1, "Detonator");
			
			//SWRM ABCDEFGHIJLMNOPQ 1;
			THRO ABCD 1;
			TNT1 A 0 {
				A_PlaySound("charge/place/swarm", 3);
				A_FireCustomMissile("ThrownSwarmCharge",0,0,0,-1);
				A_TakeInventory("SwarmerAmmo", 1);
			}
			THRO EEEEFGHI 1;

			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//ShieldGrenade
		ThrowShieldGrenade:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("ShieldGrenadeAmmo", 1, 2);
			TNT1 A 0 A_Print("No Shield Grenades left");
			Goto GoingToReady;
			
			SHIG CDEFGH 1;
			TNT1 A 0 A_StartSound("StunGrenadeArm", 2);
			SHIG IJKLMNOP 1;
			
			GRTH OPQ 1 A_StartSound("THRGRN", 1);
			TNT1 A 0 A_TakeInventory("ShieldGrenadeAmmo", 1);
			GRTH Q 1 A_FireProjectile("ThrownShieldGrenade",0,0,0,0,0,0);
			GRTH RSTU 1;
			
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		
		//VoidGrenade
		ThrowVoidGrenade:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("VoidGrenadeAmmo", 1, 2);
			TNT1 A 0 A_Print("No Void Grenades left");
			Goto GoingToReady;
			TNT1 A 0 A_Giveinventory("PlayerIsThrowingAGrenade",1);
			
			VGRN NOPQ 1;
			TNT1 A 0 A_StartSound("grenade/arm/void", 2);
			VGRN VWXCD 1;
			
			GRTH OPQ 1 A_StartSound("THRGRN", 1);
			TNT1 A 0 A_TakeInventory("VoidGrenadeAmmo", 1);
			GRTH Q 1 A_FireProjectile("ThrownVoidGrenade",0,0,0,0,0,0);
			GRTH RSTU 1;
			
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
				A_TakeInventory("PlayerIsThrowingAGrenade", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		
		//Detonator
		Detonator:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("DetonatorAmmo", 1, 2);
			TNT1 A 0 A_Print("You Don't Have a Detonator, Pickup Any Remote Charges First");
			Goto GoingToReady;

			TNT1 A 0 {
				A_Overlay(799,"FlashPunching");
				A_PlaySound("charge/detonator", 3);
			}
			DETO ABCD 1;
			TNT1 A 0 A_GiveInventory("RemoteChargeDetonator",1);
			DETO E 6;
			TNT1 A 0 A_TakeInventory("RemoteChargeDetonator",1);
			DETO DCBA 1;
			
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
				A_TakeInventory("QuickDetonator", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		
		//Leech
		LeechBeam:
			SYNP WXYZWXYZWXYZ 1 BRIGHT;
			SYNP WXYZWXYZWXYZ 1 BRIGHT;
			SYNP WXYZWXYZWXYZ 1 BRIGHT;
			SYNP WXYZWXYZWXYZ 1 BRIGHT;
			stop;
		ThrowLeech:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("PB_Dtech", 100, 2);
			TNT1 A 0 A_Print("Need more Demon Energy");
			Goto GoingToReady;
			TNT1 A 1 {A_WeaponOffset(-8,108);A_StartSound("SiphonGrowl");}
			SYNP G 1 A_WeaponOffset(-7,98);
			SYNP H 1 A_WeaponOffset(-6,88);
			SYNP H 1 A_WeaponOffset(-5,78);
			SYNP I 1 A_WeaponOffset(-4,68);
			SYNP I 1 A_WeaponOffset(-3,58);
			SYNP J 1 A_WeaponOffset(-2,48);
			SYNP J 1 A_WeaponOffset(-1,38);
			SYNP GHIHIJGJIHG 2 A_WeaponOffset(0,32);
			SYNP G 1 A_WeaponOffset(-2,40);
			SYNP H 1 A_WeaponOffset(-4,50);
			SYNP I 1 A_WeaponOffset(-6,60);
			SYNP J 1 A_WeaponOffset(-8,70);
			SYNP KLMNO 1 A_WeaponOffset(0,32);
			TNT1 A 0 A_Overlay(-5, "LeechBeam");
			TNT1 A 0 A_StartSound("SiphonActive", 3);
			TNT1 A 0 A_TakeInventory("PB_Dtech", 100);
			SYNP ABCDEFABCDEFABCDEFABCDEF 2 A_FireBullets(0, 0, -1, 3, "SiphonPuff", FBF_NORANDOM);
			SYNP ONMLK 1;
			TNT1 A 0 {
				A_WeaponOffset(0,32);
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//Stun
		ThrowStun:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("PB_StunGrenadeAmmo", 1, 2);
			TNT1 A 0 A_Print("No Stun Grenades left");
			Goto GoingToReady;
			STNG BCDEF 1;
			STNG F 1 Offset(-2,34);
			TNT1 A 0 A_StartSound("StunGrenadeArm", 2);
			STNG GIJJJIHGKLMNOP 1;
			
			HND1 I 1 A_StartSound("THRGRN", 1);
			TNT1 A 0 A_TakeInventory("PB_StunGrenadeAmmo", 1);
			HND1 J 1 A_FireProjectile("ThrownStunGrenade",0,0,0,0,0,0);
			HND1 KLMNOPQ 1;
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//RevGun	
		FireRevGun:
			TNT1 A 0 {
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("PB_QuickLauncherAmmo", 1, 2);
			TNT1 A 0 A_Print("No Revenant Launcher Ammo");
			stop;
			TNT1 A 0 {A_StartSound("revup", CHAN_AUTO, CHANF_OVERLAP);}
			RVCA ABCDEFGHIJK 1;
			RVCF AB 1;
		FiringRevGun:
			TNT1 A 0 {if (player.FindPSprite(PSP_WEAPON) && InStateSequence(player.FindPSprite(PSP_WEAPON).curstate, ResolveState("Deselect"))){return ResolveState("FireRevGunDeselect");} return ResolveState(null);}
			RVCF C 1 {
				A_AlertMonsters();
				A_TakeInventory("PB_QuickLauncherAmmo", 1);
					/*
					if(!FindInventory("PB_RevLauncherFireCount")){A_AlertMonsters();}
					if(CountInv("PB_RevLauncherFireCount")<3){A_GiveInventory("PB_RevLauncherFireCount",1);
					}else{A_TakeInventory("PB_QuickLauncherAmmo", 1);A_SetInventory("PB_RevLauncherFireCount",0);}
					*/
				A_FireProjectile("Alerter",0,0,-1,0);
				A_StartSound("hellishmissle/fire",CHAN_AUTO, CHANF_OVERLAP);
			}
			RVCF D 1 BRIGHT A_FireProjectile("DoomerRevenantSeeker3", random(4,-4), 0, -8, 0);
			RVCF E 1 BRIGHT {
				A_StartSound("hellishmissle/fire", CHAN_AUTO, CHANF_OVERLAP);
				A_FireProjectile("ShakeYourAss",0,0,0,0,0,0);
				A_FireProjectile("DoomerRevenantSeeker2", random(4,-4), 0, 8, 0);
			}
			RVCF FG 1 BRIGHT {if (player.FindPSprite(PSP_WEAPON) && InStateSequence(player.FindPSprite(PSP_WEAPON).curstate, ResolveState("Deselect"))){return ResolveState("FireRevGunDeselect");} return ResolveState(null);}
			RVCF HI 1 {if (player.FindPSprite(PSP_WEAPON) && InStateSequence(player.FindPSprite(PSP_WEAPON).curstate, ResolveState("Deselect"))){return ResolveState("FireRevGunDeselect");} return ResolveState(null);}
			TNT1 A 0 A_JumpIf(CountInv("PB_QuickLauncherAmmo") > 0 && PressingUser1(), "FiringRevGun");
			goto FireRevGunFinish;
		FireRevGunFinish:
			RVCF BA 1 {
				if(CountInv("PB_QuickLauncherAmmo") < 1 && PressingUser1()){
					A_Print("No Revenant Launcher Ammo");
				}
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			RVCA K 1 A_StartSound("revcyc", CHAN_AUTO, CHANF_OVERLAP);
			RVCA JIHGFEDCB 1;
			RVCA A 1 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			stop;
		FireRevGunDeselect:
			RVCA H 1 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
				A_StartSound("revcyc", CHAN_AUTO, CHANF_OVERLAP);
			}
			RVCA FDCB 1;
			stop;
			
		//Grenade	
		ThrowGrenade:
			TNT1 A 0 {
				A_StopSound(6);
				A_StopSound(CHAN_VOICE);
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("PB_GrenadeAmmo", 1, 2);
			TNT1 A 0 A_Print("No Grenades left");
			Goto GoingToReady;
			TNT1 A 0 A_Giveinventory("PlayerIsThrowingAGrenade",1);
			
			HNDF ABCDE 1 A_SetRoll(roll+2.0, SPF_INTERPOLATE);
			HNDF FGHI 1 {
				A_SetRoll(roll+2.0, SPF_INTERPOLATE);
				if(JustPressed(BT_USER1)) A_GiveInventory("UseEquipment",1);
				}
			TNT1 A 0 A_StartSound("OPNGRN",0);
			HNDF JKLMNOPQR 1 {
				A_SetRoll(roll+2.0, SPF_INTERPOLATE);
				if(JustPressed(BT_USER1)) A_GiveInventory("UseEquipment",1);
				}
				
			TNT1 A 0 A_JumpIfInventory("UseEquipment", 1, "TossGrenade");
			TNT1 A 1 A_SetRoll(roll-18.0);
			HND1 I 1 A_StartSound("THRGRN",0);
			HND1 J 1 {
				A_FireProjectile("PB_ThrownGrenade",0,0,0,0,0,0);
				A_TakeInventory("PB_GrenadeAmmo", 1);
				A_FireProjectile("Alerter",0,0,0,0,0,0);
			}
			HND1 KLMNOPQ 1 A_SetRoll(roll-5.0);
			TNT1 A 0 {
			A_SetRoll(0, SPF_INTERPOLATE);
			A_TakeInventory("UseEquipment", 1);
			A_TakeInventory("ToggleEquipment", 1);
			A_TakeInventory("PlayerIsThrowingAGrenade", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
		TossGrenade:
			TNT1 A 1;
			HND1 RSTU 1 A_SetRoll(roll-1.5, SPF_INTERPOLATE);
			TNT1 A 0 {
				A_StartSound("THRGRN", 1);
				A_TakeInventory("PB_GrenadeAmmo", 1);
				A_FireProjectile("Alerter",0,0,0,0,0,0);
				A_FireProjectile("ThrownGrenade15", 0,0,0,-2,0,3);
			}
			HND1 VWXY 1 A_SetRoll(roll-1.5, SPF_INTERPOLATE);
			TNT1 A 0 {
				A_SetRoll(0);
				A_TakeInventory("PB_LockScreenTilt",1);
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
				A_TakeInventory("PlayerIsThrowingAGrenade", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
			
		//Mine	
		ThrowMine:
			TNT1 A 0 {
				A_ZoomFactor(1.0);
				A_TakeInventory("ADSMode", 1);
				A_TakeInventory("UseEquipment", 1);
			}
			TNT1 A 0 A_JumpIfInventory("PB_ProxMineAmmo", 1, 2);
			TNT1 A 0 A_Print("No Land Mines left");
			Goto GoingToReady;
			XPFF FEDCBA 1;
			XPFS B 4 A_StartSound("weapons/pbarm", 2);
			XHFF A 0 {
				A_StartSound("MINE002", 3);
				A_ThrowGrenade("ThrownProxMine",4,11,1,0);
				A_TakeInventory("PB_ProxMineAmmo", 1);
			}
			XHFF MNOPQRSTUVWXYZ 1;
			TNT1 A 0 {
				A_TakeInventory("UseEquipment", 1);
				A_TakeInventory("ToggleEquipment", 1);
			}
			TNT1 A 0 A_JumpIf(PressingUser1(), "UseEquipment");
			Goto GoingToReady2;
	}
}