// God Complex enhancement layer — no new keys/HUD; uses Gearbox wheel + GC WeaponSpecial.

class GC_Enhancements
{
	static bool Enabled(PlayerInfo plr = null)
	{
		let cv = CVar.GetCVar("pb_gc_enhancements", plr);
		return cv ? cv.GetBool() : false;
	}

	static bool RuneLite(PlayerInfo plr = null)
	{
		return Enabled(plr) && CVar.GetCVar("pb_gc_rune_lite", plr).GetBool();
	}

	static bool ComplexAmmo(PlayerInfo plr = null)
	{
		return Enabled(plr) && CVar.GetCVar("pb_gc_complex_ammo", plr).GetBool();
	}

	static bool WeaponReplacer(PlayerInfo plr = null)
	{
		return Enabled(plr) && CVar.GetCVar("pb_gc_weapon_replacer", plr).GetBool();
	}

	static bool SpherePickups(PlayerInfo plr = null)
	{
		return Enabled(plr) && CVar.GetCVar("pb_gc_sphere_pickups", plr).GetBool();
	}

	static bool ChaliceEnabled(PlayerInfo plr = null)
	{
		return Enabled(plr) && CVar.GetCVar("pb_gc_chalice", plr).GetBool();
	}

	static bool IsGCWeaponClassName(Name cls)
	{
		switch (cls)
		{
			case 'Devastador':
			case 'GodEnragedBFG':
			case 'EnragedLegendaryBFG':
			case 'NemesisBFG':
			case 'LegendaryAssaultShotgun':
			case 'LegendaryChainsaw':
			case 'LegendaryPlasmaticRifle':
			case 'NemesisLMG':
				return true;
		}
		return false;
	}

	play static void StripInferiorGCWeapons(Actor owner, Name pickedUp)
	{
		if (!owner || !GC_Enhancements.WeaponReplacer(owner.player))
			return;

		array<Name> strip;
		switch (pickedUp)
		{
			case 'NemesisBFG':
				strip.Push('EnragedLegendaryBFG');
				strip.Push('GodEnragedBFG');
				strip.Push('Devastador');
				break;
			case 'EnragedLegendaryBFG':
				strip.Push('GodEnragedBFG');
				strip.Push('Devastador');
				break;
			case 'GodEnragedBFG':
				strip.Push('Devastador');
				break;
			default:
				return;
		}

		for (int i = 0; i < strip.Size(); i++)
		{
			if (pickedUp == strip[i])
				continue;
			let inv = owner.FindInventory(strip[i]);
			while (inv && inv.amount > 0)
				owner.TakeInventory(strip[i], 1);
		}
	}

	play static void DoWeaponSpecial(PlayerPawn pm, Weapon wpn)
	{
		if (!pm || !wpn)
			return;

		Name cls = wpn.GetClassName();

		if (cls == 'LegendaryAssaultShotgun')
		{
			if (pm.CountInv("GCASGSlugMode") >= 1)
			{
				pm.A_TakeInventory("GCASGSlugMode", 1);
				pm.A_Print("Legendary ASG: Buckshot");
			}
			else
			{
				pm.A_GiveInventory("GCASGSlugMode", 1);
				pm.A_Print("Legendary ASG: Slug mode");
			}
			return;
		}

		if (cls == 'Devastador')
		{
			if (pm.CountInv("GCDevastadorBoost") >= 1)
			{
				pm.A_TakeInventory("GCDevastadorBoost", 1);
				pm.A_Print("Devastador: Standard cluster");
			}
			else
			{
				pm.A_GiveInventory("GCDevastadorBoost", 1);
				pm.A_Print("Devastador: Overcharge cluster");
			}
			return;
		}

		if (cls == 'LegendaryChainsaw')
		{
			if (pm.CountInv("GCChainsawBerserk") >= 1)
			{
				pm.A_TakeInventory("GCChainsawBerserk", 1);
				pm.A_Print("Legendary Chainsaw: Standard");
			}
			else
			{
				pm.A_GiveInventory("GCChainsawBerserk", 1);
				pm.A_Print("Legendary Chainsaw: Berserk");
			}
			return;
		}

		if (cls == 'LegendaryPlasmaticRifle')
		{
			if (pm.CountInv("GCPlasmaChargeMode") >= 1)
			{
				pm.A_TakeInventory("GCPlasmaChargeMode", 1);
				pm.A_Print("Plasmatic Rifle: Standard fire");
			}
			else
			{
				pm.A_GiveInventory("GCPlasmaChargeMode", 1);
				pm.A_Print("Plasmatic Rifle: Charged shots");
			}
			return;
		}

		if (cls == 'NemesisLMG')
		{
			if (pm.CountInv("GCNemLMGSuppress") >= 1)
			{
				pm.A_TakeInventory("GCNemLMGSuppress", 1);
				pm.A_Print("Nemesis LMG: Standard");
			}
			else
			{
				pm.A_GiveInventory("GCNemLMGSuppress", 1);
				pm.A_Print("Nemesis LMG: Suppressive spread");
			}
			return;
		}

		if (cls == 'GodEnragedBFG' || cls == 'EnragedLegendaryBFG' || cls == 'NemesisBFG')
		{
			if (pm.CountInv("NemesisBFGMode") >= 1)
			{
				pm.A_TakeInventory("NemesisBFGMode", 1);
				pm.A_Print("BFG: Ball mode");
			}
			else
			{
				pm.A_GiveInventory("NemesisBFGMode", 1);
				pm.A_Print("BFG: Beam mode");
			}
			return;
		}

		// Generic fallback — small complex ammo grant
		if (pm.CountInv("PBWP_ComplexAmmo") < 50)
		{
			pm.A_GiveInventory("PBWP_ComplexAmmo", 25);
			pm.A_Print("Complex essence absorbed");
		}
	}
}

