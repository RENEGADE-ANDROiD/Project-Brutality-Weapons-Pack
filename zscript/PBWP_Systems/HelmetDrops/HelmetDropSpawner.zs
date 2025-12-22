// Nov 9, 2025: Yes this has notes everywhere now
// 				and also shortened greatly because I forgot common sense exists

// class ClassName : EventHandler
// uses WorldThingDied so it fires every time an actor dies, yes even projectiles

class HelmetDropHandler : EventHandler
	{
	static const String specialActors[] = { 
		"pb_pyrosergeant", 
		"pb_qsgzombie", 
		"pb_pistolzombieman2", 

		// GK Variantes
		"pb_pyrosergeantgk",
		"pb_qsgzombiegk",
		"pb_pistolzombieman2gk",

		// PM Monster
		"pm_slugshotgunnergk",
		"pm_slugshotgunner",
		"pm_zombiemarinegk",
		"pm_zombiemarine",
		"pm_zombietroopergk",
		"pm_zombietrooper"
	};
	
	// This is the function that finds a pattern in a string with no case sensitivity
	bool hasString( String s, String pattern ){
		if ( s.Length() < pattern.Length() )
		{ // if the string is shorter than the pattern, false
			return false;
		}
		else
		{
			// tries to find the index of the lowered pattern in the lowered string
			// if not -1 (no matches) then true, false otherwise
			return s.IndexOf(pattern) != -1;
		}
		
		return false; // Placeholder
	}
	
	bool stringStartsWith(String s, String pattern){
		// Counting from the left of the string, if it matches the pattern then true
		return s.Left(pattern.Length()) == pattern;
	}
	
	override void WorldThingDied(WorldEvent e)
	{
		if (!e || !e.thing) return;
		if (!HelmetDropCVAR) return;
		// in this case "thing" is the actor that died
		let actor = e.thing;
		
		// if the actor isn't a monster, stop
		if ( !actor.bISMONSTER ) return;
		
		// Specifies the pattern
		String targetStr	= "helmet";
		
		// Specifies the alias/prefix
		String actorAlias	= "pb_";
		
		// Gets actor's class name
		String thingClass	= actor.GetClassName();
		thingClass			= thingClass.MakeLower();
		// then lowers it for non case sensitive checks
		
		bool isSpecial = false;
		for ( int i = 0; i < specialActors.Size(); i++ )
		{
			if(specialActors[i] == thingClass){
				isSpecial = true;
				break;
			}
		}
		
		// If it's not a special case [and] their name didn't start with the specified alias, stop
		if (!isSpecial && !stringStartsWith( thingClass, actorAlias )) return;
		
		bool hasHelmet = isSpecial; // Special case
		hasHelmet = hasHelmet || hasString( thingClass, targetStr );
		// [or] if it has the pattern string in its name
		
		// If none of the conditions above were met, stop
		if ( !hasHelmet ) return;
		
		// Gets actor's position
		vector3 pos = actor.pos;
		
		// Left - Right velocity
		double xvel = random(-8, 8); 
		
		// Back - Forth velocity
		double yvel = random(-8, 8);
		
		// Up - Down velocity
		double zvel = random(5, 10); 
		
		// Using "let" to define helm as the spawned helmet
		let helm = Actor.Spawn ( 
			"PB_DroppedHelmet", // actor name
			(pos.X, pos.Y, pos.Z + actor.Default.Height * 0.9) // vector3
			// ( x, y, z + 90% of actor;s height )
		);
		
		// If it failed to spawn, stop
		if ( !helm ) return;
		
		// randomize the helmet's angle
		helm.angle = random(0, 359);
		
		// sets velocity
		helm.vel = (xvel, yvel, zvel); // again, a vector3
		
		// (Optional) Addition, colors the helmet RED if it was a Commando that died
		if ( hasString(thingClass, "commando") || hasString(thingClass, "chaingun") )
		{
			helm.A_SetTranslation("CommandoHelm");
		}

	}
}