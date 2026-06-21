// PBWP stand-in for PB_EventHandler helpers used by XP / spin (separate ZScript TU from PB Staging).
class PBWP_XPCompat
{
	clearscope static bool PB_XP_RewardsOn()
	{
		if (netgame)
			return false;
		let cv = CVar.FindCVar("pb_xp_rewards");
		return !cv || cv.GetBool();
	}

	clearscope static string PB_PDA_NormClassStr(string cn)
	{
		cn.Replace("\r", "");
		cn.Replace("\n", "");
		cn.Replace("\t", "");
		while (cn.Length() > 0 && cn.ByteAt(0) <= 32)
			cn = cn.Mid(1, cn.Length() - 1);
		while (cn.Length() > 0 && cn.ByteAt(cn.Length() - 1) <= 32)
			cn = cn.Mid(0, cn.Length() - 1);
		return cn;
	}

	clearscope static PlayerPawn PB_PDA_ResolvePlayer(Actor a)
	{
		for (int i = 0; a && i < 10; i++)
		{
			if (a is "PlayerPawn" && PlayerPawn(a).player)
				return PlayerPawn(a);
			Actor next = a.target != null ? a.target : (a.master != null ? a.master : a.tracer);
			if (!next || next == a)
				break;
			a = next;
		}
		return null;
	}

	clearscope static PlayerPawn PB_PDA_ResolveKiller(WorldEvent e)
	{
		if (!e)
			return null;
		// Only credit kills the player (or their weapon/projectile) actually inflicted.
		// Do not fall back to e.Thing.target — monsters can acquire the player as target
		// from sight alone, which caused idle XP when they died to infighting or hazards.
		PlayerPawn p = PB_PDA_ResolvePlayer(e.Inflictor);
		if (p)
			return p;
		return PB_PDA_ResolvePlayer(e.DamageSource);
	}
}
