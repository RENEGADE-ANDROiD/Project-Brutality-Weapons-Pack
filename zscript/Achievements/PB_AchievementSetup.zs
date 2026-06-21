// PBWPE achievement definitions (VUAS / Vortex Universal Achievement System).
// Monster kill goals match the TC PDA codex roster (PDAMONST) — not Monster Pack addon classes.

class PB_AchievementSetup : VUAS_AchievementSetup
{
	override void DefineAchievements()
	{
		// --- Combat (auto kill tracking; targetClass uses replacement chain) ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_first_blood", "First Blood",
			"Kill your first enemy.", "combat",
			1, TRACK_KILLS, '', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_kill_250", "Exterminator",
			"Kill 250 enemies (cumulative).", "combat",
			250, TRACK_KILLS, '', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_kill_500", "Scourge",
			"Kill 500 enemies (cumulative).", "combat",
			500, TRACK_KILLS, '', "ACHVMT02");

		VUAS_AchievementHandler.AddAchievement(
			"pb_kill_1000", "Genocide",
			"Kill 1,000 enemies (cumulative).", "combat",
			1000, TRACK_KILLS, '', "ACHVMT03");

		VUAS_AchievementHandler.AddAchievement(
			"pb_imp_slayer", "Imp Slayer",
			"Kill 100 Imps (includes Dark Imp strains).", "combat",
			100, TRACK_KILLS, 'DoomImp', "ACHVMT04");

		VUAS_AchievementHandler.AddAchievement(
			"pb_zombie_menace", "Dead Men Walking",
			"Kill 100 Zombiemen (all rifle/pistol/helmet/carbine/plasma grunt variants).", "combat",
			100, TRACK_KILLS, 'ZombieMan', "ACHVMT05");

		VUAS_AchievementHandler.AddAchievement(
			"pb_shotgun_squad", "Shotgun Response",
			"Kill 75 Shotgun Sergeants.", "combat",
			75, TRACK_KILLS, 'ShotgunGuy', "ACHVMT06");

		VUAS_AchievementHandler.AddAchievement(
			"pb_chaingunner", "Lead Storm",
			"Kill 75 Chaingun Commandos.", "combat",
			75, TRACK_KILLS, 'ChaingunGuy', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_plasma_trooper", "Ion Burn",
			"Kill 50 Plasma Zombiemen or Troopers.", "combat",
			50, TRACK_KILLS, 'PB_PlasmaZombie', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_knight_breaker", "Knight of the Abyss",
			"Kill 25 Hell Knights.", "combat",
			25, TRACK_KILLS, 'HellKnight', "ACHVMT02");

		VUAS_AchievementHandler.AddAchievement(
			"pb_baron_bane", "Baron Breaker",
			"Kill 15 Barons of Hell.", "combat",
			15, TRACK_KILLS, 'BaronOfHell', "ACHVMT03");

