extend class PB_WeaponBase
{
////////////////////////////Monsters Pack Execution//////////////////////////////////////////////////////////

action StateLabel PB_ExecutionHellDuke() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_HellDuke"; // ya sabes qe poner
			return result;
		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_HellDuke";
				break;
			case 2:
				result = "Execution_HellDuke";
				break;
		}
		return result;
	}

action StateLabel PB_ExecutionDirector() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Director"; // ya sabes qe poner
			return result;
		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Director";
				break;
			case 2:
				result = "Execution_Director";
				break;
		}
		return result;
	}


action StateLabel PB_ExecutionDarkLord() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_DarkLord"; // ya sabes qe poner
			return result;
		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_DarkLord";
				break;
			case 2:
				result = "Execution_DarkLord";
				break;
		}
		return result;
	}


action StateLabel PB_ExecutionESoul() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_ESoul"; // ya sabes qe poner
			return result;
		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_ESoul";
				break;
			case 2:
				result = "Execution_ESoul";
				break;
		}
		return result;
	}



action StateLabel PB_ExecutionObsidianRavager() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_ObsidianRavager";
			return result;
		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_ObsidianRavager";
				break;
			case 2:
				result = "Execution_ObsidianRavager";
				break;
		}
		return result;
	}


action StateLabel PB_ExecutionIceDemon() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_IceDemon1"; // ya sabes qe poner
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_IceDemon1";
				break;
			case 2:
				result = "Execution_IceDemon1";
				break;
		}
		return result;
	}


	action StateLabel PB_ExecutionBehemoth() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Behemoth";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Behemoth";
				break;
			case 2:
				result = "Execution_Behemoth";
				break;
		}
		return result;
	}


action StateLabel PB_ExecutionMarauder() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,3));
// 		int selector = 3;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Marauder1";
			return result;
		}
		
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Marauder1";
				break;
			case 2:
				result = "Execution_Marauder2";
				break;
			case 3:
				result = "Execution_Marauder3";
				break;
		}
		return result;
	}

action StateLabel PB_ExecutionFleshWizard() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_FleshWizard1"; // ya sabes qe poner
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_FleshWizard1";
				break;
			case 2:
				result = "Execution_FleshWizard1";
				break;
		}
		return result;
	}


action StateLabel PB_ExecutionD3Seeker() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_D3Seeker1"; // ya sabes qe poner
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_D3Seeker1";
				break;
			case 2:
				result = "Execution_D3Seeker1";
				break;
		}
		return result;
	}