class GC_EnhancementsHandler : EventHandler
{
	Name lastReadyWeapon[MAXPLAYERS];

	override void PlayerEntered(PlayerEvent e)
	{
		if (!e || e.PlayerNumber < 0)
			return;
		let plr = PlayerPawn(players[e.PlayerNumber].mo);
		if (plr)
		{
			plr.SetInventory("GC_ReplacerManager", 1);
			if (e.PlayerNumber >= 0 && e.PlayerNumber < MAXPLAYERS)
				lastReadyWeapon[e.PlayerNumber] = 'None';
		}
	}

	override void WorldLoaded(WorldEvent e)
	{
		for (int pn = 0; pn < MAXPLAYERS; pn++)
			lastReadyWeapon[pn] = 'None';
	}

	override void WorldTick()
	{
		if (level.maptime < PB_MapStartSafeTics)
			return;

		for (int pn = 0; pn < MAXPLAYERS; pn++)
		{
			if (!playeringame[pn])
				continue;
			let pm = PlayerPawn(players[pn].mo);
			if (!pm || !pm.player || pm.health <= 0)
				continue;

			let wpn = pm.player.ReadyWeapon;
			Name cur = wpn ? wpn.GetClassName() : 'None';
			bool weaponChanged = (cur != lastReadyWeapon[pn]);
			if (weaponChanged)
				lastReadyWeapon[pn] = cur;
			if (!weaponChanged && (level.maptime % 35) != 0)
				continue;

			UpdateRuneLite(pm);
			UpdateGCWeaponPowers(pm);
		}
	}

	private void UpdateGCWeaponPowers(PlayerPawn pm)
	{
		let wpn = pm.player.ReadyWeapon;
		Name cls = wpn ? wpn.GetClassName() : 'None';

		if (cls == 'LegendaryChainsaw' && pm.CountInv("GCChainsawBerserk") >= 1)
		{
			if (pm.CountInv("GC_ChainsawBerserkPower") < 1)
				pm.GiveInventory("GC_ChainsawBerserkPower", 1);
		}
		else if (pm.CountInv("GC_ChainsawBerserkPower") >= 1)
			pm.TakeInventory("GC_ChainsawBerserkPower", 1);
	}

	private void UpdateRuneLite(PlayerPawn pm)
	{
		if (!GC_Enhancements.RuneLite(pm.player))
		{
			if (pm.CountInv("GC_RuneLitePower") >= 1)
				pm.TakeInventory("GC_RuneLitePower", 1);
			return;
		}

		let wpn = pm.player.ReadyWeapon;
		bool gcWield = wpn && GC_Enhancements.IsGCWeaponClassName(wpn.GetClassName());
		if (gcWield)
		{
			if (pm.CountInv("GC_RuneLitePower") < 1)
				pm.GiveInventory("GC_RuneLitePower", 1);
		}
		else if (pm.CountInv("GC_RuneLitePower") >= 1)
			pm.TakeInventory("GC_RuneLitePower", 1);
	}

	override void WorldThingDied(WorldEvent e)
	{
		if (!e || !e.thing || !e.thing.bISMONSTER)
			return;
		let killer = e.thing.target;
		let pm = PlayerPawn(killer);
		if (!pm || !pm.player || pm.health <= 0)
			return;
		if (!GC_Enhancements.RuneLite(pm.player))
			return;

		let wpn = pm.player.ReadyWeapon;
		if (!wpn || !GC_Enhancements.IsGCWeaponClassName(wpn.GetClassName()))
			return;

		int heal = max(1, e.thing.GetMaxHealth() / 100);
		pm.GiveInventory("Health", heal);
	}
}

class GC_ReplacerManager : Inventory
{
	Default
	{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
	}

	override bool HandlePickup(Inventory item)
	{
		if (item is "Weapon" && GC_Enhancements.WeaponReplacer(owner.player))
			GC_Enhancements.StripInferiorGCWeapons(owner, item.GetClassName());
		return Super.HandlePickup(item);
	}
}

class GC_RuneLitePower : PowerDamage
{
	Default
	{
		Powerup.Duration 0x7FFFFFFF;
		DamageFactor "*", 1.12;
		Powerup.Color "AA 44 FF", 0.04;
	}
}

