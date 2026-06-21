// Syncs pack-preset On/Off menu CVARs to netevent weapon-spawn batches.
class PBWP_PackPresetPoll : StaticEventHandler
{
	transient ui bool initialized;
	transient ui bool lastAll;
	transient ui bool lastGodComplex;
	transient ui bool lastKarnage;
	transient ui bool lastIN;
	transient ui bool lastDTECH;
	transient ui bool lastSCHISM;
	transient ui bool lastRO;
	transient ui bool lastD2016;
	transient ui bool lastDuke;
	transient ui bool lastPB30;
	transient ui bool lastVietDoom;
	transient ui bool lastCyberaugumented;
	transient ui bool lastFreezer;

	ui static PBWP_PackPresetPoll Get()
	{
		return PBWP_PackPresetPoll(EventHandler.Find("PBWP_PackPresetPoll"));
	}

	ui static bool ReadBool(Name cvarName)
	{
		let c = CVar.FindCVar(cvarName);
		return c ? c.GetBool() : false;
	}

	ui void Reset()
	{
		initialized = false;
	}

	ui void PollOne(Name cvarName, Name onEvent, Name offEvent, out bool last)
	{
		bool now = ReadBool(cvarName);
		if (now == last)
			return;
		last = now;
		EventHandler.SendNetworkEvent(now ? onEvent : offEvent);
	}

	ui void Poll()
	{
		if (!initialized)
		{
			lastAll = ReadBool('PBWP_Pack_All');
			lastGodComplex = ReadBool('PBWP_Pack_GodComplex');
			lastKarnage = ReadBool('PBWP_Pack_Karnage');
			lastIN = ReadBool('PBWP_Pack_IN');
			lastDTECH = ReadBool('PBWP_Pack_DTECH');
			lastSCHISM = ReadBool('PBWP_Pack_SCHISM');
			lastRO = ReadBool('PBWP_Pack_RO');
			lastD2016 = ReadBool('PBWP_Pack_D2016');
			lastDuke = ReadBool('PBWP_Pack_Duke');
			lastPB30 = ReadBool('PBWP_Pack_PB30');
			lastVietDoom = ReadBool('PBWP_Pack_VietDoom');
			lastCyberaugumented = ReadBool('PBWP_Pack_Cyberaugumented');
			lastFreezer = ReadBool('PBWP_Pack_Freezer');
			initialized = true;
			return;
		}

		PollOne('PBWP_Pack_All', 'PBWP_EnableAll', 'PBWP_DisableAll', lastAll);
		PollOne('PBWP_Pack_GodComplex', 'PBWP_EnableGodComplex', 'PBWP_DisableGodComplex', lastGodComplex);
		PollOne('PBWP_Pack_Karnage', 'PBWP_EnableKarnage', 'PBWP_DisableKarnage', lastKarnage);
		PollOne('PBWP_Pack_IN', 'PBWP_EnableIN', 'PBWP_DisableIN', lastIN);
		PollOne('PBWP_Pack_DTECH', 'PBWP_EnableDTECH', 'PBWP_DisableDTECH', lastDTECH);
		PollOne('PBWP_Pack_SCHISM', 'PBWP_EnableSCHISM', 'PBWP_DisableSCHISM', lastSCHISM);
		PollOne('PBWP_Pack_RO', 'PBWP_EnableRO', 'PBWP_DisableRO', lastRO);
		PollOne('PBWP_Pack_D2016', 'PBWP_EnableD2016', 'PBWP_DisableD2016', lastD2016);
		PollOne('PBWP_Pack_Duke', 'PBWP_EnableDuke', 'PBWP_DisableDuke', lastDuke);
		PollOne('PBWP_Pack_PB30', 'PBWP_EnablePB30', 'PBWP_DisablePB30', lastPB30);
		PollOne('PBWP_Pack_VietDoom', 'PBWP_EnableVietDoom', 'PBWP_DisableVietDoom', lastVietDoom);
		PollOne('PBWP_Pack_Cyberaugumented', 'PBWP_EnableCyberaugumented', 'PBWP_DisableCyberaugumented', lastCyberaugumented);
		PollOne('PBWP_Pack_Freezer', 'PBWP_EnableFreezer', 'PBWP_DisableFreezer', lastFreezer);
	}
}
