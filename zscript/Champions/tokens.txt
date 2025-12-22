class champion_Token : Inventory
	{
	bool legend;
	bool changed;
	bool secondary;
	int legendTime;
	
	default
		{
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		inventory.MaxAmount 2;
		}
 	override void AttachToOwner(actor Other)
		{
		super.AttachToOwner(other);
		
		let hand = champion_Handler(EventHandler.Find("champion_Handler"));
		
		if(hand)
			{
			if(hand.Legend)
				{
				legend = true;
				legendTime = level.MapTime + 3;
				return;
				}
			}
	
 		if(!secondary && !legend)
			owner.CopyBloodColor(self); 
		} 
	override void DoEffect()
		{
		if(changed) 
			return;
			
		if(legend)
			{
			name token2 = 'LDLegendaryMonsterTransformed';
			if(owner.FindInventory(token2))
				{
				if(!secondary)
					{
					owner.CopyBloodColor(self);
					legend = false;
					changed = true;
					}
				}
			}
		else
			{
			if(!secondary)
				{
				owner.CopyBloodColor(self);
				changed = true;
				}
			}
		}
	}
class champion_Token2 : Inventory
	{
	default
		{
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		}
	}	
	
// Champ Tokens
class champion_DarkRedToken 	: champion_Token { default { bloodColor "660000"; } } 
class champion_RedToken			: champion_Token { default { bloodColor "cc0000"; } } 
class champion_OrangeToken		: champion_Token { default { bloodColor "FFCA4E"; } } 
class champion_YellowToken		: champion_Token { default { bloodColor "ECD200"; } } 
class champion_DarkGreenToken 	: champion_Token { default { bloodColor "006600"; } } 
class champion_GreenToken		: champion_Token { default { bloodColor "00e600"; } } 
class champion_CyanToken		: champion_Token { default { bloodColor "C6D8FF"; } } 
class champion_BlueToken		: champion_Token { default { bloodColor "4A4ABF"; } } 
class champion_IndigoToken 		: champion_Token { default { bloodColor "7E67BF"; } } 
class champion_VioletToken 		: champion_Token { default { bloodColor "800080"; } } 
class champion_PinkToken		: champion_Token { default { bloodColor "FF939F"; } } 
class champion_MagentaToken		: champion_Token { default { bloodColor "ff00ff"; } } 
class champion_BlackToken		: champion_Token { default { bloodColor "1a1a1a"; } } 
class champion_GreyToken		: champion_Token { default { bloodColor "8c8c8c"; } } 
class champion_WhiteToken		: champion_Token { default { bloodColor "f2f2f2"; } } 
class champion_BronzeToken		: champion_Token { default { bloodColor "c19971"; } } 
class champion_SilverToken		: champion_Token { default { bloodColor "eff4f5"; } } 
class champion_GoldToken		: champion_Token { default { bloodColor "e6b800"; } } 

// Mutation Tokens
class champion_TitanToken		: champion_Token2 { }
class champion_UndyingToken		: champion_Token2 { }
class champion_GhostToken		: champion_Token2 { }
class champion_BalloonToken		: champion_Token2 { }