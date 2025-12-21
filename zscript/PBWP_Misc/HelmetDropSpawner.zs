class HelmetDropHandler : EventHandler
{
	static const String specialActors[] = { 
		"pb_pyrosergeant",
		"pb_qsgzombie",
		"pb_pistolzombieman2"
	};
	
	bool hasString(String s, String pattern, int start=0){
		String s_lowered = s.MakeLower();
		String p_lowered = pattern.MakeLower();
		int i = start;
		for(i = start; i < s.Length() - (pattern.Length() - 1); i++)
		{
			String temp = s_lowered.Mid(i, pattern.Length());
			//Console.Printf("Comparing: %s - %s", temp, pattern);
			if(temp == pattern) return true;
		}
		return false;
	}
	
	bool stringStartsWith(String s, String pattern){
		String s_lowered = s.MakeLower();
		String p_lowered = pattern.MakeLower();
		return s_lowered.Left(p_lowered.Length()) == p_lowered;
	}
	
	override void WorldThingDied(WorldEvent e)
	{
		if (!e || !e.thing) return;
		let actor = e.thing;
		
		String targetStr	= "helmet";
		String actorAlias	= "pb_";
		String thingClass	=  actor.GetClassName();
		thingClass			= thingClass.MakeLower();
		
		bool isSpecial = false;
		for(int i = 0; i < specialActors.Size(); i++){
			if(specialActors[i] == thingClass){
				isSpecial = true;
				break;
			}
		}
		if (!stringStartsWith(thingClass, actorAlias) && !isSpecial) return;
		bool hasHelmet = isSpecial;
		hasHelmet = hasHelmet || hasString(thingClass, targetStr, actorAlias.Length());
		
		if ( hasHelmet )
		{
			vector3 pos = actor.pos;
			double xvel = random(-8, 8);
			double yvel = random(-8, 8);
			double zvel = random(5, 10);
			let helm = Actor.Spawn ( 
				"PB_DroppedHelmet", 
				(pos.X, pos.Y, pos.Z + actor.Default.Height * 0.9)
			);
			if( !helm ) return;
			
			helm.angle = random(0, 359);
			helm.vel = (xvel, yvel, zvel);
			if(hasString(thingClass, "commando") || hasString(thingClass, "commando")){
				helm.A_SetTranslation("CommandoHelm");
			}
		}

		// and if none of the conditions above were met, simply nothing will happen
	}
}