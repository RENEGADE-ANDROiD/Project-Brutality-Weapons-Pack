enum slot1Masks
{
    mask_BeamKatana      = 1 << 0,
    mask_ArgentSith      = 1 << 1,
    mask_BattleAxe       = 1 << 2,
    mask_Razorjack       = 1 << 3,
    mask_LegChainsaw     = 1 << 4,
    mask_SBSword         = 1 << 5
}

class BeefEnums : Eventhandler
{
    override void NetworkProcess(ConsoleEvent e)
	{
		if (e.Name ~== "maskEnableAll")
		{
            clearMask();
			CVAR.FindCVar('Slot1Mask').SetInt(-1);
            ApplyConfig();
		}
		else if (e.Name ~== "maskDisableAll")
		{
            clearMask();
			CVAR.FindCVar('Slot1Mask').SetInt(0);
            ApplyConfig();
		}
	}
    void ApplyConfig()
    {
        ApplyBoolCVar("PBSpawnPB_BeamKatana",        Slot1Mask & mask_BeamKatana);
        ApplyBoolCVar("PBSpawnPB_ArgentSith",     Slot1Mask & mask_ArgentSith);
        ApplyBoolCVar("PBSpawnBattleAxe",   Slot1Mask & mask_BattleAxe);
        ApplyBoolCVar("PBSpawnRazorjack",   Slot1Mask & mask_Razorjack);
        ApplyBoolCVar("PBSpawnLegendaryChainsaw",   Slot1Mask & mask_LegChainsaw);
        ApplyBoolCVar("PBSpawnPB_SBSword",   Slot1Mask & mask_SBSword);
    }

    void ApplyBoolCVar(string name, bool enabled)
    {
        let c = CVar.FindCVar(name);
        if (c)
            c.SetBool(enabled);
    }

    void clearMask()
    {
        CVAR.FindCVar('Slot1Mask').SetInt(0);
        ApplyConfig();
    }
}