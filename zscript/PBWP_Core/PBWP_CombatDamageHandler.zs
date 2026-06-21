// Deferred combat damage — next-tick DamageMobj avoids gore/HUD reentrancy on heavy addon stacks.
// Pattern adapted from STALKER-Theme-Weapons CS_CombatDamageHandler.
class PBWP_CombatDamageHandler : EventHandler
{
	Array<Actor> qVictim;
	Array<Actor> qInflictor;
	Array<Actor> qSource;
	Array<int> qAmount;
	Array<Name> qDmgType;

	static bool IsCombatTarget(Actor victim, Actor attacker)
	{
		if (!victim || !attacker || victim == attacker)
			return false;
		if (victim.health <= 0)
			return false;
		if (!victim.bSHOOTABLE)
			return false;
		return true;
	}

	clearscope static PBWP_CombatDamageHandler Get()
	{
		return PBWP_CombatDamageHandler(EventHandler.Find("PBWP_CombatDamageHandler"));
	}

	static void Schedule(Actor victim, Actor inflictor, Actor source, int amount, Name dmgType)
	{
		if (!IsCombatTarget(victim, source ? source : inflictor))
			return;
		if (!inflictor)
			inflictor = source;
		if (!source)
			source = inflictor;
		if (!source || amount <= 0)
			return;

		let h = Get();
		if (!h)
			return;

		h.qVictim.Push(victim);
		h.qInflictor.Push(inflictor);
		h.qSource.Push(source);
		h.qAmount.Push(amount);
		h.qDmgType.Push(dmgType);
	}

	override void WorldTick()
	{
		int count = qVictim.Size();
		for (int i = 0; i < count; i++)
		{
			let victim = qVictim[i];
			let source = qSource[i];
			if (victim && source && IsCombatTarget(victim, source))
			{
				Actor inf = qInflictor[i] ? qInflictor[i] : source;
				victim.DamageMobj(inf, source, qAmount[i], qDmgType[i]);
			}
		}
		if (count)
		{
			qVictim.Clear();
			qInflictor.Clear();
			qSource.Clear();
			qAmount.Clear();
			qDmgType.Clear();
		}
	}
}