action StateLabel PB_ExecutionCrackodemon() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Cricoso"; // ya sabes qe poner
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Cricoso";
				break;
			case 2:
				result = "Execution_Cricoso";
				break;
		}
		return result;
	}

	action StateLabel PB_ExecutionCyberSatyr() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_CyberSatyr3";
 			return result;
 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_CyberSatyr1";
				break;
			case 2:
				result = "Execution_CyberSatyr2";
				break;
		}
		return result;
	}
	
	action StateLabel PB_ExecutionSatyr() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);

		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_Satyr3";
 			return result;
 		}

		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Satyr1";
				break;
			case 2:
				result = "Execution_Satyr2";
				break;
		}
		return result;
	}



      action StateLabel PB_ExecutionZombiefresh() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,4));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_ZombieFresh";
			return result;
		}
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_ZombieFresh3";
 			return result;
 		}
		
		switch(selector){
			case 1:
				result = "Execution_ZombieFresh2";
				break;
			case 2:
				result = "Execution_ZombieFresh4";
				break;
			case 3:
				result = "Execution_ZombieFresh5";
				break;
			case 4:
				result = "Execution_ZombieFresh";
				break;
		}
		return result;
	}
	
	action StateLabel PB_ExecutionZombieFodder() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,4));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_ZombieFodder";
			return result;
		}
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_ZombieFodder3";
 			return result;
 		}
		
		switch(selector){
			case 1:
				result = "Execution_ZombieFodder4";
				break;
			case 2:
				result = "Execution_ZombieFodder2";
				break;
			case 3:
				result = "Execution_ZombieFodder";
				break;
			case 4:
				result = "Execution_ZombieFodder5";
				break;
		}
		return result;
	}



	action StateLabel PB_ExecutionPB_HorrorspawnDecap() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,4));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_PB_ExecutionPB_HorrorspawnDecap";
			return result;
		}
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_PB_HorrorspawnDecap";
 			return result;
 		}
				result = "Execution_PB_HorrorspawnDecap";
		return result;
	}



	action StateLabel PB_ExecutionUnwilling() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,4));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Unwilling";
			return result;
		}
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_Unwilling3";
 			return result;
 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Unwilling2";
				break;
			case 2:
				result = "Execution_Unwilling4";
				break;
			case 3:
				result = "Execution_Unwilling5";
				break;
			case 4:
				result = "Execution_Unwilling";
				break;
		}
		return result;
	}

	action StateLabel PB_ExecutionHunger() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,4));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Hunger";
			return result;
		}
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_Hunger3";
 			return result;
 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Hunger2";
				break;
			case 2:
				result = "Execution_Hunger4";
				break;
			case 3:
				result = "Execution_Hunger5";
				break;
			case 4:
				result = "Execution_Hunger";
				break;
		}
		return result;
	}
	
	action StateLabel PB_ExecutionCyberFodder() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,4));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_CyberFodder";
			return result;
		}
		
		// Wall Kick Fatality
 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
 			result = "Execution_CyberFodder3";
 			return result;
 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_CyberFodder4";
				break;
			case 2:
				result = "Execution_CyberFodder2";
				break;
			case 3:
				result = "Execution_CyberFodder";
				break;
			case 4:
				result = "Execution_CyberFodder5";
				break;
		}
		return result;
	}
	
	  action StateLabel PB_ExecutionHelemental() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		angle,
		120,
		pitch,
		TRF_THRUACTORS,
		offsetz: height-12,
		data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_helemental";
			return result;
		}
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_helemental";
				break;
			case 2:
				result = "Execution_helemental";
				break;
		}
		return result;
	}
	
	action StateLabel PB_ExecutionDarkDisciple() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Darkdisciple1";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Darkdisciple1";
				break;
			case 2:
				result = "Execution_Darkdisciple2";
				break;
		}
		return result;
	}
	
	action StateLabel PB_ExecutionPyroDemon() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_PyroDemon1";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_PyroDemon1";
				break;
			case 2:
				result = "Execution_PyroDemon2";
				break;
		}
		return result;
	}
	
	action StateLabel PB_ExecutionTerminator() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Terminator";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Terminator";
				break;
			case 2:
				result = "Execution_Terminator2";
				break;
		}
		return result;
	}

	action StateLabel PB_ExecutionD3HellGuardian() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_D3HellGuardian1";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_D3HellGuardian1";
				break;
			case 2:
				result = "Execution_D3HellGuardian1";
				break;
		}
		return result;
	}


	action StateLabel PB_ExecutionD3Maledict() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_D3Maledict1";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_D3Maledict1";
				break;
			case 2:
				result = "Execution_D3Maledict1";
				break;
		}
		return result;
	}


	action StateLabel PB_ExecutionRahovart() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_Rahovart1";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_Rahovart1";
				break;
			case 2:
				result = "Execution_Rahovart2";
				break;
		}
		return result;
	}

	action StateLabel PB_ExecutionOverLord() {
		//A_GiveInventory("ExecutionToken", 1, AAPTR_PLAYER_GETTARGET); // Todo: Move this to a higher function once more fatalities are done
		StateLabel result;
		int selector = (random(1,2));
// 		int selector = 2;
		FLineTraceData RemoteRay;
		bool wallcheck = LineTrace(
		   angle,
		   120,
		   pitch,
		   TRF_THRUACTORS,
		   offsetz: height-12,
		   data: RemoteRay
		);
		
		// Drop Kick Fatality
		if((Pos.Z-floorz) > 8) {
			A_Warp(AAPTR_PLAYER_GETTARGET, 0, 0, 54, WARPF_USECALLERANGLE|WARPF_NOCHECKPOSITION);
			result = "Execution_OverLord";
			return result;
		}
		
		
// 		// Wall Kick Fatality
// 		if(wallcheck && RemoteRay.HitType == TRACE_HitWall) {
// 			result = "Execution_Zombieman3";
// 			return result;
// 		}
		
		// Generic Fatalities
		switch(selector){
			case 1:
				result = "Execution_OverLord";
				break;
			case 2:
				result = "Execution_OverLord";
				break;
		}
		return result;
	}
	
////////////////////////////////The End//////////////////////////////////////////////////////////////////
}