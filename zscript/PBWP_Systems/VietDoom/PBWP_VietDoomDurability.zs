// Syncs PB_VietDoomDurability CVAR to player inventory gate token.
// PBWP_VietDoomDurability seeds wear counters when weapons are cheat-given (no HC pickup path).

class PBWP_VietDoomDurability
{
	static bool IsActive(Actor mo)
	{
		if (!mo)
			return false;
		let c = CVar.GetCVar('PB_VietDoomDurability');
		if (c && !c.GetBool())
			return false;
		if (mo.CountInv('VietDoomDurabilityDisabled') >= 1)
			return false;
		return true;
	}

	static play void EnsureDropper(PlayerPawn p)
	{
		if (!p || p.FindInventory('Dropper'))
			return;
		p.GiveInventory('Dropper', 1);
	}

	static play void ApplyDurability(PlayerPawn p, Name durToken, int maxAmt, Name destroyedToken, bool forceFull)
	{
		int cur = p.CountInv(durToken);
		if (!forceFull && cur > 0)
			return;

		let inv = Inventory(p.FindInventory(durToken));
		if (inv)
			inv.Amount = maxAmt;
		else
			p.GiveInventory(durToken, maxAmt);

		if (destroyedToken != 'None')
			p.TakeInventory(destroyedToken, 1);
	}

	static play void SeedWeapon(PlayerPawn p, Name weaponClass, bool forceFull = false)
	{
		if (!p || !IsActive(p))
			return;

		Name durToken;
		Name destroyedToken;
		int maxAmt;
		if (!Lookup(weaponClass, durToken, maxAmt, destroyedToken))
			return;

		if (!forceFull)
		{
			if (p.CountInv(durToken) > 0)
				return;
			if (destroyedToken != 'None' && p.CountInv(destroyedToken) >= 1)
				return;
		}

		ApplyDurability(p, durToken, maxAmt, destroyedToken, forceFull);
	}

	static play void SeedAllForPlayer(PlayerPawn p, bool forceFull = false)
	{
		if (!p || !IsActive(p))
			return;

		EnsureDropper(p);

		static const Name kWeapons[] =
		{
			'M1911', 'M3a1', 'Thompson', 'MAT49', 'Ithaca', 'IthacaFlame',
			'M14', 'SKS', 'M16', 'XM21', 'Mosin', 'AK', 'BAR',
			'M79', 'RPG', 'M60', 'RPD', 'Stoner'
		};

		for (int i = 0; i < kWeapons.Size(); i++)
		{
			if (p.FindInventory(kWeapons[i]))
				SeedWeapon(p, kWeapons[i], forceFull);
		}
	}

	static bool Lookup(Name weaponClass, out Name durToken, out int maxAmt, out Name destroyedToken)
	{
		durToken = 'None';
		destroyedToken = 'None';
		maxAmt = 0;

		switch (weaponClass)
		{
			case 'M1911':
				durToken = 'M1911Durability'; destroyedToken = 'M1911Destroyed'; maxAmt = 300;
				return true;
			case 'M3a1':
				durToken = 'M3Durability'; destroyedToken = 'M3Destroyed'; maxAmt = 700;
				return true;
			case 'Thompson':
				durToken = 'ThompsonDurability'; destroyedToken = 'ThompsonDestroyed'; maxAmt = 600;
				return true;
			case 'MAT49':
				durToken = 'MAT49Durability'; destroyedToken = 'MAT49Destroyed'; maxAmt = 500;
				return true;
			case 'Ithaca':
			case 'IthacaFlame':
				durToken = 'IthacaDurability'; destroyedToken = 'IthacaDestroyed'; maxAmt = 300;
				return true;
			case 'M14':
				durToken = 'M14Durability'; destroyedToken = 'M14Destroyed'; maxAmt = 500;
				return true;
			case 'SKS':
				durToken = 'SKSDurability'; destroyedToken = 'SKSDestroyed'; maxAmt = 600;
				return true;
			case 'M16':
				durToken = 'M16Durability'; destroyedToken = 'M16Destroyed'; maxAmt = 700;
				return true;
			case 'XM21':
				durToken = 'M21Durability'; destroyedToken = 'M21Destroyed'; maxAmt = 300;
				return true;
			case 'Mosin':
				durToken = 'MosinDurability'; destroyedToken = 'MosinDestroyed'; maxAmt = 300;
				return true;
			case 'AK':
				durToken = 'AKDurability'; destroyedToken = 'AKDestroyed'; maxAmt = 1000;
				return true;
			case 'BAR':
				durToken = 'BARDurability'; destroyedToken = 'BARDestroyed'; maxAmt = 700;
				return true;
			case 'M79':
				durToken = 'M79Durability'; destroyedToken = 'M79Destroyed'; maxAmt = 50;
				return true;
			case 'RPG':
				durToken = 'RPGDurability'; destroyedToken = 'RPGDestroyed'; maxAmt = 30;
				return true;
			case 'M60':
				durToken = 'M60Durability'; destroyedToken = 'M60Destroyed'; maxAmt = 800;
				return true;
			case 'RPD':
				durToken = 'RPDDurability'; destroyedToken = 'RPDDestroyed'; maxAmt = 900;
				return true;
			case 'Stoner':
				durToken = 'StonerDurability'; destroyedToken = 'StonerDestroyed'; maxAmt = 600;
				return true;
		}
		return false;
	}
}

class PBWP_VietDoomDurabilityHandler : StaticEventHandler
{
	transient bool lastEnabled;
	transient int seedTick;

	override void WorldLoaded(WorldEvent e)
	{
		lastEnabled = ReadEnabled();
		seedTick = 0;
		SyncAllPlayers();
	}

	override void PlayerSpawned(PlayerEvent e)
	{
		if (e.PlayerNumber < 0 || e.PlayerNumber >= MAXPLAYERS)
			return;
		let mo = PlayerPawn(players[e.PlayerNumber].mo);
		if (mo)
		{
			SyncPlayer(mo);
			PBWP_VietDoomDurability.EnsureDropper(mo);
			PBWP_VietDoomDurability.SeedAllForPlayer(mo);
		}
	}

	override void WorldTick()
	{
		bool now = ReadEnabled();
		if (now != lastEnabled)
		{
			lastEnabled = now;
			SyncAllPlayers();
		}

		seedTick++;
		if (seedTick < 35)
			return;
		seedTick = 0;

		for (int i = 0; i < MAXPLAYERS; i++)
		{
			if (!playeringame[i])
				continue;
			let p = PlayerPawn(players[i].mo);
			if (p)
				PBWP_VietDoomDurability.SeedAllForPlayer(p);
		}
	}

	bool ReadEnabled()
	{
		let c = CVar.GetCVar('PB_VietDoomDurability');
		return c ? c.GetBool() : true;
	}

	void SyncAllPlayers()
	{
		for (int i = 0; i < MAXPLAYERS; i++)
		{
			let p = PlayerPawn(players[i].mo);
			if (p)
			{
				SyncPlayer(p);
				PBWP_VietDoomDurability.EnsureDropper(p);
			}
		}
	}

	void SyncPlayer(Actor mo)
	{
		if (!mo)
			return;
		if (ReadEnabled())
			mo.TakeInventory('VietDoomDurabilityDisabled', 1);
		else
			mo.GiveInventory('VietDoomDurabilityDisabled', 1);
	}
}
