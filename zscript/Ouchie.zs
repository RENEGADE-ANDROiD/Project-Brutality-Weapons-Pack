class OuchFlashAdjuster : CustomIntCVar
{
    override int ModifyValue(Name CVarName, int val)
    {
		if(val < OuchFlashDuration) 
			return OuchFlashDuration + 1;
		else 
			return val;
    }
}

CLASS OuchieFlashHandler : EventHandler
{
	override void WorldThingDamaged(WorldEvent e)
	{
		if(OuchFlashOnlyMonsters && e.thing.bISMONSTER == false) 
		return;
		if(e.damage < OuchFlashMinDamage) 
		return;
		
		If(OuchFlashDuration > 0 && !(e.thing.FindInventory("OuchieFlash")))
		{
			OuchieFlash ReceivedFlash = OuchieFlash(e.thing.GiveInventoryType("OuchieFlash"));
			If(ReceivedFlash)
			{
				CVAR ColorToUse = CVAR.FindCVar("OuchFlash_"..e.DamageType);
				if(!ColorToUse) ColorToUse = CVAR.FindCVar("OuchFlash_");
				
				//string lmao = ColorToUse.GetString();
				//e.thing.A_Log(e.DamageType);
				//e.thing.A_Log("OuchFlash_"..e.DamageType);
				//e.thing.A_Log(lmao);
				e.thing.SetShade(ColorToUse.GetString());
			}
		}
	}
	override void WorldThingDied(WorldEvent e)
	{
		if(OuchFlashOnlyMonsters && e.thing.bISMONSTER == false) 
		return;

		If(OuchFlashDuration > 0 && !(e.thing.FindInventory("OuchieFlash")))
		{
			OuchieFlash ReceivedFlash = OuchieFlash(e.thing.GiveInventoryType("OuchieFlash"));
			If(ReceivedFlash)
			{
				CVAR ColorToUse = CVAR.FindCVar("OuchFlash_"..e.DamageType);
				if(!ColorToUse) ColorToUse = CVAR.FindCVar("OuchFlash_");
				
				//string lmao = ColorToUse.GetString();
				//e.thing.A_Log(e.DamageType);
				//e.thing.A_Log("OuchFlash_"..e.DamageType);
				//e.thing.A_Log(lmao);
				e.thing.SetShade(ColorToUse.GetString());
			}
		}
	}
}

CLASS OuchieFlash : inventory //powerups get instantly removed from inventory
{
	uint8 OGRenderStyle, FlashDuration, StayInInventory, timer;
	float OGalpha;
	color FlashColor;
	bool DontChange;
	DEFAULT
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		RenderStyle 'none';
		Alpha 0.0;
		+NOCLIP
		+INVISIBLE
		+NOTARGET
		+NEVERTARGET
	}
	
	void RestoreRendering()
	{
		owner.A_SetRenderStyle(OGalpha, OGRenderStyle);
		owner.LightLevel = owner.default.LightLevel;
		owner.bADDLIGHTLEVEL = owner.default.bADDLIGHTLEVEL;
	}
	
	override void AttachToOwner (Actor other)
	{
		super.AttachToOwner(other);
		if(other)
		{
			StayInInventory = OuchFlashCooldown;
			FlashDuration = OuchFlashDuration;
			OGRenderStyle = other.GetRenderStyle();
			OGalpha = other.alpha;
			If(OGRenderStyle == STYLE_None || OGalpha < 0.1 || other.bINVISIBLE)
			{
				Destroy();
			}
			other.A_SetRenderStyle(1.0, OuchFlashSolidColor? STYLE_Stencil : STYLE_Shaded);
			//other.SetShade(FlashColor);
			//owner = other;
			if(OuchFlashBrightness)
			{
				other.bADDLIGHTLEVEL = true;
				other.LightLevel += OuchFlashBrightness;
			}
		}
	}
	
	override void DoEffect()
	{
		if(owner)
		{
			if(++timer >= FlashDuration)
			{
				RestoreRendering();
			}
			if(timer >= StayInInventory)
			{
				Destroy();
			}
		}
	}
}