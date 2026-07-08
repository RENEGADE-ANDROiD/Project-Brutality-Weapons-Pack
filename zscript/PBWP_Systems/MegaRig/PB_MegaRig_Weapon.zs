class PB_MegaRig : PB_WeaponBase
{
	int loadoutSet;
	int slotCatalogIndex[MRG_SLOT_COUNT];
	int volleyIndex;
	bool overlayFiring;
	int volleyAnimStep;
	int volleyAnimTick;

	// Active volley scratch (staggered fire)
	bool volleyLite;
	bool volleyAggressive;
	int volleyPelletCount;
	int volleyHeavyBudget;
	bool volleyTracerUsed;

	void ApplyLoadout(int loadoutSetIndex)
	{
		loadoutSet = loadoutSetIndex % MRG_LOADOUT_COUNT;
		for (int i = 0; i < MRG_SLOT_COUNT; i++)
			slotCatalogIndex[i] = PB_MegaRigCatalog.GetPresetEntry(loadoutSet, i);
	}

	default
	{
		Weapon.SlotNumber 9;
		Weapon.SlotPriority 0;
		Weapon.AmmoType1 "PB_Cell";
		Weapon.AmmoGive1 0;
		Weapon.AmmoUse1 1;
		+WEAPON.NOAUTOAIM;
		+WEAPON.CHEATNOTWEAPON;
		+INVENTORY.UNDROPPABLE;
		+FORCEXYBILLBOARD;
		Tag "Hyperweapon Rig";
		inventory.pickupmessage "Hyperweapon Rig active!";
		inventory.pickupsound "BFG2704/Select";
		Obituary "%o was erased by %k's Hyperweapon Rig.";
		PB_WeaponBase.respectItem "MegaRigRespect";
	}

	static play void ClearOverlayLayers(PlayerPawn mo)
	{
		if (!mo || !mo.player)
			return;
		mo.A_ClearOverlays(MRG_OVERLAY_LAYER_MIN, MRG_OVERLAY_LAYER_MAX, false);
	}

	// Hyperweapon Rig is only valid while PB_PowerMegaRig is active (killstreak sphere).
	override void AttachToOwner(Actor owner)
	{
		if (!owner || !owner.FindInventory("PB_PowerMegaRig"))
		{
			Destroy();
			return;
		}
		Super.AttachToOwner(owner);
	}

	override void DoEffect()
	{
		Super.DoEffect();
		if (Owner && !Owner.FindInventory("PB_PowerMegaRig"))
			Owner.TakeInventory(GetClass(), 1);
	}

	States
	{
	Spawn:
		TNT1 A -1;
		Stop;

	Steady:
		TNT1 A 1;
		Goto Ready3;

	Select:
		TNT1 A 0 A_JumpIfInventory("PB_PowerMegaRig", 1, "SelectPowered");
		Goto ExpireDeselect;

	SelectPowered:
		TNT1 A 0 A_WeaponOffset(0, 32);
		Goto SelectFirstPersonLegs;

	SelectContinue:
		TNT1 A 0 PB_WeaponRaise();
		TNT1 A 0 PB_WeapTokenSwitch("AddonSelected");
		TNT1 A 0 {
			let rig = PB_MegaRig(invoker);
			if (rig)
				rig.ApplyLoadout(0);
		}
		TNT1 A 0 PB_Mega_PrecacheSprites();
		TNT1 A 0 PB_Mega_ApplyAllVisuals();
		TNT1 A 0 A_WeaponOffset(2, 34, WOF_INTERPOLATE);
		TNT1 A 0 { return PB_RespectIfNeeded(); }

	SelectAnimation:
		TNT1 A 1 A_StartSound("BFG2704/Select", CHAN_WEAPON);
		Goto Ready3;

	WeaponRespect:
		TNT1 A 0 A_GiveInventory("MegaRigRespect", 1);
		TNT1 A 0 A_StartSound("BFG2704/Select", CHAN_WEAPON);
		TNT1 A 0 A_SetBlend("00FFAA", 0.12, 8);
		BF27 ABCD 3 Bright;
		TNT1 A 0 PB_Mega_ApplyAllVisuals();
		Goto Ready3;

	Deselect:
		TNT1 A 0 PB_Mega_ClearOverlays();
		TNT1 A 0 A_WeaponOffset(0, 32);
		Goto DeselectDown;

	DeselectDown:
		TNT1 A 0 A_Lower(120);
		Wait;

	ExpireDeselect:
		TNT1 A 0 PB_Mega_ClearOverlays();
		TNT1 A 0 A_TakeInventory("PB_MegaRig", 1);
		TNT1 A 0 A_WeaponOffset(0, 32);
		TNT1 A 0 A_Lower(120);
		Wait;

	Ready:
	Ready3:
		TNT1 A 0 A_JumpIfInventory("GoFatality", 1, "Steady");
		TNT1 A 0 A_JumpIfInventory("PB_PowerMegaRig", 1, "Ready3Loop");
		Goto ExpireDeselect;

	Ready3Loop:
		TNT1 A 1 {
			A_WeaponOffset(0, 32);
			PB_HandleCrosshair(75);
			A_TakeInventory("PB_LockScreenTilt", 1);
			return A_DoPBWeaponAction(WRF_NOBOB);
		}
		Loop;

	Fire:
		TNT1 A 0 A_JumpIfInventory("PB_PowerMegaRig", 1, "FireContinue");
		Goto ExpireDeselect;

	FireContinue:
		TNT1 A 0 PB_jumpIfHasBarrel("ThrowBarrel", "ThrowFlameBarrel", "ThrowIceBarrel");
		TNT1 A 0 {
			if (CountInv("NoFatality") == 0 && GetCVar("ttwcfbex") == 1)
				return PB_Execute();
			return ResolveState(null);
		}
		TNT1 A 0 { return PB_Mega_BeginVolley(); }
		TNT1 A 0 PB_Mega_SlotVolleyBegin(0);
		Goto FireVolleyAnim;

	FireVolleyAnim:
		TNT1 A 1 { return PB_Mega_SlotVolleyAnimTick(); }
		Loop;

	FireFinishFull:
		TNT1 A 4;
		Goto FireEnd;

	FireFinishLite:
		TNT1 A 6;
		Goto FireEnd;

	FireEnd:
		TNT1 A 0 PB_Mega_RestoreReadyFrames();
		TNT1 A 0 A_ReFire;
		Goto Ready3;

	WeaponSpecial:
		TNT1 A 0 A_TakeInventory("GoWeaponSpecialAbility", 1);
		TNT1 A 0
		{
			int fam = CountInv("MegaRigPriorityFamily");
			if (fam >= 4)
				A_TakeInventory("MegaRigPriorityFamily", 4);
			else
				A_GiveInventory("MegaRigPriorityFamily", 1);
			fam = CountInv("MegaRigPriorityFamily");
			A_PlaySound("LIGHTON", CHAN_AUTO);
			if (fam == 1) A_Print("Priority Rack: Ballistic");
			else if (fam == 2) A_Print("Priority Rack: Scatter");
			else if (fam == 3) A_Print("Priority Rack: Heavy");
			else if (fam == 4) A_Print("Priority Rack: Energy");
			else A_Print("Priority Rack: Full Volley");
		}
		Goto Ready3;

	AltFire:
		TNT1 A 0 A_JumpIfInventory("PB_PowerMegaRig", 1, "AltFireContinue");
		Goto ExpireDeselect;

	AltFireContinue:
		TNT1 A 0 PB_Mega_CycleLoadout();
		TNT1 A 3;
		Goto Ready3;

	MegaRig_Hold:
		TNT1 A -1;
		Stop;

	FlashPunching:
		TNT1 AAAAAAAAAAAAAA 1;
		Stop;
	FlashKicking:
		TNT1 AAAAAAAAAAAAAAA 1;
		Stop;
	FlashAirKicking:
		TNT1 AAAAAAAAAAAAAAAA 1;
		Stop;
	FlashSlideKicking:
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 1;
		Stop;
	FlashSlideKickingStop:
		TNT1 AAAAAAA 1;
		Stop;

	LoadSprites:
		TNT1 A 0;
		Stop;
	}
}

