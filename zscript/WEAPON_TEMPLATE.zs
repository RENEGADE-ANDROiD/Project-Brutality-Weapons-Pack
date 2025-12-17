// THIS IS A TEMPLATE ONLY FOR REFERENCE
// Big Thanks to Jaih1r0 for making this

Class PB_AddonWeapon : PB_WeaponBase
{
	default
	{
		weapon.slotnumber 0;
		Tag "My Weapon Addon :D";
		inventory.pickupsound "";
		inventory.pickupmessage "got a weapon!";
		
		//weapon.ammotype1 ""; this is the reserve ammo
		
		//weapon.ammogive1 1; needed to be able to get ammo from weapon drops
		
		//weapon.ammotype2 ""; this is the main ammo that is loaded in the weapon
		
		//PB_WeaponBase.unloadertoken "MyWeaponUnloaded"; token that indicates if this specific weapon is unloaded, example of the token defined below this class
		
		//PB_WeaponBase.respectItem "MyWeaponRespect"; token needed for the respect to work, in case your weapon has a respect animation, example of the token defined below this class
		
		//Inventory.AltHUDIcon "TNT1A0"; this is not exactly needed
	}
	
	states
	{
		Spawn:
			TNT1 A -1;
			stop;
			
		Steady:
			TNT1 A 1;
			Goto Ready;
			
		Select:
			TNT1 A 0 A_weaponoffset(0,32); //this way you dont need A_Raise()
			goto SelectFirstPersonLegs; //this is needed for the legs overlay to work
		
		//the 'SelectFirstPersonLegs' state jumps to this state here to continue the select animation
		SelectContinue:
			//this function sets the weapon token, here you give the more similar token to your weapon
			//like, if id do a 16 barrels shotgun, id give it the ssg token
			//this is needed for some monsters death animations to work, check out the function from weaponfunctions.zs in pb
			TNT1 A 0 PB_WeapTokenSwitch("SSGSelected");
			//TNT1 A 0 PB_RespectIfNeeded(); this is needed if you have a respect animation
		SelectAnimation:
			TNT1 A 0 A_zoomfactor(1.0);
			TNT1 A 0 A_setroll(0);
			//TNT1 A 0 A_startsound("SomeSound",20); the select sound if any
			TNT1 ABCD 1; //the real select animation
			goto Ready3;
			
		Deselect:
			//TNT1 A 0 A_startsound("Somesound",20); deselect sound if any
			TNT1 DCBA 1; //deselect animation
			TNT1 A 0 A_Lower(120); //this lowers the weapon instantly
			wait; //wait, so it repeats the previous frame (the TNT1 with A_lower() one) until the next weapon is raising
			
			
		//this is for the respect animation, if any.
		//WeaponRespect:
		//	TNT1 A 1 A_DoPBWeaponAction(); dont forget to add A_DoPBWeaponAction() so you can cancel this animation in game
		//	goto ready3;
		
		
		//the pb weapons usually dont use the ready state as a ready state, but more as a transition state to set tokens, start sounds, etc
		//another states like ReadyToFire state are usually used as a main ready state
		Ready:
		Ready3:
			TNT1 A 1 A_DoPBWeaponAction(); //this is the A_Weaponready() equivalent for pb weapons
			loop;
			
		///////////////////////////////////////////////////////////////
		//	The Fire/Altfire states
		//	its up to you how you handle it
		//
		//	if you want to implement alternative fire states, i recommend you to create vars:
		//	like for example, if you want to do a secondary mode
		//	define this var outside of any block(default or states) but inside of the weapon	
		//	/*	Bool SecondaryFire;	*/
		//	and for it to work, you need to check it with the invoker. prefix
		//	something like this
		//
		//		Fire:
		//		TNT1 A 0 A_jumpif(invoker.SecondaryFire,"Someotherattack");
		//		...continue with the normal attack
		//
		//	this way you dont get drowned by inventory tokens
		//
		//	also, this is useful when you want to do more alternative attacks, think of the super grenade launcher
		//	so instead of defining a lot of tokens named USING_FIREMODE, USING_ACIDMODE, USING... etc
		//	you can just use an int var, and with constants or enums (basically, giving fancy names to numbers), you get something more solid and easy to expand
		//	like this
		//
		//		//this int var holds the actual mode youre using
		//		int specialmode; //by default it starts in 0, so take it in account
		//
		//		enum Weapon_Specialmodes {
		//			SP_Mode1 = 1,SP_Mode2 = 2,	...	SP_Mode321 = 321
		//		};
		//	and handle it with a switch state instead of a lot of A_jumpifinventory()
		//	like this:
		//		switch(specialmode)
		//		{
		//			case 1: do this, and this, etc; Break;
		//			case 2: do this other thing, and this, etc; Break;
		//		}
		//
		//
		//	Also, dont forget to check the BaseWeapon_Functions.zsc lump inside of PB
		//	to learn more of the available functions, like the reload ones like the one mentioned in the reload state below, recoil ones like PB_WeaponRecoil() 
		//	the casings spawn one (PB_SpawnCasing()),or the projectile spawn ones like PB_FireBullets()
		//
		///////////////////////////////////////////////////////////////
		
		Fire:
			//TNT1 A 0 A_jumpif(countinv(invoker.ammotype2)<1,"Reload"); suggestion for ammo checking
			TNT1 A 1;
			TNT1 A 0 A_refire();
			goto ready;
			
		AltFire:
			TNT1 A 1;
			TNT1 A 0 A_refire();
			goto ready;
		
		//weapon special state
		Weaponspecial:
			TNT1 A 0 A_takeinventory("GoWeaponSpecialAbility",1); //you need to take this token to not be trapped in a non ending loop
			goto ready3;
		
		//unloading, dont forget to take the unloading token here and in the reload state
		//or you'll be in a infinite loop of going to unload
		//this also has its own function PB_UnloadMag()
		Unload:
			TNT1 A 0 A_Takeinventory("Unloading",1);
			//TNT1 A 0 A_takeinventory(invoker.UnloaderToken,1);
			goto ready3;
			
			
		//note: Pb has a function to do the reload, instead of using the Insert_Bullets State
		//you can use PB_AmmoIntoMag(secondary ammo,primary ammo, full ammo quantity, equivalence between primary and secondary ammo);
		Reload:
			//suggestions for ammo checking, id recommend doing an state for when full or no ammo, specially if the idle state is animated
			//so it doesnt just stop when pressing reload, like the railgun
			//TNT1 A 0 A_jumpif(countinv(invoker.ammotype1) < equivalence of ammo,No Ammo state);
			//TNT1 A 0 A_jumpif(countinv(invoker.ammotype2) > Full mag,Full ammo state);
			TNT1 A 1;
			goto ready3;
		
		
		////////////////////////////////////////////////////////////
		//flashing states, needed for the kicks and quick melee to work
		////////////////////////////////////////////////////////////
		
		//for quick melee
		FlashPunching:
			TNT1 AAAAAAAAAAAAAA 1; //14 frames
			stop;
		
		//for kicking
		FlashKicking:
			TNT1 AAAAAAAAAAAAAAA 0; //15 frames
			goto ready3;
			
		FlashAirKicking:
			TNT1 AAAAAAAAAAAAAAAA 1; //16 frames
			goto ready3;
			
		FlashSlideKicking:
			TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 1; //27 frames
			goto ready3;
			
		FlashSlideKickingStop:
			TNT1 AAAAAAA 1; //7 frames 
			goto ready3;
		
		
		//only needed if you are going to change sprites thru the sprite field
		// like: 
		//	let psp = findPSprite(somelayer); //usually PSP_WEAPON
		//	if(psp)
		//		psp.sprite = GetSpriteIndex("somesprite");
		
		LoadSprites:
			TNT1 A 0;
			TNT2 A 0;
			stop;
		
	}
	
	/*
	
	i did this two custom functions to not copypaste every time the 
	A_Jumpifinventory(SomeBarrel,1,thestatethatthrowsthebarrel) spam
	you can use these, just put the first in the beggining of the fire state
	and the second on the beggining of the altfire state
	
	Action State PB_CheckBarrelThrow1()
	{
		//if owner doesnt have berserk wont throw it, so do the barrel place check instead
		if(countinv("PB_powerstrength")<1)
			return PB_CheckBarrelPlace1();
		
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("ThrowBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("ThrowFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("ThrowIceBarrel");
		//no barrel
		return resolvestate(null);
	}
	
	Action State PB_CheckBarrelPlace1()
	{
		//got nukage barrel
		if(countinv("GrabbedBarrel")>0)
			return resolvestate("PlaceBarrel");
		//got flame barrel
		if(countinv("GrabbedFlameBarrel")>0)
			return resolvestate("PlaceFlameBarrel");
		//got ice barrel
		if(countinv("GrabbedIceBarrel")>0)
			return resolvestate("PlaceIceBarrel");
		//no barrel
		return resolvestate(null);
	}*/
	
	

}

/*
Class MyWeaponRespect : inventory
{
	default
	{
		inventory.maxamount 1;
	}
}
*/

/*
Class MyWeaponUnloaded:inventory
{
	default
	{
		inventory.maxamount 1;
	}
}
*/