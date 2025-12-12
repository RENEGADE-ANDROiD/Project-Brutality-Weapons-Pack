Class gb_equipmentmenu
{
	static gb_equipmentmenu from()
	{
		let nc = new("gb_equipmentmenu");
		nc.mSelectedIndex = 0;
		nc.Load();	//load its definitions
		return nc;
	}
	
	//this shouldnt be needed, but anyways
	bool noequipments()
	{
		return getEquipmentNumber() == 0;
	}
	
	int getEquipmentNumber()
	{	
		return tags.size();
	}
	
	ui bool selectNext()
	{
		int nItems = getEquipmentNumber();
		if (nItems == 0) return false;

		mSelectedIndex = (mSelectedIndex + 1) % nItems;

		return true;
	}
	
	ui bool selectPrev()
	{
		int nItems = getEquipmentNumber();
		if (nItems == 0) return false;

		mSelectedIndex = (mSelectedIndex - 1 + nItems) % nItems;

		return true;
	}

	ui bool setSelectedIndex(int index)
	{
		if (index == -1 || mSelectedIndex == index) return false;
		
		int nItems = getEquipmentNumber();
		if(nItems == 0)
			return false;
		index = clamp(index,0,nItems);
		
		
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
		if(token.size() > 0)
			return token[clamp(mSelectedIndex,0,token.size() - 1)];
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
			inf.clss[i].InfoFiller(tags,token,img,scalex,scaley,slots,relAmmo);
		}
	}
	
	ui void fill(out gb_ViewModel viewModel)
	{
		for(int i = 0; i < tags.size(); i++)
		{
			viewModel.tags        .push(tags[i]);
			viewModel.slots       .push(slots[i]);
			viewModel.indices     .push(i);
			viewModel.icons       .push(texman.checkfortexture(img[i]));
			viewModel.iconScaleXs .push(scalex[i]);
			viewModel.iconScaleYs .push(scaley[i]);
			if(relAmmo[i] != "") //account for ammo
			{
				let item = players[consoleplayer].mo.findinventory(relAmmo[i]);
				if(item)
				{
					viewModel.quantity2   .push(item.amount);
					viewModel.maxQuantity2.push(item.maxamount);
				}
				else
				{
					viewModel.quantity2   .push(0);		//
					viewModel.maxQuantity2.push(1);		//
				}
			}
			else
			{
				viewModel.quantity2   .push(-1);		//no ammount for you >:(
				viewModel.maxQuantity2.push(-1);		//
			}
			viewModel.quantity1   .push(-1);		//
			viewModel.maxQuantity1.push(-1);		//
		}
		
		viewModel.selectedIndex = clamp(mSelectedIndex,0,tags.size()-1);	//without this, blocks/text wont work
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
	
	array <string> tags;
	array <string> token;
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
