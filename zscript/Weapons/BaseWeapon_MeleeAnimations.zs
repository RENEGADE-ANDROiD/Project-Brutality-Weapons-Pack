extend class PB_WeaponBase
{
	States
	{
    // The Actual Custom Melee Animations
	SwapToStandardMelee:
		TNT1 A 0{
			A_Print("Your Weapon was Broken"); 
			A_SetInventory("StandardMeleeSelected",1);
			A_SetInventory("BladeMeleeSelected",0);
			A_SetInventory("MeleeAxeSelected",0);
			A_SetInventory("ImpactorMeleeSelected",0);
			A_SetInventory("KatanaMeleeSelected",0);
			A_SetInventory("PickAxeMeleeSelected",0);
			A_SetInventory("SentinelHammerMeleeSelected",0);
			A_SetInventory("ClawGauntletMeleeSelected",0);
			A_SetInventory("JohnnyHandsMeleeSelected",0);
			A_SetInventory("MeleeCrowbarSelected",0);
			A_StartSound("GRNPIN", 3);
		}
		Goto StandardMelee;
//////////////////////////////////////////////// TWO HANDED ////////////////////////////////////////////////
//////////////////////////////////////////////// Crowbar COMBO START ////////////////////////////////////////////////
	CrowbarComboDecider:
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto CrowbarBreak;
		TNT1 A 3;
		TNT1 A 0 A_Jump(72, "CrowbarCombo3");
		TNT1 A 0 A_Jump(256, "CrowbarCombo1", "CrowbarCombo2");
	
	CrowbarCombo1:
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto CrowbarBreak;
		TNT1 A 3;
		TNT1 A 0 A_PlaySound("weapons/fistwhoosh", 5);
		CBAR ABCD 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("CrowbarSwing", 0, 0, 0, 0); }
		}
        CBAR EFG 1;
		TNT1 AAAA 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "CrowbarComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	
	CrowbarCombo2:
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto CrowbarBreak;
		TNT1 A 3;
		TNT1 A 0 A_PlaySound("weapons/fistwhoosh", 5);
		CBAR HIJK 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("CrowbarSwing", 0, 0, 0, 0); }
		}
        CBAR LMN 1;
		TNT1 AAAA 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		//TNT1 A 0 A_JumpIfInventory("Kicking",1,"KickLeft")
		TNT1 A 1 A_JumpIf(PressingUser2(), "CrowbarComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	CrowbarCombo3: 
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto CrowbarBreak;
		TNT1 A 1;
		TNT1 A 0 A_PlaySound("weapons/fistwhoosh", 5);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("CrowbarSwing", 0, 0, 0, 0); }
		}
		TNT1 AAA 1 A_SetPitch(+.2 + pitch, SPF_INTERPOLATE);
		TNT1 AAA 1;
        CBAR RSTUV 1 A_SetPitch(-.2 + pitch, SPF_INTERPOLATE);
		TNT1 AA 1 A_SetPitch(+.2 + pitch, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "CrowbarComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;

	CrowbarBreak:
		TNT1 A 0{
			A_CustomMissile ("MetalShard1", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard2", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard3", 5, 0, random (-10, -20), 2, random (0, 30));
			A_TakeInventory("Crowbar",1);
			A_Startsound("meleeweapon/break");
			PB_SetUsingMelee(false);
			A_TakeInventory("ToggleMelee", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwapToStandardMelee;

//////////////////////////////////////////////// AXE COMBO START ////////////////////////////////////////////////
	AxeComboDecider:
		TNT1 A 0 A_JumpIf(CountInv("AxeDurabilityCounter") == 40, "AxeBreak");
		TNT1 A 8;
		TNT1 A 0 A_Jump(72, "AxeCombo3");
		TNT1 A 0 A_Jump(256, "AxeCombo1", "AxeCombo2");

	AxeCombo1:
		TNT1 A 2;
		0AXE ABCD 1 A_SetPitch(-.2 + pitch, SPF_INTERPOLATE);
        TNT1 AAA 1 A_SetPitch(-2 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("AXSWING", 5);
		TNT1 A 0 {
			A_GiveInventory("AxeDurabilityCounter", 1);
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 8); }
			else { A_FireCustomMissile("AxeAttack", 0, 0, 0, 8); }
		}
        0AXE EF 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", 0, 0, 0, 0); }
		}
		0AXE GH 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, -8); }
			else { A_FireCustomMissile("AxeAttack", 0, 0, 0, -8); }
		}
		0AXE I 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 10 A_JumpIf(PressingUser2(), "AxeComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	
	AxeCombo2:
		TNT1 A 2 ;
		TNT1 A 0 A_PlaySound("AXSWING", 5);
		0AXE JK 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			A_GiveInventory("AxeDurabilityCounter", 1);
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", -15, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", -15, 0, 0, 0); }
		}
		0AXE LM 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", 0, 0, 0, 0); }
		}
        0AXE NO 1;
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 15, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", 15, 0, 0, 0); }
		}
		0AXE PQ 1;
		TNT1 AAAA 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 10 A_JumpIf(PressingUser2(), "AxeComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	AxeCombo3: // Combo Start, Dont ask me ask why
		TNT1 A 0 A_JumpIf(CountInv("AxeDurabilityCounter") == 40, "AxeBreak");
		TNT1 A 2;
		TNT1 A 0 A_PlaySound("AXSWING", 5);
		0AXE RS 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			A_GiveInventory("AxeDurabilityCounter", 1);
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("AxeAttack", -15, 0, 0, 0);
				A_FireCustomMissile("AxeAttack", -15, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", -15, 0, 0, 0); }
		}
		0AXE TU 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0); 
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);}
			else { A_FireCustomMissile("AxeAttack", 0, 0, 0, 0); }
		}
        0AXE VW 1 ;
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { 
				A_FireCustomMissile("AxeAttack", 15, 0, 0, 0);
				A_FireCustomMissile("AxeAttack", 15, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", 15, 0, 0, 0); }
		}
		0AXE XY 1;
		TNT1 AAAA 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 10 A_JumpIf(PressingUser2(), "AxeComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;

	AxeBreak:
		TNT1 A 0{
			A_CustomMissile ("MetalShard1", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard2", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard3", 5, 0, random (-10, -20), 2, random (0, 30));
			A_TakeInventory("PB_Axe",1);
			A_Startsound("meleeweapon/break");
			PB_SetUsingMelee(false);
			A_TakeInventory("ToggleMelee", 1);
			A_SetInventory("AxeDurabilityCounter", 0);
			PB_CheckBarrelIdle1();
			}
		Goto SwapToStandardMelee;
//////////////////////////////////////////////// JOHNNY HANDS ////////////////////////////////////////////////
	ExplosiveHands:
		TNT1 A 0 A_JumpIfInventory("ExplosiveHandCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto GoingToReady;
		JSML ABCDEF 1;
		PUFF A 0 A_PlaySound("player/cyborg/fist", 3);
		TNT1 A 0 {
		     A_FireCustomMissile("JohnnyFlames", 20, 0);
		     A_FireCustomMissile("JohnnyFlames", -20, 0);
		     A_FireCustomMissile("JohnnyFlames", 10, 0, 0, 10);
		     A_FireCustomMissile("JohnnyFlames", -10, 0, 0, -10);
		     A_FireCustomMissile("JohnnyFlames", -15, 0, 0, -15);
		     A_FireCustomMissile("JohnnyFlames", -8, 0, 0, -8);
			 A_TakeInventory("ExplosiveHandCharges", 1);
		     }
		JSML FGHIJKLMNOP 1;
		
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready3;

//////////////////////////////////////////////// ONE HANDED ////////////////////////////////////////////////
//////////////////////////////////////////////// KATANA COMBO START ////////////////////////////////////////////////
    MeleeKatana:
		TNT1 A 0 A_JumpIfInventory("KatanaDurability", 1, 1);
		Goto KatanaBreak;
		TNT1 A 0 A_TakeInventory("KatanaDurability",1);
        TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
			}
		KTNA I 1; 
		KTNA JK 1;
		TNT1 A 0 {
				if (CountInv("PB_PowerStrength") >= 1 ) {
					A_Saw("", "", 16, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);			
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}
				else {
					A_Saw("", "", 3, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}			
			}
		KTNA LMNO 1 
		{
				A_Setroll(roll-1.0, SPF_INTERPOLATE);
				A_SetAngle(angle+0.5, SPF_INTERPOLATE);
		}		
		TNT1 AAA 1 
		{
				A_Setroll(roll+1.0, SPF_INTERPOLATE);
				A_SetAngle(angle-0.5, SPF_INTERPOLATE);
		}
		TNT1 AAA 1 
		{
				A_Setroll(roll+1.0, SPF_INTERPOLATE);
				A_SetAngle(angle-0.5, SPF_INTERPOLATE);
		}
		TNT1 A 0 A_JumpIfInventory("KatanaDurability", 1, 1);
		Goto KatanaBreak;
		TNT1 A 5 A_JumpIf(PressingUser2(), "MeleeKatana2");
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	MeleeKatana2:
		TNT1 A 0 A_JumpIfInventory("KatanaDurability", 1, 1);
		Goto KatanaBreak;
		TNT1 A 0 A_TakeInventory("KatanaDurability",1);
		KTNA ABC 1;
		TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
			}	
		KTBA JK 1;
		TNT1 A 0 {
				if (CountInv("PB_PowerStrength") >= 1 ) {
					A_Saw("", "", 16, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);			
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}
				else {
					A_Saw("", "", 3, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttack", 0, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -20, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", 40, 0, 0, 0);
					A_FireCustomMissile("KatanaAttack", -40, 0, 0, 0);
				}			
			}
		KTBA LMNO 1
		{
				A_Setroll(roll+1.0, SPF_INTERPOLATE);
				A_SetAngle(angle-0.5, SPF_INTERPOLATE);
			}
		TNT1 AAA 1 {
				A_Setroll(roll-1.0, SPF_INTERPOLATE);
				A_SetAngle(angle+0.5, SPF_INTERPOLATE);
			}
		TNT1 AAA 1 {
				A_Setroll(roll-1.0, SPF_INTERPOLATE);
				A_SetAngle(angle+0.5, SPF_INTERPOLATE);
			}
		TNT1 A 0 A_JumpIfInventory("KatanaDurability", 1, 1);
		Goto KatanaBreak;
        TNT1 A 5 A_JumpIf(PressingUser2(), "MeleeKatana");
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	KatanaBreak:
		TNT1 A 0{
			A_CustomMissile ("MetalShard1", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard2", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard3", 5, 0, random (-10, -20), 2, random (0, 30));
			A_Startsound("meleeweapon/break");
			PB_SetUsingMelee(false);
			A_TakeInventory("ToggleMelee", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwapToStandardMelee;
//////////////////////////////////////////////// PICK AXE ////////////////////////////////////////////////
    MeleePickAxe:
		TNT1 A 0 A_JumpIfInventory("PickAxeDurability", 1, 2);
		TNT1 A 0 A_Print("You Don't Have any Pick Axe");
		Goto PickAxeBreak;
        PCKA I 3;
		PCKA J 5;
		PCKA J 1;
		TNT1 A 0 A_PlaySound("SWOOSH", 1);
		PCKA K 2 A_FireCustomMissile("PickaxeMeleeStrike", 1);
		PCKA L 2;
		TNT1 A 0 A_TakeInventory("PickAxeDurability", 1);
		PCKA MMM 2;
		PCKA L 2;
		PCKA K 2;
		PCKA A 3;
		//TNT1 A 0 A_JumpIfInventory("PickAxeDurability", 1, 1);
		//Goto PickAxeBreak;
        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	PickAxeBreak:
		TNT1 A 0{
			A_CustomMissile ("MetalShard1", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard2", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard3", 5, 0, random (-10, -20), 2, random (0, 30));
			A_Startsound("meleeweapon/break");
			PB_SetUsingMelee(false);
			A_TakeInventory("ToggleMelee", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwapToStandardMelee;
//////////////////////////////////////////////// SENTINEL HAMMER ////////////////////////////////////////////////
    MeleeSentinelHammer:
		TNT1 A 0 A_JumpIfInventory("SentinelhammerCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto SwapToStandardMelee;
        TNT1 A 0 A_PlaySound("HMSWING", 50);
		TNT1 A 0 A_PlaySound("AXSWING", 45);
		SHPB M 1 A_SetAngle(angle+5);
		TNT1 A 0 A_FireCustomMissile("AxeAttack", 0, 0);
		SHPB NOPQ 1 A_SetAngle(angle+5);
		TNT1 AAAAAA 1 A_SetAngle(angle-1,5);
		TNT1 A 0 A_TakeInventory("SentinelhammerCharges", 1);
        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready3;
//////////////////////////////////////////////// CLAW GAUNTLET ////////////////////////////////////////////////
    MeleeClaw:
		TNT1 A 0 A_JumpIfInventory("ClawCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto SwapToStandardMelee;
        GAFR AB 1;
		PUFF A 0 A_PlaySound("player/cyborg/fist", 3);
		GAFR C 1;
		GAFR D 1 A_CustomPunch (20,0,0,"crowbarpuff");
		GAFR EFG 1;
		TNT1 A 0 A_TakeInventory("ClawCharges",1);
		TNT1 A 5 A_JumpIf(PressingUser2(), "MeleeClaw2");
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	MeleeClaw2:
		TNT1 A 0 A_JumpIfInventory("ClawCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto SwapToStandardMelee;
		TNT1 A 4;
		GAFL AB 1;
		GAFL C 1;
		GAFL D 2 A_CustomPunch (20,0,0,"crowbarpuff2");
		GAFL EFG 1;
		TNT1 A 0 A_TakeInventory("ClawCharges", 1);
		TNT1 A 4;
        TNT1 A 5 A_JumpIf(PressingUser2(), "MeleeClaw");
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
//////////////////////////////////////////////// IMPACTOR GAUNTLET ////////////////////////////////////////////////
    MeleeImpactor:
		TNT1 A 0 A_JumpIfInventory("ImpactorCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto SwapToStandardMelee;
        TNT1 A 0 A_PlaySound("weapons/IMGCok");
		IMPA KLM 1;
		TNT1 A 0 A_CustomPunch (10 * random(10, 55),1,CPF_NOTURN ,"ImpactorPuff",92, 0, 0, "PB_ArmorBonus", "weapons/IMGHit", "weapons/IMGMiss");
		TNT1 A 0 A_Blast(BF_DONTWARN | BF_NOIMPACTDAMAGE | BF_AFFECTBOSSES, 25, 60, 20, "GauntletImpact");
		TNT1 A 0 A_Quake(3, 10, 0, 10);
		IMPA NOP 1;
		IMPA Q 6;
		IMPA RRSSTTUU 1;
		TNT1 A 0 A_TakeInventory("ImpactorCharges", 1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready3;
//////////////////////////////////////////////// DOOMBLADE ////////////////////////////////////////////////
	MeleeBlade:
        TNT1 A 0 {
				A_GiveInventory("HasCutingWeapon", 1);
				A_StartSound("KNIFSWNG", 1);
				double knifeRoll = frandom(-1.0,1.0);
				A_Overlayrotate(overlayID(),knifeRoll);
				if(invoker.curBlood.x != 0 || invoker.curBlood.y != 0 || invoker.curBlood.z != 0)
				{
					double BR = invoker.curBlood.x;
					double BG = invoker.curBlood.y;
					double BB = invoker.curBlood.z;
					double mostlyred = (BR - (BG + BB));
					double mostlygreen = (BG - (BB + BR));
					double mostlyblue = (BB - (BR + BG));
					if(mostlyred > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Red");
					else if(mostlygreen > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Green");
					else if(mostlyblue > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Blue");
					A_Overlayrotate(overlayID() + 2,knifeRoll);
				}
				
			}
        BXMD AB 1 {
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        BXMD C 1 {
            A_Setangle(angle - 1,SPF_INTERPOLATE);
            A_SetPitch(pitch + 1,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        BXMD D 1 {
            A_QuakeEx(0,0.5,0,7,0,10,"",QF_SCALEDOWN|QF_RELATIVE,0,0,0,0,0,2,2);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 A 0 {
            if(CountInv("PB_PowerStrength") == 1) A_FireProjectile("SuperKnifeSwing",0,0,0,0,0,0);
            else A_FireProjectile("KnifeSwing",0,0,0,0,0,0);
            PB_UseLine(64);
            flinetracedata t;
            linetrace(angle,64,pitch,0,player.mo.height * 0.5 - player.mo.floorclip + player.mo.AttackZOffset*player.crouchFactor,data:t);
            if(t.hitactor != null && !t.hitactor.bnoblood)
            {
                if(t.hitactor.bloodcolor == 0)	//has no blood color defined, use default bloodcolor
                {
                    invoker.curBlood.x = gameinfo.defaultbloodcolor.r / 255.0;
                    invoker.curBlood.y = gameinfo.defaultbloodcolor.g / 255.0;
                    invoker.curBlood.z = gameinfo.defaultbloodcolor.b / 255.0;
                }
                else
                {
                    invoker.curBlood.x = t.hitactor.bloodcolor.r / 255.0;
                    invoker.curBlood.y = t.hitactor.bloodcolor.g / 255.0;
                    invoker.curBlood.z = t.hitactor.bloodcolor.b / 255.0;
                }
            }
        }
        BXMD EF 1 {
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        BXMD GHIJK 1 {
            A_SetPitch(pitch - 0.2,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 AAA 1 {
            A_Setangle(angle + 0.3,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 A 0 {
            A_TakeInventory("KnifeHasHit",1);
            A_TakeInventory("HasCutingWeapon", 1);
            PB_SetUsingMelee(false);
        }
        TNT1 A 0 A_Overlayrotate(overlayID(),0);
        TNT1 A 0 PB_CheckBarrelIdle1();
        Goto Ready3;
//////////////////////////////////////////////// DEFAULT MELEE ////////////////////////////////////////////////
    StandardMelee:
        TNT1 A 0 {
				A_GiveInventory("HasCutingWeapon", 1);
				A_StartSound("KNIFSWNG", 1);
				double knifeRoll = frandom(-1.0,1.0);
				A_Overlayrotate(overlayID(),knifeRoll);
				if(invoker.curBlood.x != 0 || invoker.curBlood.y != 0 || invoker.curBlood.z != 0)
				{
					double BR = invoker.curBlood.x;
					double BG = invoker.curBlood.y;
					double BB = invoker.curBlood.z;
					double mostlyred = (BR - (BG + BB));
					double mostlygreen = (BG - (BB + BR));
					double mostlyblue = (BB - (BR + BG));
					if(mostlyred > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Red");
					else if(mostlygreen > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Green");
					else if(mostlyblue > 0)
						A_overlay(overlayID() + 2,"BloodyKnife_Blue");
					
					A_Overlayrotate(overlayID() + 2,knifeRoll);
				}
				
			}
        MC3S AB 1 {
            
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        MC3S C 1 {
            A_Setangle(angle - 1,SPF_INTERPOLATE);
            A_SetPitch(pitch + 1,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        MC3S D 1 {
            A_QuakeEx(0,0.5,0,7,0,10,"",QF_SCALEDOWN|QF_RELATIVE,0,0,0,0,0,2,2);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 A 0 {
            if(CountInv("PB_PowerStrength") == 1) A_FireProjectile("SuperKnifeSwing",0,0,0,0,0,0);
            else A_FireProjectile("KnifeSwing",0,0,0,0,0,0);
            PB_UseLine(64);
            flinetracedata t;
            linetrace(angle,64,pitch,0,player.mo.height * 0.5 - player.mo.floorclip + player.mo.AttackZOffset*player.crouchFactor,data:t);
            if(t.hitactor != null && !t.hitactor.bnoblood)
            {
                if(t.hitactor.bloodcolor == 0)	//has no blood color defined, use default bloodcolor
                {
                    invoker.curBlood.x = gameinfo.defaultbloodcolor.r / 255.0;
                    invoker.curBlood.y = gameinfo.defaultbloodcolor.g / 255.0;
                    invoker.curBlood.z = gameinfo.defaultbloodcolor.b / 255.0;
                }
                else
                {
                    invoker.curBlood.x = t.hitactor.bloodcolor.r / 255.0;
                    invoker.curBlood.y = t.hitactor.bloodcolor.g / 255.0;
                    invoker.curBlood.z = t.hitactor.bloodcolor.b / 255.0;
                }
            }
        }
        MC3S EF 1 {
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        MC3S GHIJK 1 {
            A_SetPitch(pitch - 0.2,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 AAA 1 {
            A_Setangle(angle + 0.3,SPF_INTERPOLATE);
            if(JustPressed(BT_USER2)) return PB_Execute();
            return ResolveState(null);
        }
        TNT1 A 0 {
            A_TakeInventory("KnifeHasHit",1);
            A_TakeInventory("HasCutingWeapon", 1);
            PB_SetUsingMelee(false);
        }
        TNT1 A 0 A_Overlayrotate(overlayID(),0);
        TNT1 A 0 PB_CheckBarrelIdle1();
        Goto Ready3;

		// Swap Animations
		SwapToMeleeAxe:
		3AXE ABCDEEEEEEDCBA 1;
		stop;
	}
}