class GC_ChainsawBerserkPower : PowerDamage
{
	Default
	{
		Powerup.Duration 0x7FFFFFFF;
		DamageFactor "*", 1.28;
		Powerup.Color "FF 2200", 0.05;
	}
}

class GC_UVShieldPower : PowerProtection
{
	Default
	{
		Powerup.Duration 350;
		Powerup.Mode "Reflective";
		Powerup.Color "40 80 FF", 0.08;
		DamageFactor "*", 0.65;
	}
}

class GC_ShieldSphereCooldown : PowerDamage
{
	Default
	{
		Powerup.Duration 525;
		DamageFactor "Nothing", 1.0;
	}
}

class GC_ChaliceCooldown : PowerDamage
{
	Default
	{
		Powerup.Duration 875;
		DamageFactor "Nothing", 1.0;
	}
}

class GC_ChalicePower : PowerInvulnerable
{
	Default
	{
		Powerup.Duration 625;
		Powerup.Mode "Reflective";
		Powerup.Color "Gold", 0.08;
	}
}

class GC_ChaliceDrain : PowerDrain
{
	Default
	{
		Powerup.Duration 625;
		Powerup.Strength 0.35;
		Powerup.Color "Gold", 0.06;
	}
}

class GC_WeaponSpecialPulse : Inventory
{
	Default
	{
		Inventory.MaxAmount 0;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.QUIET;
	}

	override bool Use(bool pickup)
	{
		let pm = PlayerPawn(owner);
		if (!pm || !pm.player)
			return true;
		let wpn = Weapon(pm.player.ReadyWeapon);
		if (wpn)
			GC_Enhancements.DoWeaponSpecial(pm, wpn);
		return true;
	}
}

class GC_ShieldSpherePulse : Inventory
{
	Default
	{
		Inventory.MaxAmount 0;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.QUIET;
	}

	override bool Use(bool pickup)
	{
		let pm = PlayerPawn(owner);
		if (!pm || pm.health <= 0)
			return true;
		if (pm.CountInv("GC_ShieldSphereCooldown") >= 1)
		{
			pm.A_Print("Shield Sphere cooling down");
			return true;
		}
		pm.A_GiveInventory("GC_UVShieldPower", 1);
		pm.A_GiveInventory("GC_ShieldSphereCooldown", 1);
		pm.A_StartSound("misc/p_pkup", CHAN_ITEM);
		pm.A_Print("GC Shield Sphere active");
		return true;
	}
}

class GC_ChalicePulse : Inventory
{
	Default
	{
		Inventory.MaxAmount 0;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.QUIET;
	}

	override bool Use(bool pickup)
	{
		let pm = PlayerPawn(owner);
		if (!pm || pm.health <= 0)
			return true;
		if (pm.CountInv("GC_ChaliceCooldown") >= 1)
		{
			pm.A_Print("Chalice still recharging");
			return true;
		}
		pm.A_GiveInventory("GC_ChaliceCooldown", 1);
		pm.A_GiveInventory("GC_ChalicePower", 1);
		pm.A_GiveInventory("GC_ChaliceDrain", 1);
		pm.A_Print("Demonic Chalice — brief invulnerability");
		return true;
	}
}

class GC_LegRandomSpherePulse : Inventory
{
	Default
	{
		Inventory.MaxAmount 0;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.QUIET;
	}

	override bool Use(bool pickup)
	{
		let pm = PlayerPawn(owner);
		if (!pm || pm.health <= 0)
			return true;

		int roll = random(1, 8);
		switch (roll)
		{
			case 1:
				pm.A_GiveInventory("PBWP_ComplexAmmo", 100);
				pm.A_Print("Leg Sphere: Complex Ammo surge");
				break;
			case 2:
				pm.A_GiveInventory("PowerDoubleDamage", 1);
				pm.A_Print("Leg Sphere: Double damage");
				break;
			case 3:
				pm.A_GiveInventory("PowerInvulnerable", 1);
				pm.A_Print("Leg Sphere: Invulnerability");
				break;
			case 4:
				pm.A_GiveInventory("PowerSpeed", 1);
				pm.A_Print("Leg Sphere: Haste");
				break;
			case 5:
				pm.A_GiveInventory("GC_UVShieldPower", 1);
				pm.A_Print("Leg Sphere: Shield aura");
				break;
			case 6:
				pm.A_GiveInventory("PBWP_ComplexAmmo", 50);
				pm.A_GiveInventory("PowerRegeneration", 1);
				pm.A_Print("Leg Sphere: Regen + ammo");
				break;
			case 7:
				pm.A_GiveInventory("GC_RuneLitePower", 1);
				pm.A_Print("Leg Sphere: Rune surge");
				break;
			default:
				pm.A_GiveInventory("HealthBonus", 1);
				pm.A_Print("Leg Sphere: Vitality");
				break;
		}
		return true;
	}
}
