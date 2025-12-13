extend class PB_WeaponBase
{
	States
	{
     // The Actual Custom Melee Animations
    MeleeKatana:
        TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
				A_GiveInventory("KatanaSequence1");
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
				return A_DoPBWeaponAction;
		}
		KTNA ABC 1;
		TNT1 A 0 {
				A_PlaySound("Katana/Swing");
				A_SetRoll(0);
				A_TakeInventory("KatanaSequence1");
				A_GiveInventory("KatanaSequence2");
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
				return A_DoPBWeaponAction;
			}

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready;
    MeleePickAxe:
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
		Goto Ready;
    MeleeSentinelHammer:
        TNT1 A 0 A_PlaySound("HMSWING", 50);
		TNT1 A 0 A_PlaySound("AXSWING", 45);
		SHPB M 1 A_SetAngle(angle+5);
		TNT1 A 0 A_FireCustomMissile("AxeAttack", 0, 0);
		SHPB NOPQ 1 A_SetAngle(angle+5);
		TNT1 AAAAAA 1 A_SetAngle(angle-1,5);

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready;
    MeleeClaw:
        GAFR AB 1;
		PUFF A 0 A_PlaySound("player/cyborg/fist", 3);
		GAFR C 1;
		GAFR D 1 A_CustomPunch (20,0,0,"crowbarpuff");
		GAFR EFG 1;
		TNT1 A 4;
		GAFL AB 1;
		GAFL C 1;
		GAFL D 2 A_CustomPunch (20,0,0,"crowbarpuff2");
		GAFL EFG 1;
		TNT1 A 4;
		TNT1 A 0;

        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready;
    MeleeImpactor:
        TNT1 A 0 A_PlaySound("weapons/IMGCok");
		IMPA KLM 1;
		TNT1 A 0 A_CustomPunch (10 * random(10, 55),1,CPF_NOTURN ,"ImpactorPuff",92, 0, 0, "PB_ArmorBonus", "weapons/IMGHit", "weapons/IMGMiss");
		TNT1 A 0 A_Blast(BF_DONTWARN | BF_NOIMPACTDAMAGE | BF_AFFECTBOSSES, 25, 60, 20, "GauntletImpact");
		TNT1 A 0 A_Quake(3, 10, 0, 10);
		IMPA NOP 1;
		IMPA Q 6;
		IMPA RRSSTTUU 1;

		TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 PB_CheckBarrelIdle1();
		Goto Ready;
    MeleeAxe:
        AX20 ABC 1 {
                if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX23"); }
                if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX22"); }
                if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX21"); }
                A_Setroll(roll+1.0, SPF_INTERPOLATE);
                A_SetAngle(angle-0.5, SPF_INTERPOLATE);
            }
		TNT1 A 0 {
			if (CountInv("PB_PowerStrength") >= 1 ) {
				A_Saw("", "", 30, "AxePuffs", 0, 120, 0,16);
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);
			}
			else {
				A_Saw("", "", 15, "AxePuffs", 0, 120, 0,16);
				A_FireCustomMissile("AxeAttack", 0, 0, 0, 0);
			}
		}
		AX20 DEF 1 {
			if (CountInv("PowerGreenBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX23"); }
			if (CountInv("PowerBlueBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX22"); }
			if (CountInv("PowerBloodOnVisor") >= 1 ) { A_SetWeaponSprite("AX21"); }
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
			return A_DoPBWeaponAction;
		}
        TNT1 A 0 PB_SetUsingMelee(false);
        TNT1 A 0 A_TakeInventory("ToggleMelee", 1);
		TNT1 A 0 A_JumpIf(PressingUser2(), "QuickMelee");
		Goto Ready;
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
        Goto Ready;
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
        Goto Ready;
	}
}