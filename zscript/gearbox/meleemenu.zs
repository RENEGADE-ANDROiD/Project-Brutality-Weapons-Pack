// Legacy durability/charge checks for melee wheel (must live in gearbox TU — not PBWP ZSCRIPT.zc).
class PBWP_MeleeWheelHelper
{
	static bool HasLegacyUnlock(Actor player, string ownedToken)
	{
		if (!player) return false;

		Name n = Name(ownedToken);
		switch (n)
		{
		case 'PBWP_KatanaMeleeToken':
			return player.CountInv("KatanaDurability") > 0 || player.CountInv("HasDemonicKatana") > 0;
		case 'PBWP_PickAxeMeleeToken':
			return player.CountInv("PickAxeDurability") > 0;
		case 'PBWP_ImpactorMeleeToken':
			return player.CountInv("ImpactorCharges") > 0;
		case 'PBWP_ClawMeleeToken':
			return player.CountInv("ClawCharges") > 0;
		case 'PBWP_SentinelHammerMeleeToken':
			return player.CountInv("SentinelhammerCharges") > 0;
		case 'PBWP_JohnnyHandsMeleeToken':
			return player.CountInv("ExplosiveHandCharges") > 0;
		case 'PBWP_WrenchMeleeToken':
			return player.CountInv("WrenchDurability") > 0;
		case 'PBWP_CrowbarMeleeToken':
			return player.CountInv("CrowbarDurability") > 0;
		case 'PBWP_SledgeHammerMeleeToken':
			return player.CountInv("HammerDurability") > 0;
		case 'PBWP_BatonMeleeToken':
			return player.CountInv("HasShockBaton") > 0;
		case 'PBWP_MacheteMeleeToken':
			return player.CountInv("MacheteDurability") > 0;
		default:
			return false;
		}
	}
}

Class gb_meleemenu
{
	static gb_meleemenu from()
	{
		let nc = new("gb_meleemenu");
		nc.mSelectedIndex = 0;
		nc.Load();	//load its definitions
		return nc;
	}
	
	bool noMelee()
	{
		return tags.size() == 0;
	}
	
	ui bool selectNext()
	{
		int nItems = helditems.size();
		if (nItems == 0) return false;

		mSelectedIndex = (mSelectedIndex + 1) % nItems;

		return true;
	}
	
	ui bool selectPrev()
	{
		int nItems = helditems.size();
		if (nItems == 0) return false;

		mSelectedIndex = (mSelectedIndex - 1 + nItems) % nItems;

		return true;
	}

	ui bool setSelectedIndex(int index)
	{
		if (index == -1 || mSelectedIndex == index) return false;
		
		int nItems = helditems.size();
		if(nItems == 0)
			return false;
		index = clamp(index, 0, nItems - 1);
		
		mSelectedIndex = index;

		return true;
	}
	
	ui int getSelectedIndex() const
	{
		return mSelectedIndex;
	}
	
	string ConfirmSelection() const
	{
		if(helditems.size() > 0)
			return token[helditems[clamp(mSelectedIndex, 0, helditems.size() - 1)]];
		return "";
	}
	
	
	//just in case anything is added in the future, is automatically handled here
	//this will only be called once, when the handler is initialized
	//not sure if this may be too heavy
	private void Load()
	{
		for(int i = 0; i < AllClasses.size(); i++)
		{
			if(AllClasses[i] is "meleeCard")
			{
				let eq = meleeCard(new(AllClasses[i]));
				if(eq)
					eq.InfoFiller(tags,token,ownedtokens,img,scalex,scaley);
			}
		}
	}
	
	ui void fill(out gb_ViewModel viewModel)
	{
		let player = players[consoleplayer].mo;
		helditems.clear();
		for(int i = 0; i < tags.size(); i++)
		{
			if(ownedtokens[i] == "" || player.FindInventory(ownedtokens[i])
				|| PBWP_MeleeWheelHelper.HasLegacyUnlock(player, ownedtokens[i]))
			{
				int filteredIdx = helditems.size();
				viewModel.tags        .push(tags[i]);
				viewModel.slots       .push(filteredIdx + 1);
				viewModel.indices     .push(filteredIdx);
				viewModel.icons       .push(texman.checkfortexture(img[i]));
				viewModel.iconScaleXs .push(scalex[i]);
				viewModel.iconScaleYs .push(scaley[i]);
				viewModel.quantity1   .push(-1);
				viewModel.maxQuantity1.push(-1);
				viewModel.quantity2   .push(-1);
				viewModel.maxQuantity2.push(-1);
				helditems.push(i);
			}
		}
		
		if(helditems.size() > 0)
			viewModel.selectedIndex = clamp(mSelectedIndex, 0, helditems.size() - 1);
		else
			viewModel.selectedIndex = 0;
	}
	
	array <int>    helditems;
	array <string> tags;
	array <string> token;
	array <string> ownedtokens;
	array <string> img;
	array <double> scalex;
	array <double> scaley;
	private int mSelectedIndex;
}