extend class PB_MegaRig
{
	bool PB_Mega_UseLiteVolley()
	{
		if (PBWP_FXThrottleHandler.PerformanceFireEnabled())
			return true;
		let c = CVar.GetCVar("pb_megarig_lite");
		return c == null || c.GetBool();
	}

	bool PB_Mega_AggressivePerf()
	{
		return PBWP_FXThrottleHandler.PerformanceFireEnabled();
	}

	int PB_Mega_PelletCount(bool lite, bool aggressive)
	{
		if (aggressive)
			return 3;
		if (lite)
			return 4;
		return 8;
	}

	int PB_Mega_HeavyBudget(bool lite, bool aggressive)
	{
		if (aggressive)
			return 1;
		if (lite)
			return 2;
		return MRG_SLOT_COUNT;
	}

	bool PB_Mega_SlotDealsDamage(int slot, bool lite, bool aggressive, int volleyIdx)
	{
		if (!lite)
			return true;
		if (aggressive && (slot == MRG_SLOT_OUTER_L || slot == MRG_SLOT_OUTER_R))
			return false;
		if ((slot == MRG_SLOT_INNER_L || slot == MRG_SLOT_INNER_R) && (volleyIdx & 1) != 0)
			return false;
		return true;
	}

	// Priority Rack: 1 ballistic, 2 scatter, 3 heavy missiles, 4 energy.
	static bool PB_Mega_AttackMatchesPriority(EMegaRigAttack attack, int priority)
	{
		switch (priority)
		{
			case 1:
				return attack == MRG_ATK_PROJ_556
					|| attack == MRG_ATK_PROJ_762
					|| attack == MRG_ATK_PROJ_9MM;
			case 2:
				return attack == MRG_ATK_PROJ_SHOTGUN
					|| attack == MRG_ATK_PROJ_NAIL;
			case 3:
				return attack == MRG_ATK_MISSILE_ROCKET
					|| attack == MRG_ATK_MISSILE_GAUSS;
			case 4:
				return attack == MRG_ATK_MISSILE_ENERGY
					|| attack == MRG_ATK_MISSILE_PLASMA
					|| attack == MRG_ATK_MISSILE_BFG;
			default:
				return true;
		}
	}

	action void PB_Mega_ClearOverlays()
	{
		PB_MegaRig.ClearOverlayLayers(player.mo);
	}

	action Name PB_Mega_SpriteForEntry(MegaRigCatalogEntry entry, bool fireVisual)
	{
		if (fireVisual && entry.fireSpritePrefix != 'None')
			return entry.fireSpritePrefix;
		return entry.spritePrefix;
	}

	action void PB_Mega_SetSlotSprite(int slot, MegaRigCatalogEntry entry, bool fireVisual)
	{
		int layer = PB_MegaRigCatalog.LayerForSlot(slot);
		let psp = player.GetPSprite(layer);
		if (psp)
			psp.sprite = GetSpriteIndex(PB_Mega_SpriteForEntry(entry, fireVisual));
	}

	action void PB_Mega_SetSlotFrame(int slot, int frame)
	{
		int layer = PB_MegaRigCatalog.LayerForSlot(slot);
		let psp = player.GetPSprite(layer);
		if (psp)
			psp.frame = frame;
	}

	action void PB_Mega_ApplySlotVisual(int slot)
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn || slot < 0 || slot >= MRG_SLOT_COUNT)
			return;

		MegaRigCatalogEntry entry;
		PB_MegaRigCatalog.GetEntry(wpn.slotCatalogIndex[slot], entry);
		MegaRigSlotAnchor anchor;
		PB_MegaRigCatalog.GetAnchor(slot, anchor);
		int layer = PB_MegaRigCatalog.LayerForSlot(slot);

		bool centerpiece = PB_MegaRigCatalog.SlotIsCenterpiece(wpn.loadoutSet, slot, wpn.slotCatalogIndex[slot]);

		double offsetY = anchor.offsetY;
		double offsetX = anchor.offsetX;
		double roll = anchor.roll;
		double scale = anchor.scale;

		if (centerpiece || entry.isHero)
		{
			scale += 0.10;
			offsetY += 4;
		}
		else if (slot == MRG_SLOT_INNER_L || slot == MRG_SLOT_INNER_R)
			offsetY += 2;

		if (entry.isTall && !PB_MegaRigCatalog.SlotIsCenter(slot))
			offsetY += 4;

		A_Overlay(layer, "MegaRig_Hold");
		A_OverlayPivotAlign(layer, PSPA_CENTER, PSPA_BOTTOM);
		A_OverlayOffset(layer, offsetX, offsetY);
		A_OverlayRotate(layer, roll);
		A_OverlayScale(layer, scale, scale);
		A_OverlayFlags(layer, PSPF_ADDWEAPON | PSPF_ADDBOB, false);

		let psp = player.GetPSprite(layer);
		if (psp)
		{
			psp.sprite = GetSpriteIndex(entry.spritePrefix);
			psp.frame = entry.readyFrame;
		}
	}

	action void PB_Mega_RefreshOverlaySprites()
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn || wpn.overlayFiring)
			return;
		for (int i = 0; i < MRG_SLOT_COUNT; i++)
		{
			MegaRigCatalogEntry entry;
			PB_MegaRigCatalog.GetEntry(wpn.slotCatalogIndex[i], entry);
			PB_Mega_SetSlotSprite(i, entry, false);
			PB_Mega_SetSlotFrame(i, entry.readyFrame);
		}
	}

	action void PB_Mega_PrecacheSprites()
	{
		for (int i = 0; i < MRG_CATALOG_ENTRIES; i++)
		{
			MegaRigCatalogEntry entry;
			PB_MegaRigCatalog.GetEntry(i, entry);
			GetSpriteIndex(entry.spritePrefix);
			if (entry.fireSpritePrefix != 'None')
				GetSpriteIndex(entry.fireSpritePrefix);
		}
	}

	action void PB_Mega_ApplyAllVisuals()
	{
		for (int i = 0; i < MRG_SLOT_COUNT; i++)
			PB_Mega_ApplySlotVisual(i);
	}

	action void PB_Mega_RestoreReadyFrames()
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return;
		wpn.overlayFiring = false;
		for (int i = 0; i < MRG_SLOT_COUNT; i++)
		{
			MegaRigCatalogEntry entry;
			PB_MegaRigCatalog.GetEntry(wpn.slotCatalogIndex[i], entry);
			PB_Mega_SetSlotSprite(i, entry, false);
			PB_Mega_SetSlotFrame(i, entry.readyFrame);
		}
	}

	action void PB_Mega_CycleLoadout()
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return;

		wpn.ApplyLoadout(wpn.loadoutSet + 1);
		PB_Mega_ApplyAllVisuals();

		String label = PB_MegaRigCatalog.GetLoadoutDisplayName(wpn.loadoutSet);
		A_Print(String.Format("\cgHyperweapon Rig\c- loadout: \ct%s\c-", label), 2.0);
		A_SetBlend("00FFAA", 0.08, 6);
		A_StartSound(PB_MegaRigCatalog.GetLoadoutSwitchSound(wpn.loadoutSet), CHAN_WEAPON);
	}

	action state PB_Mega_BeginVolley()
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return ResolveState(null);

		bool unlimited = CountInv("PB_PowerMegaRig") >= 1;
		if (!unlimited && CountInv(invoker.ammotype1) < 1)
		{
			A_StartSound("weapons/empty", 6, CHANF_OVERLAP);
			return ResolveState("Ready3");
		}

		if (!unlimited)
			A_TakeInventory(invoker.ammotype1, 1);

		wpn.volleyLite = wpn.PB_Mega_UseLiteVolley();
		wpn.volleyAggressive = wpn.PB_Mega_AggressivePerf();
		wpn.volleyPelletCount = wpn.PB_Mega_PelletCount(wpn.volleyLite, wpn.volleyAggressive);
		wpn.volleyHeavyBudget = wpn.PB_Mega_HeavyBudget(wpn.volleyLite, wpn.volleyAggressive);
		wpn.volleyIndex++;
		wpn.volleyTracerUsed = false;
		wpn.overlayFiring = true;

		A_AlertMonsters();
		return ResolveState(null);
	}

	action void PB_Mega_VolleyCenterPunch()
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn || wpn.volleyAggressive)
			return;
		PB_QuakeCamera(2, 0.35);
	}

	action void PB_Mega_SpawnSlotMuzzleFX(int slot, MegaRigCatalogEntry entry, double mSide, double mHeight, double mForward)
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn || wpn.volleyAggressive)
			return;
		if (!PBWP_FXThrottleHandler.ShouldSpawnCosmeticFX(self))
			return;

		double d1 = mSide;
		double d2 = mHeight + 14;
		double d3 = -6 - mForward * 0.5;

		PB_GunSmoke_Basic(d1, d2, d3);
		if (slot == MRG_SLOT_CENTER || entry.isHero)
			PB_MuzzleFlashEffects(d1, d2, d3, 0xFFAA44, false, true, 56, 2);
		else if (PB_MegaRigCatalog.IsHeavyAttack(entry.attack))
			PB_MuzzleFlashEffects(d1, d2, d3, 0x88CCFF, false, true, 48, 2);
	}

	action void PB_Mega_ApplySlotRecoil(int slot, MegaRigCatalogEntry entry, int animTick)
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return;

		MegaRigSlotAnchor anchor;
		PB_MegaRigCatalog.GetAnchor(slot, anchor);
		int layer = PB_MegaRigCatalog.LayerForSlot(slot);

		double kickPhase = animTick <= 1 ? 1.0 : max(0.0, 1.0 - (animTick - 1) * 0.45);
		double kickX = entry.recoilKickX * kickPhase;
		double kickY = entry.recoilKickY * kickPhase;

		if (slot == MRG_SLOT_OUTER_L)
			kickX -= abs(entry.recoilKickY) * 0.15 * kickPhase;
		else if (slot == MRG_SLOT_OUTER_R)
			kickX += abs(entry.recoilKickY) * 0.15 * kickPhase;

		double offsetY = anchor.offsetY;
		double offsetX = anchor.offsetX;
		double scale = anchor.scale;

		if (PB_MegaRigCatalog.SlotIsCenterpiece(wpn.loadoutSet, slot, wpn.slotCatalogIndex[slot]) || entry.isHero)
		{
			scale += 0.10;
			offsetY += 4;
		}
		else if (slot == MRG_SLOT_INNER_L || slot == MRG_SLOT_INNER_R)
			offsetY += 2;

		if (entry.isTall && !PB_MegaRigCatalog.SlotIsCenter(slot))
			offsetY += 4;

		A_OverlayOffset(layer, offsetX + kickX, offsetY + kickY);
	}

	action void PB_Mega_UpdateSlotFireVisual(int step, int animTick, MegaRigCatalogEntry entry)
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return;

		int slot = PB_MegaRigCatalog.GetVolleyFireOrder(step);
		int frameIdx = animTick % entry.fireFrameCount;
		int frame = entry.fireFrame + frameIdx;

		PB_Mega_SetSlotSprite(slot, entry, entry.fireSpritePrefix != 'None' || animTick > 0);
		PB_Mega_SetSlotFrame(slot, frame);
		PB_Mega_ApplySlotRecoil(slot, entry, animTick);
	}

	action void PB_Mega_RestoreSlotVisual(int step, MegaRigCatalogEntry entry)
	{
		int slot = PB_MegaRigCatalog.GetVolleyFireOrder(step);
		PB_Mega_SetSlotSprite(slot, entry, false);
		PB_Mega_SetSlotFrame(slot, entry.readyFrame);
		PB_Mega_ApplySlotVisual(slot);
	}

	action void PB_Mega_DispatchAttack(int slot, MegaRigCatalogEntry entry, double yawBias, bool spawnTracer, int pelletCount,
		double mSide, double mHeight, double mForward)
	{
		double sp = entry.spread;
		double pt = entry.pitch + yawBias;

		switch (entry.attack)
		{
			case MRG_ATK_PROJ_556:
				A_FireProjectile("PB_556x45mm", frandom(-sp, sp), 0, mSide, mHeight, FPF_NOAUTOAIM, frandom(-sp, sp) + pt);
				break;
			case MRG_ATK_PROJ_762:
				A_FireProjectile("PB_762x51mm", frandom(-sp, sp), 0, mSide, mHeight, FPF_NOAUTOAIM, frandom(-sp, sp) + pt);
				break;
			case MRG_ATK_PROJ_9MM:
				A_FireProjectile("PB_9x19mmHollowPoint", frandom(-sp, sp), 0, mSide, mHeight, FPF_NOAUTOAIM, frandom(-sp, sp) + pt);
				break;
			case MRG_ATK_PROJ_SHOTGUN:
				PB_FireBullets("PB_Complex12GAPellet", pelletCount, frandom(sp * 0.8, sp * 1.2), mSide, mHeight, pt);
				break;
			case MRG_ATK_PROJ_NAIL:
				A_FireCustomMissile("PB_MGNail", pt, 0, mSide, mHeight - 6, mForward, frandom(-sp, sp));
				break;
			case MRG_ATK_MISSILE_ROCKET:
				A_FireCustomMissile("RPGRocket", pt, 1, mSide, mHeight - 6, mForward, frandom(-sp, sp));
				break;
			case MRG_ATK_MISSILE_ENERGY:
				A_FireCustomMissile("StingerHellBullet", pt, 0, mSide, mHeight, mForward, frandom(-sp, sp));
				break;
			case MRG_ATK_MISSILE_PLASMA:
				A_FireCustomMissile("PBWP_AcidHellBullet", pt, 0, mSide, mHeight, mForward, frandom(-sp, sp));
				break;
			case MRG_ATK_MISSILE_BFG:
				A_FireCustomMissile("PlayerMiniNemesisBFGBall", pt, 0, mSide, mHeight, mForward);
				break;
			case MRG_ATK_MISSILE_GAUSS:
				A_FireCustomMissile("DoomerGaussShot", pt, 0, mSide, mHeight, mForward, frandom(-sp, sp));
				break;
			default:
				break;
		}

		if (spawnTracer)
		{
			switch (entry.attack)
			{
				case MRG_ATK_PROJ_556:
					A_FireCustomMissile("PBWP_Tracer_Rifle", pt, 1, mSide, mHeight, mForward, frandom(-sp, sp));
					break;
				case MRG_ATK_PROJ_762:
					A_FireCustomMissile("PBWP_Tracer_Heavy", pt, 1, mSide, mHeight, mForward, frandom(-sp, sp));
					break;
				case MRG_ATK_PROJ_9MM:
					A_FireCustomMissile("PBWP_Tracer_Pistol", pt, 1, mSide, mHeight, mForward, frandom(-sp, sp));
					break;
				default:
					break;
			}
		}
	}

	action void PB_Mega_SlotVolleyBegin(int step)
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return;

		wpn.volleyAnimStep = step;
		wpn.volleyAnimTick = 0;

		int slot = PB_MegaRigCatalog.GetVolleyFireOrder(step);
		MegaRigCatalogEntry entry;
		PB_MegaRigCatalog.GetEntry(wpn.slotCatalogIndex[slot], entry);

		PB_Mega_UpdateSlotFireVisual(step, 0, entry);

		if (entry.fireSound)
			A_StartSound(entry.fireSound, CHAN_WEAPON + slot, CHANF_OVERLAP);

		double mSide, mHeight, mForward;
		PB_MegaRigCatalog.GetMuzzleOffsets(slot, wpn.loadoutSet, wpn.slotCatalogIndex[slot], entry, mSide, mHeight, mForward);
		PB_Mega_SpawnSlotMuzzleFX(slot, entry, mSide, mHeight, mForward);

		if (!wpn.PB_Mega_SlotDealsDamage(slot, wpn.volleyLite, wpn.volleyAggressive, wpn.volleyIndex))
			return;

		int priority = CountInv("MegaRigPriorityFamily");
		if (priority > 0 && !PB_Mega_AttackMatchesPriority(entry.attack, priority))
			return;

		if (wpn.volleyLite && PB_MegaRigCatalog.IsHeavyAttack(entry.attack))
		{
			if (wpn.volleyHeavyBudget <= 0)
				return;
			wpn.volleyHeavyBudget--;
		}

		PBWP_FXThrottleHandler.RegisterCombatEvent(self);

		bool spawnTracer = false;
		if (!wpn.volleyTracerUsed && slot == MRG_SLOT_CENTER
			&& PBWP_FXThrottleHandler.ShouldSpawnCosmeticFX(self))
		{
			spawnTracer = true;
			wpn.volleyTracerUsed = true;
		}

		double yawBias = (slot - MRG_SLOT_CENTER) * 1.8;
		PB_Mega_DispatchAttack(slot, entry, yawBias, spawnTracer, wpn.volleyPelletCount, mSide, mHeight, mForward);

		if (!wpn.volleyAggressive)
		{
			double recoilPitch = abs(entry.recoilKickY) * 0.04;
			double recoilAngle = (slot - MRG_SLOT_CENTER) * 0.12;
			if (entry.isHero || slot == MRG_SLOT_CENTER)
				recoilPitch *= 1.35;
			PB_WeaponRecoil(recoilPitch, recoilAngle, 1.0);
		}
	}

	action state PB_Mega_SlotVolleyAnimTick()
	{
		let wpn = PB_MegaRig(invoker);
		if (!wpn)
			return ResolveState("FireEnd");

		int step = wpn.volleyAnimStep;
		int slot = PB_MegaRigCatalog.GetVolleyFireOrder(step);
		MegaRigCatalogEntry entry;
		PB_MegaRigCatalog.GetEntry(wpn.slotCatalogIndex[slot], entry);

		int hold = entry.volleyHoldTics;
		if (wpn.volleyLite)
			hold = max(2, hold - 1);
		if (wpn.volleyAggressive)
			hold = max(2, hold - 2);

		wpn.volleyAnimTick++;
		if (wpn.volleyAnimTick < hold)
		{
			PB_Mega_UpdateSlotFireVisual(step, wpn.volleyAnimTick, entry);
			return ResolveState(null);
		}

		PB_Mega_RestoreSlotVisual(step, entry);

		if (step == 2)
			PB_Mega_VolleyCenterPunch();

		if (step < 4)
		{
			PB_Mega_SlotVolleyBegin(step + 1);
			return ResolveState(null);
		}

		if (wpn.PB_Mega_UseLiteVolley())
			return ResolveState("FireFinishLite");
		return ResolveState("FireFinishFull");
	}
}

class MegaRigRespect : Inventory
{
	default
	{
		Inventory.MaxAmount 1;
	}
}

class PB_MegaRigPickup : Inventory
{
	default
	{
		+INVENTORY.ALWAYSPICKUP;
		Inventory.PickupMessage "Hyperweapon Rig reward!";
		Inventory.PickupSound "BFG2704/Select";
		Tag "Hyperweapon Rig Pickup";
	}

	States
	{
	Spawn:
		BF27 A -1 Bright;
		Stop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PB_MegaRigSphere", 1);
		Stop;
	}
}
