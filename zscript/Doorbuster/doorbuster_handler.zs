Class BusterHandler : eventhandler
{
	int doorwait;
	const fullsec = 35;
	override void NetworkProcess(ConsoleEvent e)
	{
		let pm = players[e.Player].mo;
		if(!pm)
			return;
		
		if (e.Name ~== "TryBustDoor")
		{
			//bool cantry = (onlyonberserk && pm.findinventory("PowerStrength",true)) || !onlyonberserk;
			bool enoughammo = (pm.countinv("BusterAmmo") > 0) || infinitecharges;
			if(!enoughammo)
			{
				if(!nologs)
					console.printf("Not enough buster charges");
				return;
			}
			if(!doorwait)
			{
				//pm.A_Startsound("weapons/pbarm",18);
				int lk = The_DoorBuster.LB_CheckKey;
				if(ignoreLocks)
					lk = The_DoorBuster.LB_All;
				bool destroyedDoor = The_DoorBuster.DestroyDoor(pm, breakLocks: lk);
				doorwait = fullsec;
				if(destroyedDoor && !infinitecharges)
						pm.A_takeinventory("BusterAmmo",1);
				if(!nologs && !infinitecharges)
					console.printf("buster charges left: \cg"..pm.countinv("BusterAmmo").."\c-");
			}
		}
	}
	
	override void worldtick()
	{
		if(doorwait > 0)
			doorwait--;
	}
	
	override void worldloaded(worldevent e)
	{
		//randomly spawn busterammo in secret sectors 
		for(int i = 0; i < level.sectors.size(); i++)
		{
			if(level.sectors[i].issecret())
			{
				if(random(0,99) > busterAmmoChance)
					continue;
				//console.printf("attempting to spawn: "..i);
				let center = level.sectors[i].centerspot;
				if(level.ispointinlevel((center.x,center.y,level.sectors[i].floorplane.zAtPoint(center))))
				{
					actor.spawn("BusterAmmo",(center.x,center.y,level.sectors[i].floorplane.zAtPoint(center)));
					//console.printf("spawned ammo at: "..(center.x,center.y,level.sectors[i].floorplane.zAtPoint(center)));
				}
			}
		}
		
	}
	
}

Class BusterAmmo : inventory
{
	default
	{
		inventory.maxamount 10;
		inventory.amount 1;
		inventory.icon "XCR9A0";
		inventory.pickupsound "misc/rocket_PickUp";
		inventory.pickupmessage "Got a door buster charge";
		//+inventory.INVBAR;
	}
	states
	{
		spawn:
			XCR9 A -1;
			stop;
	}
}