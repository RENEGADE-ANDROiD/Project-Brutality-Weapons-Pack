extend class PB_WeaponBase
{
	States
	{
    // The Actual Custom Melee Animations
	// What the Melee will default to when Broken
	SwaptoMeleeEnergy:
		TNT1 A 0 A_Print("You Ran Out of Demonic Energy");
		Goto SwapToStandardMelee;
	SwaptoMeleeCells:
		TNT1 A 0 A_Print("You Ran Out of Energy Cells");
		Goto SwapToStandardMelee;
	SwaptoMeleeFuel:
		TNT1 A 0 A_Print("You Ran Out of Fuel");
		Goto SwapToStandardMelee;
	SwaptoMeleeCharges:
		TNT1 A 0 A_Print("You Ran Out of Charges");
		Goto SwapToStandardMelee;
	SwaptoMeleeBroken:
		TNT1 A 0 A_Print("Your Weapon Broke");
	SwapToStandardMelee:
		TNT1 A 0{
			A_SetInventory("StandardMeleeSelected",1); // ALWAYS UPDATE THIS ACCORDING TO THE SELECTED DEFAULT MELEE
            A_SetInventory("BladeMeleeSelected",0);
			A_SetInventory("MeleeAxeSelected",0);
			A_SetInventory("ImpactorMeleeSelected",0);
			A_SetInventory("KatanaMeleeSelected",0);
			A_SetInventory("PickAxeMeleeSelected",0);
			A_SetInventory("SentinelHammerMeleeSelected",0);
			A_SetInventory("ClawGauntletMeleeSelected",0);
			A_SetInventory("JohnnyHandsMeleeSelected",0);
			A_SetInventory("MeleeCrowbarSelected",0);
			A_SetInventory("WrenchMeleeSelected",0);
			A_SetInventory("SawMeleeSelected",0);
			A_SetInventory("BatonMeleeSelected",0);
			A_SetInventory("HammerMeleeSelected",0);
			A_StartSound("GRNPIN", 3);
		}
		Goto StandardMelee;
//////////////////////////////////////////////// TWO HANDED ////////////////////////////////////////////////
//////////////////////////////////////////////// SLEDGE HAMMER COMBO START ////////////////////////////////////////////////
	HammerComboDecider:
		TNT1 A 0 A_JumpIfInventory("HammerDurability",1,1);
		Goto HammerBreak;
		TNT1 A 3;
		TNT1 A 0 A_Jump(72, "HammerCombo3");
		TNT1 A 0 A_Jump(256, "HammerCombo1", "HammerCombo2");
	
	HammerCombo1:
		TNT1 A 0 A_JumpIfInventory("HammerDurability",1,1);
		Goto HammerBreak;
		TNT1 A 2;
		0UBR ABCD 1 A_SetPitch(-.2 + pitch, SPF_INTERPOLATE);
        TNT1 AAA 1 A_SetPitch(-2 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("AXSWING", 5);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 0, 0, 0, 8); }
			else { A_FireCustomMissile("HammerSwing", 0, 0, 0, 8); }
		}
        0UBR EF 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("HammerSwing2", 0, 0, 0, 0);
		}
		0UBR GH 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 0, 0, 0, -8); }
			else { A_FireCustomMissile("HammerSwing", 0, 0, 0, -8); }
		}
		0UBR I 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "HammerComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	
	HammerCombo2:
		TNT1 A 0 A_JumpIfInventory("HammerDurability",1,1);
		Goto HammerBreak;
		TNT1 A 2;
		TNT1 A 0 A_PlaySound("AXSWING", 5);
		0UBR JK 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", -15, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", -15, 0, 0, 0); }
		}
		0UBR LM 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("HammerSwing2", 0, 0, 0, 0);
		}
        0UBR NO 1;
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 15, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", 15, 0, 0, 0); }
		}
		0UBR PQ 1;
		TNT1 AAAA 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "HammerComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	HammerCombo3:
		TNT1 A 0 A_JumpIfInventory("HammerDurability",1,1);
		Goto HammerBreak;
		TNT1 A 2;
		TNT1 A 0 A_PlaySound("AXSWING", 5);
		0UBR RS 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", -15, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", -15, 0, 0, 0); }
		}
		0UBR TU 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("HammerSwing2", 0, 0, 0, 0);
		}
        0UBR VW 1;
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperHammerSwing", 15, 0, 0, 0); }
			else { A_FireCustomMissile("HammerSwing", 15, 0, 0, 0); }
		}
		0UBR XY 1;
		TNT1 AAAA 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "HammerComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	HammerBreak:
		TNT1 A 0{
			A_CustomMissile ("MetalShard1", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard2", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard3", 5, 0, random (-10, -20), 2, random (0, 30));
			A_TakeInventory("SledgeHammer",1);
			A_Startsound("meleeweapon/break");
			PB_SetUsingMelee(false);
			A_TakeInventory("ToggleMelee", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwaptoMeleeBroken;
		

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
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 8); } // SUPER SWING DOES NOT TAKE DURABILITY
			else { A_FireCustomMissile("AxeAttack", 0, 0, 0, 8); }
		}
        0AXE EF 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("AxeSwing2", 0, 0, 0, 0); } // TAKE DURABILITY
		}
		0AXE GH 1 A_SetPitch(+2.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { 
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
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", -15, 0, 0, 0); }
			else { A_FireCustomMissile("AxeAttack", -15, 0, 0, 0); }
		}
		0AXE LM 1 A_SetRoll(roll-1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("AxeSwing2", 0, 0, 0, 0); } // TAKE DURABILITY
		}
        0AXE NO 1;
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { 
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
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", -15, 0, 0, 0);} 
			else { A_FireCustomMissile("AxeAttack", -15, 0, 0, 0); }
		}
		0AXE TU 1 A_SetRoll(roll+1.2, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("AxeSwing2", 0, 0, 0, 0); }
		}
        0AXE VW 1 ;
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { 
				A_FireCustomMissile("SuperAxeSwing", 15, 0, 0, 0); }
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
		Goto SwaptoMeleeBroken;
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
			}
		TNT1 A 0 A_TakeInventory("ExplosiveHandCharges", 1);
		JSML FGHIJKLMNOP 1;
		
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready3;
//////////////////////////////////////////////// KATANA COMBO START ////////////////////////////////////////////////
    MeleeKatana:
		TNT1 A 0 A_JumpIfInventory("HasDemonicKatana",1,"SwordCombo1");
		TNT1 A 0 A_JumpIfInventory("KatanaDurability", 1, 1);
		Goto KatanaBreak;
        TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
			}
		KTNA I 1; 
		KTNA JK 1;
		TNT1 A 0 {
				if (CountInv("PB_PowerStrength") >= 1 ) {
					A_Saw("", "", 16, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttackTakeDurability", 0, 0, 0, 0);
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
					A_FireCustomMissile("KatanaAttackTakeDurability", 0, 0, 0, 0);
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
		KTNA ABC 1;
		TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
			}	
		KTBA JK 1;
		TNT1 A 0 {
				if (CountInv("PB_PowerStrength") >= 1 ) {
					A_Saw("", "", 16, "AxePuffs", 0, 120, 0,16);
					A_FireCustomMissile("KatanaAttackTakeDurability", 0, 0, 0, 0);
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
					A_FireCustomMissile("KatanaAttackTakeDurability", 0, 0, 0, 0);
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
			A_TakeInventory("KatanaPickup", 1);
			A_TakeInventory("ToggleMelee", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwaptoMeleeBroken;

//////////////////////////////////////////////// DEMONIC KATANA COMBO START ////////////////////////////////////////////////
	SwordComboDecider:
		TNT1 A 0 A_JumpIfInventory("PB_DTech",1,1);
		Goto SwaptoMeleeEnergy;
		TNT1 A 5;
		TNT1 A 0 A_Jump(256, "SwordCombo1", "SwordCombo2", "SwordCombo3", "SwordCombo4");
	
	SwordCombo1:
		TNT1 A 0 A_JumpIfInventory("PB_DTech", 1, 1);
		Goto SwaptoMeleeEnergy;
		TNT1 AA 1;
		1KAT ABC 1 A_SetRoll(roll+0.5, SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("demonicsword/swing", 5);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 8); }
		}
        1KAT D 1 A_SetRoll(roll+0.5, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("SwordSwing2", 0, 0, 0, 0);
		}
		1KAT E 1 A_SetRoll(roll+0.5, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, -8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, -8); }
		}
		1KAT FGH 1 A_SetRoll(roll+0.5, SPF_INTERPOLATE);
		1KAT I 1;
		TNT1 AAAA 1 A_SetRoll(roll-1.0, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "SwordComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	
	SwordCombo2:
		TNT1 A 0 A_JumpIfInventory("PB_DTech", 1, 1);
		Goto SwaptoMeleeEnergy;
		TNT1 AA 1;
		2KAT ABC 1 A_SetRoll(roll-0.5, SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("demonicsword/swing", 5);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 8); }
		}
        2KAT D 1 A_SetRoll(roll-0.5, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("SwordSwing2", 0, 0, 0, 0);
		}
		2KAT E 1 A_SetRoll(roll-0.5, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, -8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, -8); }
		}
		2KAT FGH 1 A_SetRoll(roll-0.5, SPF_INTERPOLATE);
		2KAT I 1;
		TNT1 AAAA 1 A_SetRoll(roll+1.0, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "SwordComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	SwordCombo3:
		TNT1 A 0 A_JumpIfInventory("PB_DTech", 1, 1);
		Goto SwaptoMeleeEnergy;
		TNT1 A 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("demonicsword/swing", 5);
		4KAT AB 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 8); }
		}
		4KAT CD 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("SwordSwing2", 0, 0, 0, 0);
		}
        4KAT EF 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, -8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, -8); }
		}
		TNT1 AAAAAAA 1 A_SetPitch(-0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "SwordComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	SwordCombo4:
		TNT1 A 0 A_JumpIfInventory("PB_DTech", 1, 1);
		Goto SwaptoMeleeEnergy;
		TNT1 A 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 A_PlaySound("demonicsword/swing", 5);
		3KAT AB 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 8); }
		}
		3KAT CD 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, 0); }
			A_FireCustomMissile("SwordSwing2", 0, 0, 0, 0);
		}
        3KAT EF 1 A_SetPitch(+0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PowerStrength") == 1 ) { A_FireCustomMissile("SuperSwordSwing", 0, 0, 0, -8); }
			else { A_FireCustomMissile("SwordSwing", 0, 0, 0, -8); }
		}
		TNT1 AAAAAAA 1 A_SetPitch(-0.5 + pitch, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "SwordComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
//////////////////////////////////////////////// SAW COMBO START ////////////////////////////////////////////////
	SawComboStart:
		TNT1 A 0 A_TakeInventory("SawHasHit",1);
		TNT1 A 5;
		TNT1 A 0 A_StartSound("DSSAWZIP");
		0SAW ABCDE 1 A_SetRoll(roll-.5, SPF_INTERPOLATE);
		0SAW FGHIJ 1;
		TNT1 AAAAA 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 A 5;
		TNT1 A 0 A_JumpIfInventory("PB_Fuel",1,"SawCombo1");
		TNT1 A 0 A_StartSound("weapons/chainsaw/stop");
		Goto SwaptoMeleeFuel;

	SawCombo1:
		TNT1 A 0 {
			A_TakeInventory("SawHasHit",1);
			A_TakeInventory("PB_Fuel",1);
			A_StartSound("sawswing");
		}
		1SAW EF 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 A_FireCustomMissile("Prosurv_SawSwing", -20, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("PB_Fuel",1);
		1SAW G 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 A_FireCustomMissile("Prosurv_SawSwing", -10, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("PB_Fuel",1);
        1SAW HI 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 A_JumpIfInventory("SawHasHit",1,"SawComboStuck");
		Goto SawCombo2;
		
	SawComboStuck:
		TNT1 A 0 A_JumpIfInventory("PB_Fuel",3,1);
		Goto SawCombo2;
		TNT1 A 0 {
			A_TakeInventory("SawHasHit",1);
			A_PlaySound("Weapons/Chainsaw/Loop",7);
		}
		1SAW O 1 A_ZoomFactor(1.03);
		TNT1 A 0 A_FireCustomMissile("Prosurv_SawSwing", 0, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("PB_Fuel",1);
		1SAW P 1 A_ZoomFactor(1.045);
		1SAW Q 1 A_ZoomFactor(1.055);
		TNT1 A 0 A_JumpIfInventory("SawHasHit",1,"SawComboStuck");
	SawCombo2:
		TNT1 A 0 A_Stopsound(7);
		TNT1 A 0 A_StartSound("weapons/chainsaw/stop");
		1SAW JK 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 A_FireCustomMissile("Prosurv_SawSwing", 10, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("PB_Fuel",1);
		1SAW LM 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 A_FireCustomMissile("Prosurv_SawSwing", 20, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("PB_Fuel",1);
		1SAW N 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 AAAAAAAAAA 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		TNT1 A 0 {
			A_Takeinventory("PB_LockScreenTilt",1);
			A_TakeInventory("SawHasHit",1);
			A_SetRoll(0);
		}
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;

//////////////////////////////////////////////// ONE HANDED ////////////////////////////////////////////////
//////////////////////////////////////////////// CROWBAR COMBO START ////////////////////////////////////////////////
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
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
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
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
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
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
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
		Goto SwaptoMeleeBroken;
//////////////////////////////////////////////// BATON ////////////////////////////////////////////////
	BatonComboStart:
		TNT1 A 0 A_TakeInventory("SawHasHit",1);
		TNT1 A 5;
		TNT1 A 0 A_StartSound("ammocase/open", 5);
		BATN FGHIJ 1 A_SetRoll(roll-.5, SPF_INTERPOLATE);
		TNT1 A 0 A_JumpIfInventory("PB_Cell",1,"BatonCombo1");
		TNT1 A 0 A_StartSound("weapons/m2plasma/screenon", 5);
		BATN JIHGF 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		Goto SwaptoMeleeCells;

	BatonCombo1:
		TNT1 A 0 {
			A_TakeInventory("SawHasHit",1);
			A_StartSound("shockbaton/activate", 5);
		}
		BATN KLMKLMKLMKLMKLM 1;
		TNT1 A 0 A_StartSound("shockbaton/swing1", 5);
		BATN K 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 A 0 A_TakeInventory("PB_Cell",1);
		BATN N 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 A 0 A_TakeInventory("PB_Cell",1);
		TNT1 A 0 A_FireCustomMissile("BatonSwing", 0, 0, 0, 0);
        BATN O 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 A 0 A_TakeInventory("PB_Cell",1);
		TNT1 A 0 A_JumpIfInventory("SawHasHit",1,"BatonComboStuck");
		Goto BatonCombo2;
		
	BatonComboStuck:
		TNT1 A 0 A_JumpIfInventory("PB_Cell",3,1);
		Goto BatonCombo2;
		TNT1 A 0 {
			A_TakeInventory("SawHasHit",1);
			A_PlaySound("shockbaton/swingloop",7);
		}
		BATN Q 1 A_ZoomFactor(1.03);
		TNT1 A 0 A_FireCustomMissile("BatonSwing", 0, 0, 0, 0);
		TNT1 A 0 A_TakeInventory("PB_Cell",1);
		BATN R 1 A_ZoomFactor(1.045);
		BATN P 1 A_ZoomFactor(1.055);
		TNT1 A 0 A_JumpIfInventory("SawHasHit",1,"BatonComboStuck");
	BatonCombo2:
		TNT1 A 0 A_Stopsound(7);
		TNT1 A 0 A_StartSound("shockbaton/swing2", 5);
		BATN ST 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 A 0 A_TakeInventory("PB_Cell",1);
		BATN UV 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 A 0 A_TakeInventory("PB_Cell",1);
		TNT1 AAA 1 A_SetRoll(roll+.5, SPF_INTERPOLATE);
		TNT1 AAAAA 1 A_SetRoll(roll-.5, SPF_INTERPOLATE);
		TNT1 AAAAA 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		TNT1 A 0 {
			A_Takeinventory("PB_LockScreenTilt",1);
			A_TakeInventory("SawHasHit",1);
			A_SetRoll(0);
		}
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
//////////////////////////////////////////////// WRENCH ////////////////////////////////////////////////
	WrenchComboDecider:
		TNT1 A 0 A_JumpIfInventory("WrenchDurability",1,1);
		Goto WrenchBreak;
		TNT1 A 3;
		TNT1 A 0 A_Jump(72, "WrenchCombo3");
		TNT1 A 0 A_Jump(256, "WrenchCombo1", "WrenchCombo2");
	
	WrenchCombo1:
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto WrenchBreak;
		TNT1 A 2;
		TNT1 A 0 A_PlaySound("weapons/fistwhoosh", 5);
		WRNC ABCD 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("WrenchSwing", 0, 0, 0, 0); }
		}
        WRNC EFG 1 ;
		TNT1 AAAA 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "WrenchComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	
	WrenchCombo2:
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto WrenchBreak;
		TNT1 A 2;
		TNT1 A 0 A_PlaySound("weapons/fistwhoosh", 5);
		WRNC HIJK 1 A_SetRoll(roll+.8, SPF_INTERPOLATE);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("WrenchSwing", 0, 0, 0, 0); }
		}
        WRNC LMN 1;
		TNT1 AAAA 1 A_SetRoll(roll-.8, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "WrenchComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	WrenchCombo3: 
		TNT1 A 0 A_JumpIfInventory("CrowbarDurability",1,1);
		Goto WrenchBreak;
		TNT1 A 1;
		TNT1 A 0 A_PlaySound("weapons/fistwhoosh", 5);
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") == 1 ) { A_FireCustomMissile("SuperWrenchSwing", 0, 0, 0, 0); }
			else { A_FireCustomMissile("WrenchSwing", 0, 0, 0, 0); }
		}
		TNT1 AAA 1 A_SetPitch(+.2 + pitch, SPF_INTERPOLATE);
		TNT1 AAA 1;
        WRNC RSTUV 1 A_SetPitch(-.2 + pitch, SPF_INTERPOLATE);
		TNT1 AA 1 A_SetPitch(+.2 + pitch, SPF_INTERPOLATE);
		TNT1 A 1 A_JumpIf(PressingUser2(), "WrenchComboDecider");
		TNT1 A 0 A_Takeinventory("PB_LockScreenTilt",1);
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
		
	WrenchBreak:
		TNT1 A 0{
			A_CustomMissile ("MetalShard1", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard2", 5, 0, random (-10, -20), 2, random (0, 30));
			A_CustomMissile ("MetalShard3", 5, 0, random (-10, -20), 2, random (0, 30));
			A_TakeInventory("Wrench",1);
			A_Startsound("meleeweapon/break");
			PB_SetUsingMelee(false);
			A_TakeInventory("ToggleMelee", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwaptoMeleeBroken;
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
		PCKA MMM 2;
		PCKA L 2;
		PCKA K 2;
		PCKA A 3;
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
			A_TakeInventory("PickAxePickup", 1);
			PB_CheckBarrelIdle1();
			}
		Goto SwaptoMeleeBroken;
//////////////////////////////////////////////// SENTINEL HAMMER ////////////////////////////////////////////////
    MeleeSentinelHammer:
		TNT1 A 0 A_JumpIfInventory("SentinelhammerCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto SwaptoMeleeCharges;
        TNT1 A 0 A_PlaySound("HMSWING", 50);
		TNT1 A 0 A_PlaySound("AXSWING", 45);
		SHPB M 1 A_SetAngle(angle+5);
		TNT1 A 0 A_FireCustomMissile("AxeAttack", 0, 0); // WILL ALWAYS TAKE CHARGE
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
		Goto SwaptoMeleeCharges;
        GAFR AB 1;
		PUFF A 0 A_PlaySound("player/cyborg/fist", 3);
		GAFR C 1;
		GAFR D 1 A_CustomPunch (20,0,0,"crowbarpuff"); 
		GAFR EFG 1;
		TNT1 A 0 A_TakeInventory("ClawCharges",1); // WILL ALWAYS TAKE CHARGE
		TNT1 A 5 A_JumpIf(PressingUser2(), "MeleeClaw2");
		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto GoingToReady2;
	MeleeClaw2:
		TNT1 A 0 A_JumpIfInventory("ClawCharges", 1, 2);
		TNT1 A 0 A_Print("No Charges Left");
		Goto SwaptoMeleeCharges;
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
		Goto SwaptoMeleeCharges;
        TNT1 A 0 A_PlaySound("weapons/IMGCok");
		IMPA KLM 1;
		TNT1 A 0 A_CustomPunch (10 * random(10, 55),1,CPF_NOTURN ,"ImpactorPuff",92, 0, 0, "PB_ArmorBonus", "weapons/IMGHit", "weapons/IMGMiss");
		TNT1 A 0 A_Blast(BF_DONTWARN | BF_NOIMPACTDAMAGE | BF_AFFECTBOSSES, 25, 60, 20, "GauntletImpact");
		TNT1 A 0 A_Quake(3, 10, 0, 10);
		IMPA NOP 1;
		IMPA Q 6;
		IMPA RRSSTTUU 1;
		TNT1 A 0 A_TakeInventory("ImpactorCharges", 1); // WILL ALWAYS TAKE CHARGE
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
		TNT1 A 5;
		3AXE ABCDEEEEEEDCBA 1;
		stop;
	}
}