		// --- Glory Kills & finishers (PB hooks) ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_first_glory_kill", "Intimate Violence",
			"Perform a Glory Kill.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT04");

		VUAS_AchievementHandler.AddAchievement(
			"pb_blood_punch", "Crimson Fist",
			"Land a Blood Punch finisher.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT05");

		VUAS_AchievementHandler.AddAchievement(
			"pb_glory_10", "Enforcer",
			"Perform 10 Glory Kills.", "glory",
			10, TRACK_CUSTOM_EVENT, '', "ACHVMT06");

		VUAS_AchievementHandler.AddAchievement(
			"pb_glory_25", "Butcher",
			"Perform 25 Glory Kills.", "glory",
			25, TRACK_CUSTOM_EVENT, '', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_glory_100", "Executioner",
			"Perform 100 Glory Kills.", "glory",
			100, TRACK_CUSTOM_EVENT, '', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_shoulder_flame", "Shoulder Roast",
			"Fire the Glory shoulder flame belch.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT02");

		VUAS_AchievementHandler.AddAchievement(
			"pb_shoulder_ice", "Cold Shoulder",
			"Launch a Glory shoulder ice bomb.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT03");

		VUAS_AchievementHandler.AddAchievement(
			"pb_shield_saw_throw", "Saw You Coming",
			"Throw the Shield Saw.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT04");

		VUAS_AchievementHandler.AddAchievement(
			"pb_execution", "Up Close",
			"Trigger an experimental weapon execution.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT05");

		VUAS_AchievementHandler.AddAchievement(
			"pb_frozen_statue", "Deep Freeze",
			"Shatter an enemy into a frozen-solid statue.", "glory",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT06");

		// --- Exploration ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_secret_1", "Hidden Path",
			"Find a secret area.", "exploration",
			1, TRACK_SECRETS, '', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_secret_10", "Cartographer",
			"Find 10 secret areas (cumulative).", "exploration",
			10, TRACK_SECRETS, '', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_secret_25", "Treasure Hunter",
			"Find 25 secret areas (cumulative).", "exploration",
			25, TRACK_SECRETS, '', "ACHVMT02");

		// --- PDA codex (PB hooks) ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_weapon_found", "Arms Dealer",
			"Log a weapon in the PDA codex.", "pda",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT03");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_weapons_10", "Arsenal",
			"Log 10 weapons in the PDA codex.", "pda",
			10, TRACK_CUSTOM_EVENT, '', "ACHVMT04");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_weapons_25", "Quartermaster",
			"Log 25 weapons in the PDA codex.", "pda",
			25, TRACK_CUSTOM_EVENT, '', "ACHVMT05");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_weapons_all", "Master At Arms",
			"Log every weapon in the PDA codex.", "pda",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT06");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_monster_found", "Field Research",
			"Log a monster in the PDA codex.", "pda",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT06");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_monsters_10", "Xenobiologist",
			"Log 6 monsters in the PDA codex.", "pda",
			6, TRACK_CUSTOM_EVENT, '', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_monsters_25", "Demonologist",
			"Log all 12 monsters in the PDA codex.", "pda",
			12, TRACK_CUSTOM_EVENT, '', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_pda_equipment_found", "Tactician",
			"Log equipment in the PDA codex.", "pda",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT02");

		// --- Explosive movement (PB hooks) ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_rocket_jump", "Rocket Rider",
			"Gain blast momentum from a rocket-jump explosion.", "movement",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT03");

		VUAS_AchievementHandler.AddAchievement(
			"pb_plasma_climb", "Plasma Boost",
			"Gain blast momentum from plasma wall-climb splash.", "movement",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT04");

		// --- Multi-kill (one blast / pierce) ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_multikill_explosive", "Chain Reaction",
			"Kill 2+ enemies with one explosive shot or blast.", "technique",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT05");

		VUAS_AchievementHandler.AddAchievement(
			"pb_multikill_rail", "Line Them Up",
			"Kill 2+ enemies with one railgun shot.", "technique",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT06");

		VUAS_AchievementHandler.AddAchievement(
			"pb_multikill_bfg", "BFG Division",
			"Kill 2+ enemies with one BFG shot.", "technique",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_multikill_sniper", "Double Tap",
			"Kill 2+ enemies with one sniper shot.", "technique",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_multikill_plasma", "Overload",
			"Kill 2+ enemies with one plasma volley or orb.", "technique",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT02");

		VUAS_AchievementHandler.AddAchievement(
			"pb_multikill_equipment", "Area Denial",
			"Kill 2+ enemies with one equipment blast.", "technique",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT03");

		// --- Meta: damage, killstreaks & XP rank ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_damage_dealer", "Heavy Hitter",
			"Deal 25,000 damage (cumulative).", "meta",
			25000, TRACK_DAMAGE_DEALT, '', "ACHVMT04");

		VUAS_AchievementHandler.AddAchievement(
			"pb_tough_skin", "Walking Wound",
			"Take 10,000 damage (cumulative).", "meta",
			10000, TRACK_DAMAGE_TAKEN, '', "ACHVMT05");

		VUAS_AchievementHandler.AddAchievement(
			"pb_killstreak_5", "On a Roll",
			"Earn a kill-streak reward at 5+ kills.", "meta",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT06");

		VUAS_AchievementHandler.AddAchievement(
			"pb_killstreak_10", "Unstoppable",
			"Earn a kill-streak reward at 10+ kills.", "meta",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT00");

		VUAS_AchievementHandler.AddAchievement(
			"pb_rank_5", "Operator",
			"Reach PB XP rank 5.", "meta",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT01");

		VUAS_AchievementHandler.AddAchievement(
			"pb_rank_10", "Veteran",
			"Reach PB XP rank 10.", "meta",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT02");

		VUAS_AchievementHandler.AddAchievement(
			"pb_rank_15", "Elite",
			"Reach PB XP rank 15.", "meta",
			1, TRACK_CUSTOM_EVENT, '', "ACHVMT03");

		// --- Challenge ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_uv_warrior", "Ultraviolent",
			"Kill 50 enemies on Hurt Me Plenty or harder.", "challenge",
			50, TRACK_KILLS, '', "ACHVMT04",
			false, true, true, 2, 4);

		VUAS_AchievementHandler.AddAchievement(
			"pb_uv_200", "Night Shift",
			"Kill 200 enemies on Ultra-Violence or Nightmare.", "challenge",
			200, TRACK_KILLS, '', "ACHVMT05",
			false, true, true, 3, 4);

		VUAS_AchievementHandler.AddAchievement(
			"pb_nm_reaper", "Nightmare Reaper",
			"Kill 100 enemies on Nightmare.", "challenge",
			100, TRACK_KILLS, '', "ACHVMT06",
			false, true, true, 4, 4);

		// --- Hidden ---
		VUAS_AchievementHandler.AddAchievement(
			"pb_hidden_genocide", "???",
			"???", "secret",
			1000, TRACK_KILLS, '', "ACHVMT02", true);
	}
}
