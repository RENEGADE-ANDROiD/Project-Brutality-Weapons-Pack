class FractalDoom_Game : EventHandler
{
	const CHILDS_TO_SPAWN = 2;
	const MAX_CHILDS_ITERATIONS = 4;
	const MAX_MONSTERS_CLASSES = 128;
	const FRACTAL_SCALE_MULT = 0.75;
	const FRACTAL_DAMAGE_MULT = 0.6;
	const FRACTAL_HEALTH_MULT = 0.5;
	const MAX_SPAWNOFFSET = 20.0; //This is the absolute limit
	const FRACTAL_CHANCE = 0.05; // 10% chance for fractal splitting
	
	int monsters_readed;
	name monster_classes_names[MAX_MONSTERS_CLASSES];
	vector2 monster_org_scale[MAX_MONSTERS_CLASSES];
	double monster_spawnoffset[MAX_MONSTERS_CLASSES][MAX_MONSTERS_CLASSES]; //Strange bug with bidimensional arrays, it is forcing me to make squared bidimensional arrays to work...
	bool   monster_able_to_spawn[MAX_MONSTERS_CLASSES][MAX_MONSTERS_CLASSES];
	
	int get_monster_class_id(Actor monster) {
		name monster_class_name = monster.GetClassName();
		for (int i=0; i < monsters_readed; i++) {
			if (monster_classes_names[i] == monster_class_name) {
				return i;
			}
		}
		return -1;
	}
	
	int get_monster_child_number(int monster_class_id, actor current_monster) {
		vector2 dynamic_scale = monster_org_scale[monster_class_id];
		int child_number=0;
		while(current_monster.scale.x < (dynamic_scale.x-0.025) && current_monster.scale.y < (dynamic_scale.y-0.025)) {
			dynamic_scale.x*=FRACTAL_SCALE_MULT;
			dynamic_scale.y*=FRACTAL_SCALE_MULT;
			child_number+=1;
			if (child_number >= (MAX_CHILDS_ITERATIONS-1))
				break;
		}
		return child_number;
	}
	
	int add_new_monster_class_data(Actor monster) {
		name monster_class_name = monster.GetClassName();		
		monster_classes_names[monsters_readed] = monster_class_name;
		monster_org_scale[monsters_readed] = monster.scale;
		for (int i=0; i < MAX_CHILDS_ITERATIONS; i++) {
			monster_spawnoffset[monsters_readed][i] = 5.0;
			monster_able_to_spawn[monsters_readed][i] = false;
		}
		monsters_readed+=1;
		return monsters_readed-1;
	}

	vector2 get_relative_scale(int monster_class_id, actor current_monster) {
		vector2 default_scale = monster_org_scale[monster_class_id];
		
		vector2 relative_scale;
		if (default_scale.x > 0.0) {
			relative_scale.x = current_monster.scale.x/default_scale.x;
		} else {
			relative_scale.x = 1.0;
		}
		if (default_scale.y > 0.0) {
			relative_scale.y = current_monster.scale.y/default_scale.y;
		} else {
			relative_scale.y = 1.0;
		}
		return relative_scale;
	}
	
	Actor getClosestPlayerToActor(Actor monster) {
		double playerDist = 99999999.0;
		actor playerReturn = null;
		for (int i=0; i < 8; i++) {
			let player_actor = players[i].mo;
			if (player_actor && !(player_actor.player.cheats & CF_NOCLIP2)) {
				double tmp_dist = monster.Distance3DSquared(player_actor);
				if (playerDist > tmp_dist) {
					playerDist = tmp_dist;
					playerReturn = player_actor;
				}
			}
		}
		return playerReturn;
	}
	
	override void WorldThingSpawned(WorldEvent e) {
		if (!e.Thing.bMISSILE || !e.Thing.target || !e.Thing.target.bISMONSTER)
			return;
		Actor owner_actor = e.Thing.target;
		int owner_class_id = get_monster_class_id(owner_actor);
		
		if (owner_class_id == -1) {
			owner_class_id = add_new_monster_class_data(owner_actor); 
		}
		
		vector2 relative_scale = get_relative_scale(owner_class_id, owner_actor);
		vector3 missile_delta = e.Thing.pos - owner_actor.pos;
		vector3 missile_displacement = (0, 0, 0);
		bool isProjectilFromChild = false;
		double fractal_max_scale = FRACTAL_SCALE_MULT;
		while(relative_scale.x < (fractal_max_scale+0.05) && relative_scale.y < (fractal_max_scale+0.05)) {
			e.Thing.scale.x *= 0.65;
			e.Thing.scale.y *= 0.65;
			missile_displacement += (missile_delta-missile_delta*FRACTAL_SCALE_MULT);
			missile_delta *= FRACTAL_SCALE_MULT;
			fractal_max_scale*=FRACTAL_SCALE_MULT;
			isProjectilFromChild= true;
		}
		if (isProjectilFromChild) {
			e.Thing.SetOrigin(e.Thing.pos - missile_displacement, false);
		}
	}
	
	override void WorldThingDied(WorldEvent e) {
		if (!e.Thing.bISMONSTER)
			return;
		
		// Check for 15% chance - skip if we don't get the roll
		if (random(0.0, 1.0) > FRACTAL_CHANCE) {
			return;
		}
		
		Class<Actor> ThingDiedClass = e.Thing.GetClass();
		int monster_died_class_id = get_monster_class_id(e.Thing);
		if (monster_died_class_id == -1) {
			monster_died_class_id = add_new_monster_class_data(e.Thing); 
		}
		
		vector2 relative_scale = get_relative_scale(monster_died_class_id, e.Thing);
		int iterations_allowed = Cvar.GetCvar("ufd_max_iterations", players[Net_Arbitrator]).GetInt();
		if (iterations_allowed >= MAX_CHILDS_ITERATIONS) {
			iterations_allowed = MAX_CHILDS_ITERATIONS;
		} else if (iterations_allowed < 0) {
			iterations_allowed = 0;
		}
		double fractal_min_scale = FRACTAL_SCALE_MULT**iterations_allowed+0.025;
		if (fractal_min_scale < 0.1) {
			fractal_min_scale = 0.1;
		}
		if (relative_scale.x > fractal_min_scale && relative_scale.y > fractal_min_scale) {
			int previous_monster_level = level.total_monsters;
			int child_id = get_monster_child_number(monster_died_class_id, e.Thing);
			double spawn_offset = e.Thing.Radius*2.0+monster_spawnoffset[monster_died_class_id][child_id];
			//Console.printf("Trying to spawn offset: %f", spawn_offset);
			double health_mult = FRACTAL_HEALTH_MULT**(child_id+1);
			double damage_mult = FRACTAL_DAMAGE_MULT**(child_id+1);
			int spawned=0;
			int phase=0;
			do {
				Actor monster_child;
				switch(phase) {
					case 0:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(spawn_offset , 0, 3.0));
					break;
					case 1:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(-spawn_offset, 0, 3.0));
					break;
					case 2:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(0, spawn_offset , 3.0));
					break;
					case 3:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(0, -spawn_offset , 3.0));
					break;
					case 4:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(spawn_offset, spawn_offset , 3.0));
					break;
					case 5:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(-spawn_offset , spawn_offset, 3.0));
					break;
					case 6:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(spawn_offset , -spawn_offset , 3.0));
					break;
					case 7:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(-spawn_offset , spawn_offset , 3.0));
					break;
					case 8:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(-spawn_offset, -spawn_offset, 3.0));
					break;
					case 9:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(spawn_offset, 0, -3.0));
					break;
					case 10:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(-spawn_offset, 0, -3.0));
					break;
					case 11:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(0, spawn_offset, -3.0));
					break;
					case 12:
						monster_child = Actor.Spawn(ThingDiedClass, e.Thing.pos+(0, -spawn_offset, -3.0));
					break;
				}
				//20 radius minimo
				//16 altura minima
				if (monster_child) {
					if (level.total_monsters > previous_monster_level)
						level.total_monsters-=1;
					monster_child.bCOUNTKILL = false;
					if (monster_child.TestMobjLocation()) {
						double new_radius = e.Thing.Radius*FRACTAL_SCALE_MULT;
						double new_height = e.Thing.Height*FRACTAL_SCALE_MULT;
						if (new_radius < 20.0) {
							new_radius = 20.0;
						}
						if (new_height < 16.0) {
							new_height = 16.0;
						}
						monster_child.A_SetSize(new_radius, new_height);
						monster_child.scale.x = e.Thing.scale.x*FRACTAL_SCALE_MULT;
						monster_child.scale.y = e.Thing.scale.y*FRACTAL_SCALE_MULT;
						monster_child.DamageMultiply = e.Thing.DamageMultiply*damage_mult;
						if (e.Inflictor && e.Inflictor.target) {
							monster_child.target = e.Inflictor.target;
						} else {
							monster_child.target = getClosestPlayerToActor(monster_child);
						}
						
						if (monster_child.target) {
							monster_child.A_SetAngle(monster_child.AngleTo(monster_child.target));
						}
						monster_child.A_AlertMonsters(300.0, AMF_TARGETNONPLAYER | AMF_EMITFROMTARGET); //max distance to alert
						
						if (monster_child.DamageMultiply <= 0.15) {
							monster_child.DamageMultiply = 0.15;
						}
						monster_child.Health = floor(double(e.Thing.GetSpawnHealth())*health_mult+0.5);
						if (monster_child.Health <= 0) {
							monster_child.Health = 1;
						}
						spawned+=1;
					} else {
						monster_child.destroy(); //not in a valid position, just destroy it
					}
				}
				phase+=1;
				
			}while(spawned < CHILDS_TO_SPAWN && phase < 13);
			
			if (child_id >= MAX_CHILDS_ITERATIONS) { //avoid very strange bugs...
				child_id = MAX_CHILDS_ITERATIONS-1;
			} else if (child_id < 0) { 
				child_id = 0;
			}
			
			if (spawned > 0 && !monster_able_to_spawn[monster_died_class_id][child_id]) {
				monster_able_to_spawn[monster_died_class_id][child_id] = true;
			} else  if (spawned <= 0 && !monster_able_to_spawn[monster_died_class_id][child_id]) { //failed to spawn
				monster_spawnoffset[monster_died_class_id][child_id]+=5.0; 
				if (monster_spawnoffset[monster_died_class_id][child_id] > MAX_SPAWNOFFSET) {
					monster_spawnoffset[monster_died_class_id][child_id] = MAX_SPAWNOFFSET;
				}
			}
		}
	}
}