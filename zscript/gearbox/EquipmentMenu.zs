class PBWP_EquipmentWheelHelper
{
	static bool HasLegacyUnlock(Actor player, string ownedToken, string relAmmo)
	{
		if (!player)
			return false;
		if (relAmmo != "" && player.CountInv(relAmmo) > 0)
			return true;
		if (ownedToken == "PB_LeechToken" && player.CountInv("HasLeech") > 0)
			return true;
		return false;
	}
}

Class gb_equipmentmenu
{
	static gb_equipmentmenu from()
	{
		let nc = new("gb_equipmentmenu");
		nc.mSelectedIndex = 0;
		nc.Load();	//load its definitions
		return nc;
	}
	
	bool noequipments()
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
	
	bool setSelectedIndexFromView(gb_ViewModel viewModel, int index)
	{
		if (index == -1 || mSelectedIndex == viewModel.indices[index]) return false;

		mSelectedIndex = viewModel.indices[index];
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
		let inf = new("pbCardInfoHolder");
		for(int i = 0; i < AllClasses.size(); i++)
		{
			//filter em all
			if(AllClasses[i] is "equipmentCard" && !allclasses[i].IsAbstract())
			{
				let eq = equipmentCard(new(AllClasses[i]));
				if(eq)
				{
					if(eq.getdestslot() != -1)
						inf.push(eq, eq.getdestslot(), eq.getpriority());
				}
			}
		}
		
		//sort those mf
		sortEquipments(inf);
		
		//finally add them to the actual arrays
		for(int i = 0; i < inf.getsize(); i++)
		{
			inf.clss[i].InfoFiller(tags,token,ownedtokens,img,scalex,scaley,slots,relAmmo);
		}
	}
	
	ui void fill(out gb_ViewModel viewModel)
	{
		let player = players[consoleplayer].mo;
		helditems.clear();
		for(int i = 0; i < tags.size(); i++)
		{
			if(ownedtokens[i] == "" || player.FindInventory(ownedtokens[i])
				|| PBWP_EquipmentWheelHelper.HasLegacyUnlock(player, ownedtokens[i], relAmmo[i]))
			{
				int filteredIdx = helditems.size();
				viewModel.tags        .push(tags[i]);
				viewModel.slots       .push(slots[i]);
				viewModel.indices     .push(filteredIdx);
				viewModel.icons       .push(texman.checkfortexture(img[i]));
				viewModel.iconScaleXs .push(scalex[i]);
				viewModel.iconScaleYs .push(scaley[i]);
				if(relAmmo[i] != "")
				{
					let item = player.findinventory(relAmmo[i]);
					if(item)
					{
						viewModel.quantity2   .push(item.amount);
						viewModel.maxQuantity2.push(item.maxamount);
					}
					else
					{
						viewModel.quantity2   .push(0);
						viewModel.maxQuantity2.push(1);
					}
				}
				else
				{
					viewModel.quantity2   .push(-1);
					viewModel.maxQuantity2.push(-1);
				}
				viewModel.quantity1   .push(-1);
				viewModel.maxQuantity1.push(-1);
				helditems.push(i);
			}
		}
		
		if(helditems.size() > 0)
			viewModel.selectedIndex = clamp(mSelectedIndex, 0, helditems.size() - 1);
		else
			viewModel.selectedIndex = 0;
	}
	
	
	

	
	private static
	void sortEquipments(pbCardInfoHolder info)
	{
		int nWeapons = info.clss.size();
		quickSortEquipments(info, 0, nWeapons - 1);
	}

	private static
	void quickSortEquipments(pbCardInfoHolder info, int lo, int hi)
	{
		if (lo < hi)
		{
		  int p = quickSortEquipPartition(info, lo, hi);
		  quickSortEquipments(info, lo,    p - 1);
		  quickSortEquipments(info, p + 1, hi   );
		}
	}

	private static
	int quickSortEquipPartition(pbCardInfoHolder info, int lo, int hi)
	{
		int pivot = measure(info, hi);
		int i     = lo - 1;

		for (int j = lo; j <= hi - 1; ++j)
		{
		  if (measure(info, j) <= pivot)
		  {
			++i;
			info.swap(i, j);
		  }
		}
		info.swap(i + 1, hi);

		return i + 1;
	}

	private static
	int measure(pbCardInfoHolder info, int index)
	{
		int slot = info.slots[index];
		if (slot == 0) slot = 99;

		int result = slot * 100 + info.priorities[index];
		return result;
	}
	
	array <int>    helditems;
	array <string> tags;
	array <string> token;
	array <string> ownedtokens;
	array <string> img;
	array <double> scalex;
	array <double> scaley;
	array <int>	   slots;
	array <string> relAmmo;
	private int mSelectedIndex;
}



Class pbCardInfoHolder
{
	array<int> 				slots;
	array<double>			priorities;
	array<equipmentcard> 	clss;
	
	int getsize()
	{
		return slots.size();
	}
	
	void push(equipmentcard aClass, int slot, double priority)
	{
		clss   .push(aClass);
		slots     .push(slot);
		priorities.push(priority);
	}

	void swap(int i, int j)
	{
		{
			let tmp = clss[i];
			clss[i] = clss[j];
			clss[j] = tmp;
		}
		{
			int tmp  = slots[i];
			slots[i] = slots[j];
			slots[j] = tmp;
		}
		{
			int tmp = priorities[i];
			priorities[i] = priorities[j];
			priorities[j] = tmp;
		}
				
	}
}
