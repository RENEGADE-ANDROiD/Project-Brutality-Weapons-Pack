extend class PB_WeaponBase
{
    States
    {	
		QuickMeleeGK:
			TNT1 A 0 {
				A_ClearOverlays(-10,65);
				A_Gunflash("Null");
			}
			TNT1 A 0
			{
				if(countinv("FinisherToken",AAPTR_PLAYER_GETTARGET)>=1 && A_CheckLOF("Null",CLOFF_SETTARGET|CLOFF_NOAIM_VERT|CLOFF_IGNOREGHOST|CLOFF_MUSTBESOLID ,180))
				{
					A_TakeInventory("Zoomed",1);
					A_ZoomFactor(1.0);
					A_TakeInventory("ADSmode",1);
					return ResolveState("PerformExecution");
				}
				return ResolveState(null);
			}
			TNT1 A 0 A_JumpIfInventory("BPToken",5,"BloodPunch");
			#### A 0 {
				A_StopSound(CHAN_WEAPON);
				A_StopSound(CHAN_VOICE);
				A_StopSound(CHAN_6);
				A_StopSound(CHAN_7);
			}
			TNT1 A 0 A_JumpIfInventory("CantDoAction",1,"FailOverlay");
			TNT1 A 0 A_JumpIfHealthLower(0, "FailOverlay");
			TNT1 A 0 {
				A_ClearOverlays(-10,65);
				A_Gunflash("Null");
			}
			#### AAA 0 
			{
				if(GetCvar("be_ExecutionsON")==0) return PB_Execute(); // Check if monster can be executed, jump to execution handler instead
				return ResolveState(null);
			}
		Goto GoMeleeInstead;

        PerformExecution:
			TNT1 A 0
			{
				A_StartSound("GloryKill", CHAN_UI);
				if(GetCvar("be_Protection") == 1)
				{
					A_Giveinventory("Superarmor",1);
				}
				if(GetCvar("be_Fear") == 1)
				{
					A_Giveinventory("Fear",1);
				}
			}
			#### AAA 0 PB_ExecuteGK(); // Check if monster can be executed, jump to execution handler instead
			TNT1 A 0;
			Goto GoingToReady;
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Glory Melee
		////////////////////////////////////////////////////////////////////////////////////////////
		
		GloryMelee:
			SAWG G 0
			{	
				if(CountInv("CrucibleEnergy") > 0)
				{
					A_TakeInventory("Zoomed",1);
					A_ZoomFactor(1.0);
					A_TakeInventory("ADSmode",1);
					A_StopSound(1);
					A_StopSound(6);
					return ResolveState("Crucible");
				}
					A_Print("Not Enough Energy");
					A_StartSound("Beep");
					A_TakeInventory("DoGloryMelee",1);
					return ResolveState(null);
			}
			Goto GoingToReady;
			
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Blood Punch
		////////////////////////////////////////////////////////////////////////////////////////////
		
		BloodPunch:
		//	SCL0 A 0 A_ClearOverlays(-5, 80);
			SCL0 A 0 A_GunFlash("Null");
			SCL0 A 0 {
					A_TakeInventory("Zoomed",1);
					A_ZoomFactor(1.0);
					A_TakeInventory("ADSmode",1);
					A_TakeInventory("BloodPunchKilled");
					A_LegOverlay(-1000, "FirstPersonLegsStand");
			}
			SCL0 A 0 A_StopSound(1);
			SCL0 A 0 A_StopSound(6);
			P1NK ABCD 1 {
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P2NK");}
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P3NK");}
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P4NK");}
				A_SetRoll(roll+2);
			}
			TNT1 A 1 A_SetRoll(roll+2);
			TNT1 A 2;
			TNT1 A 0 A_StartSound("weapons/ultrwhoosh", 5);
			P1NK EF 1 {
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P2NK");}
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P3NK");}
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P4NK");}
				A_SetRoll(roll-2);
			}
			TNT1 A 0 {
					A_Saw("", "player/cyborg/fist", 120, "BloodPunchPuff", SF_NOPULLIN | SF_NOTURN , 128);
			}
			P1NK G 1 {
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P2NK");}
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P3NK");}
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P4NK");}
			}
			P1NK HIJKLMNO 1 {
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P2NK");}
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P3NK");}
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P4NK");}
				A_SetRoll(roll-1);
				}
			P1NK O 1 {
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P2NK");}
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P3NK");}
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P4NK");}
			}
			P1NK PQ 1 {
				if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P2NK");}
				if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P3NK");}
				if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("P4NK");}
				A_SetRoll(roll+2);
			}
			TNT1 A 0 A_SetRoll(0);
			TNT1 A 0 {
				if(CountInv("BloodPunchKilled"))
				{
					A_StartSound("BloodPunch", CHAN_AUTO);
					A_TakeInventory("BloodPunchKilled");
					A_TakeInventory("BPtoken");
					A_Explode(125, 200, 0, true, 200 ,0 ,0, "BPImpactPuff", "BloodPunch");
				}
			}
			TNT1 A 0 {PB_SetUsingMelee(false);}
			TNT1 A 0 A_TakeInventory("DoGloryMelee", 1);
			TNT1 A 1 A_Raise;
			Goto GoingToReady;
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Crucible
		////////////////////////////////////////////////////////////////////////////////////////////
			
		Crucible:
		//	SCL0 A 0 A_ClearOverlays(-5, 80);
			SCL0 A 0 A_GunFlash("Null");
			CRCB A 1 A_StartSound("Crucible_Select", CHAN_WEAPON, CHANF_OVERLAP);
			CRCB AABBCCJJ 2 bright A_WeaponOffset(-1, 2, WOF_ADD);
			CRCB D 1 bright
			{
				A_StartSound("Crucible_Deploy", CHAN_WEAPON, CHANF_OVERLAP);
				A_WeaponOffset(-2, 4, WOF_ADD);
				A_TakeInventory("CrucibleEnergy",1);
			}
			CRCB D 3 bright A_WeaponOffset(-2, 4, WOF_ADD);//-10, 20
			CRCB DDD 1 bright A_WeaponOffset(3, -6, WOF_ADD);
			CRCB D 1 bright A_WeaponOffset(0.5, 4, WOF_ADD);
			Goto HoldCrucible;
			
		HoldCrucible:	
			CRCB D 1 bright A_StartSound("Crucible_Idle",10,CHANF_LOOP|CHANF_OVERLAP,0.2);
			CRCB D 1 bright
			{
				A_WeaponReady();
				if (!countinv("DoGloryMelee"))
				{
					return ResolveState("DoCrucible");
				}
				return ResolveState(null);
			}
			Goto HoldCrucible+1;
			
		DoCrucible:
			CRCB D 1 
			{
				A_StartSound("Crucible_Swing", CHAN_WEAPON, CHANF_OVERLAP);
				A_WeaponOffset(10,2, WOF_ADD);
			}
			CRCB D 1 A_WeaponOffset(20, 4, WOF_ADD);
			CRCB D 1 A_WeaponOffset(30, 6, WOF_ADD);
			CRCB D 1 A_WeaponOffset(40, 8, WOF_ADD);
			CRCB D 1 A_WeaponOffset(50,10, WOF_ADD);
			CRCB D 1 A_WeaponOffset(60,12, WOF_ADD);
			TNT1 A 0 A_WeaponReady(WRF_NoFire|WRF_NoSwitch);
			
			//First Swing
			
			CRCB EEF 1 
			{
				A_Saw("", "Crucible_Slice", 300, "CruciblePuff", SF_NOPULLIN | SF_NOTURN , 150, 32);
			}
			CRCB G 1
			{
				A_WeaponOffset(-40, 0, WOF_ADD);
				A_Saw("", "Crucible_Slice", 300, "CruciblePuff", SF_NOPULLIN | SF_NOTURN , 150, 32);
				A_SpawnItemEx("CrucibleBladeWave", 0, 0, Height / 2, 0, 0, 0, 0, SXF_CLIENTSIDE|SXF_TRANSFERPITCH);
			}
			
			TNT1 A 0 A_WeaponReady(WRF_NoFire|WRF_NoSwitch);
			
			CRCB HII 1 
			{
				A_WeaponOffset(-40, 8, WOF_ADD);
				A_Saw("", "Crucible_Slice", 300, "CruciblePuff", SF_NOPULLIN | SF_NOTURN , 150, 32);
			}
			CRCB D 0 A_WeaponOffset(325, 24, WOF_ADD);
			
			NULL A 10;
			
			TNT1 A 0
			{
				A_TakeInventory("DoGloryMelee",1);
			}
			
			CRCB D 1 A_WeaponOffset(-60, -12, WOF_ADD);
			CRCB D 1 A_WeaponOffset(-50, -10, WOF_ADD);
			CRCB D 1 A_WeaponOffset(-40, -8, WOF_ADD);
			CRCB D 1 A_WeaponOffset(-30, -6, WOF_ADD);
			CRCB D 1 A_WeaponOffset(-20, -4, WOF_ADD);
			
			CRCB D 1 bright A_WeaponOffset(-0.5, -4, WOF_ADD);
			CRCB DDD 1 bright A_WeaponOffset(-3, 6, WOF_ADD);
			CRCB D 3 bright A_WeaponOffset(2, -4, WOF_ADD);
			
			CRCB D 1 bright A_WeaponOffset(2, -4, WOF_ADD);
			
			CRCB JJCCBBAA 2 bright A_WeaponOffset(1, -2, WOF_ADD);
			CRCB A 1 A_StopSound(10);
			CRCB A 1 A_StartSound("Crucible_Deselect", CHAN_WEAPON, CHANF_OVERLAP);
			CRCB A 5;
			TNT1 A 1 A_Raise;
			Goto GoingToReady;
			
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Shoulder Cannon
		////////////////////////////////////////////////////////////////////////////////////////////
			
		FireShoulderCannon:
			TNT1 A 0
			{	
				if(CountInv("DoFlameBelch") > 0)
				{
					if ((GetCvar("be_UseELammo")) && (countinv("PB_Fuel") < 50))
					{
						return ResolveState("EmptyCannon");
					}
					A_TakeInventory("Zoomed",1);
					A_ZoomFactor(1.0);
					A_TakeInventory("ADSmode",1);
					return ResolveState("UseFlameBelch");
				}
				if(CountInv("DoIceBomb") > 0)
				{
					if ((GetCvar("be_UseELammo")) && (countinv("PB_RocketAmmo") < 1))
					{
						return ResolveState("EmptyCannon");
					}
					A_TakeInventory("Zoomed",1);
					A_ZoomFactor(1.0);
					A_TakeInventory("ADSmode",1);
					return ResolveState("UseIceBomb");
				}
				return ResolveState(null);
			}
		//	TNT1 A 0 A_StartSound("Equip_notready");
			TNT1 A 0 A_TakeInventory("DoShoulderCannon", 1);
			Goto GoingToReady;
		
		UseFlameBelch:
			TNT1 A 0 A_TakeInventory("DoFlameBelch", 1);
			TNT1 A 0
			{
				if (countinv("FlameBelchReady") < 1)
				{
					return ResolveState("EmptyCannon");
				}
				return ResolveState(null);
			}
			TNT1 A 0
			{
				if (GetCvar("be_UseELammo"))
				{
					A_TakeInventory("PB_Fuel",50);
				}
				if(GetCvar("be_FBperformance"))
				{
					A_Overlay(50, "FireFlameBelchSimple");
				}
				else
				{
					A_Overlay(50, "FireFlameBelch");
				}
			}
			Goto GoingToReady;
			
		UseIceBomb:
			TNT1 A 0 A_TakeInventory("DoIceBomb", 1);
			TNT1 A 0 {
				if (countinv("IceBombReady") < 1)
				{
					return ResolveState("EmptyCannon");
				}
				return ResolveState(null);
			}
			TNT1 A 0 
			{
				if (GetCvar("be_UseELammo"))
				{
					A_TakeInventory("PB_RocketAmmo",1);
				}
				A_Overlay(50, "FireIceBomb");
			}
			Goto GoingToReady;
			
		EmptyCannon:
		//	TNT1 A 0 A_StopSound(CHAN_ITEM);
			TNT1 A 0 A_StartSound("Equip_notready");
			TNT1 A 0 A_TakeInventory("DoShoulderCannon", 1);
			TNT1 A 0 A_TakeInventory("DoFlameBelch", 1);
			TNT1 A 0 A_TakeInventory("DoIceBomb", 1);
			Goto GoingToReady;

		
		FireFlameBelch:
		//	SCL0 A 0 A_ClearOverlays(-5, 80);
		//	SCL0 A 0 A_GunFlash("Null");
			SCL0 ABCD 1 A_StartSound("Equip_Activate", CHAN_ITEM);
			SCL0 EFGHIJ 1;
			SCL0 K 1 A_Quake(8, 8, 0, 32);
			TNT1 A 0 A_Recoil (4);
			TNT1 A 0 A_StartSound("Flamebelch", CHAN_ITEM);
			SCF0 A 5 bright A_GunFlash;
			TNT1 A 0 A_AlertMonsters;
			TNT1 A 0 A_TakeInventory("FlameBelchReady",1);
			SCF0 BCDBCDBCD 1 bright {
				A_FireProjectile("SCFireMissile", -3, 0, Random(-25, -20), 12, FPF_NOAUTOAIM, 0);
			}
			SCF0 EF 1;
			SCL0 KJIHGFEDCBA 1;
			Stop;
		
		FireFlameBelchSimple:
		//	SCL0 A 0 A_ClearOverlays(-5, 80);
		//	SCL0 A 0 A_GunFlash("Null");
			SCL0 ABCD 1 A_StartSound("Equip_Activate", CHAN_ITEM);
			SCL0 EFGHIJ 1;
			SCL0 K 1 A_Quake(8, 8, 0, 32);
			TNT1 A 0 A_Recoil (4);
			TNT1 A 0 A_StartSound("Flamebelch", CHAN_ITEM);
			SCF0 A 5 bright A_GunFlash;
			TNT1 A 0 A_AlertMonsters;
			TNT1 A 0 A_TakeInventory("FlameBelchReady",1);
			SCF0 BCDBCDBCD 1 bright {
				A_FireProjectile("SCFireMissileSimple", -3, 0, Random(-25, -20), 12, FPF_NOAUTOAIM, 0);
			}
			SCF0 EF 1;
			SCL0 KJIHGFEDCBA 1;
			Stop;
		
		FireIceBomb:
		//	SCL0 A 0 A_ClearOverlays(-5, 80);
		//	SCL0 A 0 A_GunFlash("Null");
			SCL0 ABCD 1 A_StartSound("Equip_Activate", CHAN_ITEM);
			SCL0 EFGHIJ 1;
			SCL0 K 1 A_Quake(8, 8, 0, 32);
			TNT1 A 0 A_Recoil (4);
			SCF0 A 3 bright A_GunFlash;
			TNT1 A 0 A_AlertMonsters;
			TNT1 A 0 A_TakeInventory("IceBombReady", 1);
			SCF0 BC 1 bright;
			SCFG D 1 bright {
				A_StartSound ("weapons/firegrenade", CHAN_ITEM);
				A_FireProjectile("SC_CryoGrenade", -1, 0, Random(-22, -18), 12, FPF_NOAUTOAIM, 0);
			}
			SCF0 EF 1;
			SCL0 KJIHGFEDCBA 1;
			Stop;
    }
}