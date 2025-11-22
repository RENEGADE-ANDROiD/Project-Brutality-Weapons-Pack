enum Bobbing
{
	Bob_Normal,
	Bob_Inverse,
	Bob_Alpha,
	Bob_InverseAlpha,
	Bob_Smooth,
	Bob_InverseSmooth,
	Bob_Build,
	Bob_Dusk,
	Bob_Painkiller,
	Bob_UT
}

Class PainkillerPlayer : PlayerPawn
{
	//=========================
	//Common
	
	const BOB_MIN_REALIGN 	 = 0.25f;
	const GROUND_DASH_COOLER = 18;
	
	//Movement General
	bool	Pain;
	double	ViewAngleDelta;
	float	ActualSpeed;
	float	MaxAirSpeed;
	float 	MaxGroundSpeed;
	float	MoveFactor;
	int		AnimateJump;
	int		ForceVelocity;
	int		OldFloorZ;
	playerinfo ZMPlayer;
	vector2 OldVelXY;
	vector3	Acceleration;
	
	//////////////////
	
	//Jumping
	bool 	BlockJump;
	bool	Jumped;
	float	FloorAngle;
	int		DoubleJumpCooler;
	int		JumpSoundCooler;
	
	//Double Jump
	bool	BlockDoubleJump;
	bool	CanDoubleJump;
	
	//Elevator Jumps
	float	ElevatorJumpBoost;
	int		OldSecIndex;
	
	//////////////////
	
	//Double Tap
	int		FirstTapTime;
	int		FirstTapValue;
	int		OldTapValue;
	
	//Dashing
	float	WJumpSpeed;
	int		DashNumber;
	int		DashCooler;
	
	//Air Dashing
	float	ADashTargetSpeed;
	int		ADashCooler;
	int		ADashFrictionDelay;
	
	//WallJump
	int		CheckForWJump;
	
	//WallSlideMove
	bool	CanWSlide;
	int		CheckForWSlide;
	vector2	WSlideVelocity;
	
	//Crouch Slide
	bool	CanCSlide;
	float	MaximumSlideSpeed;
	float	QSlideDuration;
	int		CSlideStartTime;
	
	//Ledge Grabbing
	bool	LedgeGrabbed;
	float	LedgeAngle;
	int		LedgeHeight;
	int		LedgeTime;
	weapon	ReselectWeapon;
	
	//Grappling Hook
	actor	GrappledMonster;
	actor	HookFired;
	bool	Grappled;
	float	PendulumLength;
	vector3	GrappleVel;
	vector3 Rope;
	
	//////////////////
	
	//View Bobbing
	bool	PostLandingBob;
	float	ZMBob;
	
	//Weapon bobbing
	bool	DoBob;
	double	BobTime;
	double	HorizontalSway;
	double	BobRange;
	double 	OldTicFrac;
	double	VerticalOffset;
	
	//=========================
	//Painkiller only
	
	//Movement
	bool	TrickFailed;
	float	AirControl;
	float	ActualMaxAirSpeed;
	
	//Jumping
	float	TrickJumpAngle;
	int		SmallerJumpHeight;
	
	Default
    {
		Player.DisplayName "Painkiller Player";
        PainChance 255;
    }
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////
	////																						////
	//// Non-Movement Stuff																		////
	////																						////
	////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Because GZDoom's Unit() returns NaN if a vector has no value
	vector3 SafeUnit3(Vector3 VecToUnit)
	{
		if(VecToUnit.Length()) { VecToUnit /= VecToUnit.Length(); }
		return VecToUnit;
	}
	
	vector2 SafeUnit2(Vector2 VecToUnit)
	{
		if(VecToUnit.Length()) { VecToUnit /= VecToUnit.Length(); }
		return VecToUnit;
	}
	
	Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		//No voodoo dolls allowed past this point
		if(!self.player || self.player.mo != self) { return; }
		bNOFRICTION = True;
	}
	
	Override void PlayerThink()
	{
		//======================================
		//Store info needed in multiple places
		
		ZMPlayer = self.player;
		ActualSpeed = Speed * GetPowerSpeed();
		MaxGroundSpeed = zm_maxgroundspeed * ActualSpeed;
		MoveFactor = ScaleMovement();
		Pain = InStateSequence(CurState, FindState("Pain"));
		ZMPlayer.OnGround = Pos.Z <= FloorZ || bONMOBJ || bMBFBOUNCER || (ZMPlayer.Cheats & CF_NOCLIP2);
		
		//======================================
		//Execute Player tic cycle
		
		CheckFOV();
		
		if(ZMPlayer.inventorytics) { ZMPlayer.inventorytics--; }
		CheckCheats();

		bool totallyfrozen = CheckFrozen();

		// Handle crouching
		CheckCrouch(totallyfrozen);
		CheckMusicChange();

		if(ZMPlayer.playerstate == PST_DEAD)
		{
			DeathThink();
			return;
		}
		if(ZMPlayer.morphTics && !(ZMPlayer.cheats & CF_PREDICTING)) { MorphPlayerThink (); }

		CheckPitch();
		HandleMovement();
		CalcHeight();

		if(!(ZMPlayer.cheats & CF_PREDICTING))
		{
			CheckEnvironment();
			// Note that after this point the PlayerPawn may have changed due to getting unmorphed or getting its skull popped so 'self' is no longer safe to use.
			// This also must not read mo into a local variable because several functions in this block can change the attached PlayerPawn.
			ZMPlayer.mo.CheckUse();
			ZMPlayer.mo.CheckUndoMorph();
			// Cycle psprites.
			ZMPlayer.mo.TickPSprites();
			// Other Counters
			if(ZMPlayer.damagecount) ZMPlayer.damagecount--;
			if(ZMPlayer.bonuscount) ZMPlayer.bonuscount--;

			if(ZMPlayer.hazardcount)
			{
				ZMPlayer.hazardcount--;
				if(!(Level.maptime % ZMPlayer.hazardinterval) && ZMPlayer.hazardcount > 16*TICRATE)
					ZMPlayer.mo.DamageMobj (NULL, NULL, 5, ZMPlayer.hazardtype);
			}
			ZMPlayer.mo.CheckPoison();
			ZMPlayer.mo.CheckDegeneration();
			ZMPlayer.mo.CheckAirSupply();
		}
		
		//Bob weapon stuff
		BobWeaponAuxiliary();
		
		//Old values for comparisons
		OldFloorZ = FloorZ;
		OldVelXY = Vel.XY;
	}
	
	float GetPowerSpeed()
	{
		float factor = 1.f;
		
		if(!ZMPlayer.morphTics)
		{
			for(let it = Inv; it != null; it = it.Inv)
			{
				factor *= it.GetSpeedFactor();
			}
		}
		
		return factor;
	}
	
	Override void DeathThink()
	{
		bNOFRICTION = False;
		Gravity = zm_setgravity;
		
		Super.DeathThink();
	}
	
	Override void CalcHeight()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		double HeightAngle;
		double bob;
		bool still = false;

		if(!ZMPlayer.OnGround || (ZMPlayer.OnGround && ((cmd.buttons & BT_JUMP) && !BlockJump)) || ZMPlayer.cheats & CF_NOCLIP2) //nobody walks in the air
		{
			ZMBob--;
			ZMBob = max(bNOGRAVITY ? 0.5f : 0.f, ZMBob);
			PostLandingBob = True;
		}
		else
		{
			if(PostLandingBob)
			{
				ZMBob += Vel.XY.Length() / (MaxGroundSpeed ? MaxGroundSpeed : 1.f);
				if(ZMBob >= Vel.XY.Length() * ZMPlayer.GetMoveBob()) { PostLandingBob = False; }
			}
			else
			{
				ZMBob = Vel.XY.Length() * ZMPlayer.GetMoveBob(); //this way all GetMoveBob() values are meaningful
			}
			
			if(!ZMBob)
				still = true;
			else
				ZMBob = min(MaxGroundSpeed, ZMBob);
		}

		double defaultviewheight = ViewHeight + ZMPlayer.crouchviewdelta;

		if(ZMPlayer.cheats & CF_NOVELOCITY)
		{
			ZMPlayer.viewz = pos.Z + defaultviewheight;

			if(ZMPlayer.viewz > ceilingz-4)
				ZMPlayer.viewz = ceilingz-4;

			return;
		}

		if(still)
		{
			if(ZMPlayer.health > 0)
				bob = 2 * ZMPlayer.GetStillBob() * sin(2 * Level.maptime);
			else
				bob = 0;
		}
		else
		{
			HeightAngle = Level.maptime / 20. * 360.;
			bob = ZMBob * sin(HeightAngle) * (waterlevel > 2 ? 0.25f : 0.5f);
		}
		
		if(ZMPlayer.morphTics) { bob = 0; }
		
		//=======================================
		// Customizable Landing
		
		if(zm_landing)
		{
			if(ZMPlayer.playerstate == PST_LIVE)
			{
				if(!ZMPlayer.OnGround)
				{
					if(Vel.Z >= 0)
					{
						ZMPlayer.viewheight += ZMPlayer.deltaviewheight;
						ZMPlayer.deltaviewheight += zm_landingspeed * 2.f; //ensure a speedy recovery while in the air
						if(ZMPlayer.viewheight >= defaultviewheight)
						{
							ZMPlayer.deltaviewheight = 0;
							ZMPlayer.viewheight = defaultviewheight;
						}
					}
					else
					{
						ZMPlayer.deltaviewheight = Vel.Z / zm_landingsens;
						ZMPlayer.viewheight = defaultviewheight;
					}
				}
				else
				{
					ZMPlayer.viewheight += ZMPlayer.deltaviewheight;

					if(ZMPlayer.viewheight > defaultviewheight)
					{
						ZMPlayer.viewheight = defaultviewheight;
						ZMPlayer.deltaviewheight = 0;
					}
					else if(ZMPlayer.viewheight < defaultviewheight * zm_minlanding)
					{
						ZMPlayer.viewheight = defaultviewheight * zm_minlanding;
						if(ZMPlayer.deltaviewheight <= 0) { ZMPlayer.deltaviewheight = 1 / 65536.f; }
					}
					
					if(ZMPlayer.deltaviewheight)	
					{
						ZMPlayer.deltaviewheight += zm_landingspeed;
						if(!ZMPlayer.deltaviewheight) { ZMPlayer.deltaviewheight = 1 / 65536.f; }
					}
				}
			}
		}
		else //regular Doom landing
		{
			if(ZMPlayer.playerstate == PST_LIVE)
			{
				ZMPlayer.viewheight += ZMPlayer.deltaviewheight;
				
				if(ZMPlayer.viewheight > defaultviewheight)
				{
					ZMPlayer.viewheight = defaultviewheight;
					ZMPlayer.deltaviewheight = 0;
				}
				else if(ZMPlayer.viewheight < (defaultviewheight/2))
				{
					ZMPlayer.viewheight = defaultviewheight/2;
					if(ZMPlayer.deltaviewheight <= 0)
						ZMPlayer.deltaviewheight = 1 / 65536.;
				}
				
				if(ZMPlayer.deltaviewheight)	
				{
					ZMPlayer.deltaviewheight += 0.25;
					if(!ZMPlayer.deltaviewheight) { ZMPlayer.deltaviewheight = 1/65536.; }
				}
			}
		}
			
		//Let's highlight the important stuff shall we?
		ZMPlayer.viewz = pos.Z + ZMPlayer.viewheight + (bob * clamp(ViewBob, 0., 1.5));
		
		if(Floorclip && ZMPlayer.playerstate != PST_DEAD && pos.Z <= floorz) { ZMPlayer.viewz -= Floorclip; }
		if(ZMPlayer.viewz > ceilingz - 4) { ZMPlayer.viewz = ceilingz - 4; }
		if(ZMPlayer.viewz < FloorZ + 4) { ZMPlayer.viewz = FloorZ + 4; }
	}
	
	Override void CheckPitch()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		int clook = cmd.pitch;
		if(clook != 0)
		{
			if(clook == -32768)
			{
				ZMPlayer.centering = true;
			}
			else if(!ZMPlayer.centering)
			{
				A_SetPitch(Pitch - clook * (360. / 65536.), SPF_INTERPOLATE);
			}
		}
		
		if(ZMPlayer.centering)
		{
			if(abs(Pitch) > 2.)
			{
				Pitch *= (2. / 3.);
			}
			else
			{
				Pitch = 0.;
				ZMPlayer.centering = false;
				if(PlayerNumber() == consoleplayer)
				{
					LocalViewPitch = 0;
				}
			}
		}
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////
	////																						////
	//// Movement Stuff																			////
	////																						////
	////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	Override void HandleMovement()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		// [RH] Check for fast turn around
		if(cmd.buttons & BT_TURN180 && !(ZMPlayer.oldbuttons & BT_TURN180)) { ZMPlayer.turnticks = TURN180_TICKS; }

		// Handle movement
		if(reactiontime)
		{ // Player is frozen
			reactiontime--;
		}
		else
		{	
			ViewAngleDelta = cmd.Yaw * (360.0 / 65536.0); //needed for two other things
			
			if(ZMPlayer.TurnTicks) //moved here to save many doubled lines
			{
				ZMPlayer.TurnTicks--;
				A_SetAngle(Angle + (180.0 / TURN180_TICKS), SPF_INTERPOLATE);
			}
			else
			{
				A_SetAngle(Angle + ViewAngleDelta, SPF_INTERPOLATE);
				if(LedgeGrabbed) { Angle = clamp(Angle, LedgeAngle - 20, LedgeAngle + 20); }
			}
			
			//========================================
			//Acrobatics triggers
			if(CVar.GetCVar("zm_doubletap", Player).GetBool()) { DoubleTapCheck(); }
			//Dashing parameters reset
			if(DashCooler)
			{
				if(DashCooler <= GROUND_DASH_COOLER || DashCooler > 100)
				{
					DashCooler--;
				}
				else if(ZMPlayer.OnGround || WaterLevel >= 2 || bNOGRAVITY)
				{
					WJumpSpeed = DashNumber = 0;
					DashCooler = GROUND_DASH_COOLER;
				}
			}
			//Air Dash
			if(zm_airdash || zm_wjump)
			{
				if(ADashCooler) { ADashCooler--; }
				if(ADashTargetSpeed) { AirDashFriction(); }
			}
			//Wall Jumping
			if(CheckForWJump) { DashInitiator(); }
			//Wall Slide
			if(CheckForWSlide) { WallSlideInitiator(); }
			//Crouchsliding
			if(zm_crouchslide) { CSlideInitiator(); }
			
			//========================================
			//Gravity
			PainkillerGravity();
			
			//========================================
			//Say no to wall friction
			QuakeWallFriction();
			
			//========================================
			//Actual Movement selection
			if(GrappleVel.Length())
			{
				GrapplingMove();
			}
			else if(CanWSlide)
			{
				WallSlideMove();
			}
			else if(LedgeGrabbed)
			{
				LedgeGrab();
			}
			else if(WaterLevel >= 2)
			{
				PainkillerWaterMove();
				if(zm_ledgegrab) { LedgeGrabInitiator(); }
			}
			else if(bNOGRAVITY)
			{
				PainkillerFlyMove();
			}
			else if(CanCSlide)
			{
				if(zm_crouchslide == 2)
					QSlideMove();
				else
					CSlideMove();
			}
			else
			{
				PainkillerHandleMove();
			}
			
			//========================================
			//Jumping
			PainkillerJump();
			
			//========================================
			//Misc
			if(ZMPlayer.Cheats & CF_REVERTPLEASE != 0)
			{
				ZMPlayer.Cheats &= ~CF_REVERTPLEASE;
				ZMPlayer.Camera = ZMPlayer.Mo;
			}
			
			CheckMoveUpDown();
		}
	}
	
	void QuakeWallFriction()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		if(ForceVelocity)
		{
			if(OldVelXY.Length() && Vel.XY.Length() && (cmd.forwardmove || cmd.sidemove))
			{
				Vector2 VelUnit = Vel.XY.Unit();
				Float VelDot = OldVelXY.Unit() dot VelUnit;
				if(VelDot > 0)
				{
				   if(VelDot > 0.75)
					  VelDot = 1.f;
				   else
					  VelDot /= 0.75;
				   
				   Vel.XY = VelDot * OldVelXY.Length() * VelUnit;
				}
				ForceVelocity--;
			}
			else
			{
				ForceVelocity = 0;
			}
		}
		if(!CheckMove(Pos.XY + Vel.XY)) { ForceVelocity = 2; }
	}
	
	//////////////////////////////////////////
	// Jumping								//
	//////////////////////////////////////////
	
	void PreJumpCommon()
	{
		//Jumptics settings
		if(Jumped && (Player.OnGround || WaterLevel >= 2 || bNOGRAVITY)) { Jumped = False; }
		
		//Jump Sound Cooler
		if(JumpSoundCooler) { JumpSoundCooler--; }
		
		//Doudle jump cooler
		if(DoubleJumpCooler) { DoubleJumpCooler--; }
		
		//Double Jump
		if(ZMPlayer.OnGround) { CanDoubleJump = True; }
	}
	
	float GetPowerJump()
	{
		Float JumpFac = 0.f;
		
		for(let p = Inv; p != null; p = p.Inv)
		{
			let pp = PowerHighJump(p);
			if(pp) { JumpFac = max(JumpFac, pp.Strength); }
		}
		
		return JumpFac;
	}
	
	bool, bool CheckIfJumpable()
	{
		if(CeilingZ - FloorZ <= Height) //sector is just high enough for player to pass through but not jump
		{
			return True, False;
		}
		else
		{
			//===============================
			// Get floor normal
			
			Vector3 FloorNormal;
			F3DFloor ThreeDFloor;
			for(int i = 0; i < FloorSector.Get3DFloorCount(); i++)
			{
				if(FloorSector.Get3DFloor(i).Top.ZAtPoint(Pos.XY) ~== FloorZ)
				{
					ThreeDFloor = FloorSector.Get3DFloor(i);
					break;
				}
			}
			FloorNormal = ThreeDFloor ? - ThreeDFloor.Top.Normal : FloorSector.FloorPlane.Normal;
			FloorAngle = atan2(FloorNormal.XY.Length(), FloorNormal.Z);
			
			//==============================
			//Come to the logical conclusion
			
			if(FloorAngle < 45)
				return BlockJump ? True : False, !FloorAngle ? False : True;
			else
				return ZMPlayer.OnGround ? True : False, True; //floor is too steep
		}
    }
	
	void ElevatorJump(bool SlopedFloor)
	{
		Int SecIndex = FloorSector.Index();
		Bool CheckForElevator = ZMPlayer.OnGround && SecIndex == OldSecIndex && !SlopedFloor;
		
		if(zm_elevatorjump)
		{
			if(CheckForElevator && FloorZ > OldFloorZ) //no accidental elevator jump boost on slopes
				ElevatorJumpBoost = (FloorZ - OldFloorZ) * zm_ejumpmultiplier;
			else
				ElevatorJumpBoost = 0;
		}
		else
		{
			if(CheckForElevator && FloorZ - OldFloorZ >= zm_jumpheight / 2.f) { BlockJump = True; } //floor is raising too fast to not spam jump
			ElevatorJumpBoost = 0;
		}
		
		OldSecIndex = SecIndex;
	}
	
	void PainkillerGravity()
	{
		if(WaterLevel >= 2)
		{
			if(Vel.Length() < MaxGroundSpeed / 3.f)
				Gravity = 0.5f;
			else
				Gravity = 0.f;
		}
		else if(bNOGRAVITY || GrappleVel.Length())
		{
			Gravity = 0.f;
		}
		else
		{
			Gravity = zm_setgravity;
		}
	}
	
	void PainkillerJump()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//Common stuff
		PreJumpCommon();
		
		//underwater/flying specific jump behavior are in WaterMove and FlyMove
		if(WaterLevel >= 2 || bNOGRAVITY) { return; }
		
		//Check slope angle and sector height
		Bool SlopedFloor;
		[BlockJump, SlopedFloor] = CheckIfJumpable();
		
		//Elevators Jump Boost
		ElevatorJump(SlopedFloor);
		
		////////////////////////////////
		//Actual Jump
		if(cmd.buttons & BT_JUMP)
		{
			if(LedgeGrabbed || GrappleVel.Length() || CanWSlide || DashCooler > 100) { return; }
			
			if(ZMPlayer.crouchoffset != 0)
			{
				ZMPlayer.crouching = 1;
			}
			else if(ZMPlayer.onground && !BlockJump)
			{
				SmallerJumpHeight++;
				
				Float JumpVelZ = zm_jumpheight + ElevatorJumpBoost;
				Float JumpFac = GetPowerJump();
				if(JumpFac) { JumpVelZ *= JumpFac; }
					
				Vel.Z += (SmallerJumpHeight > 1 ? pk_bhopjumpheight : 1) * (Vel.Z > 0 ? zm_rjumpmulti : 1) * JumpVelZ;
				
				bONMOBJ = false;
				Jumped = True;
				
				if(!(ZMPlayer.cheats & CF_PREDICTING) && !JumpSoundCooler)
				{
					A_PlaySound("*jump", CHAN_BODY);
					JumpSoundCooler = 4;
				}
				
				//if autojump is on set Blockjump false while jump key is pressed
				BlockJump = zm_autojump ? False : True;
				DoubleJumpCooler = 5;
			}
			else if(!ZMPlayer.OnGround && CanDoubleJump && !BlockDoubleJump && !DoubleJumpCooler && ((zm_doublejump == 1 && Vel.Z > 0) || zm_doublejump == 2))
			{
				Float DoubleJumpVelZ = zm_jumpheight * zm_doublejumpheight;
				Float JumpFac = GetPowerJump();
				if(JumpFac) { DoubleJumpVelZ *= JumpFac; }
				Vel.Z = DoubleJumpVelZ;
				
				bONMOBJ = false;
				Jumped = True;
				
				if(!(ZMPlayer.cheats & CF_PREDICTING)) { A_PlaySound("*jump", CHAN_BODY); }
				
				CanDoubleJump = False;
			}
			
			BlockDoubleJump = True;
		}
		else
		{
			BlockDoubleJump = False;
			BlockJump = False;
		}
	}
	
	//////////////////////////////////////////
	// Ground Movement						//
	//////////////////////////////////////////
	
	float ScaleMovement()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		Float MoveMulti;
		if(cmd.sidemove || cmd.forwardmove)
		{
			Bool IsWalking = (CVar.GetCVar("cl_run", Player).GetBool() && (cmd.buttons & BT_SPEED)) || (!CVar.GetCVar("cl_run", Player).GetBool() && !(cmd.buttons & BT_SPEED));
			
			if(ZMPlayer.CrouchFactor == 0.5)
				MoveMulti = min(zm_crouchspeed, zm_walkspeed);
			else if(IsWalking)
				MoveMulti = zm_walkspeed;
			else
				MoveMulti = 1;
		}
		else
		{
			MoveMulti = 1;
		}
		
		return MoveMulti;
	}
	
	float SpeedMulti()
	{
		return MoveFactor * (ZMPlayer.cmd.forwardmove && ZMPlayer.cmd.sidemove ? zm_strafemodifier : 1);
	}
	
	float AccelMulti()
	{
		return ActualSpeed * (ZMPlayer.cmd.forwardmove && ZMPlayer.cmd.sidemove ? zm_strafemodifier : 1);
	}
	
	void DropPrevention()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		Bool GuardRail = ((!cmd.sidemove && !cmd.forwardmove && Vel.XY.Length()) ||
						 (CVar.GetCVar("cl_run", Player).GetBool() && (cmd.buttons & BT_SPEED)) || (!CVar.GetCVar("cl_run", Player).GetBool() && !(cmd.buttons & BT_SPEED))) //fuck me having to do this
						 && ZMPlayer.OnGround && !Pain;
		
		if(GuardRail)
		{
			Float GuardAngle = VectorAngle(Vel.X, Vel.Y);
			Float GuardX = Pos.X + Radius * cos(GuardAngle);
			Float GuardY = Pos.Y + Radius * sin(GuardAngle);
			Bool FallDanger = Pos.Z - GetZAt(GuardX, GuardY, 0, GZF_ABSOLUTEPOS|GZF_ABSOLUTEANG) > Height;
			if(FallDanger) { Vel.XY *= 0.5f; }
		}
	}
	
	void GroundSpriteAnimation()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		if(ZMPlayer.Cheats & CF_PREDICTING == 0 && Vel.XY.Length() > 1.f && (cmd.forwardmove || cmd.sidemove))
			PlayRunning();
		else
			PlayIdle();
			
		AnimateJump = 6;
	}
	
	void AirSpriteAnimation()
	{
		if(AnimateJump)
		{
			PlayRunning();
			AnimateJump--;
		}
		else
		{
			PlayIdle();
		}
	}
	
	//////////////////////////////////////////
	// Painkiller
	
	void PainkillerHandleMove()
	{
		if(!ZMPlayer.OnGround || (ZMPlayer.OnGround && (((ZMPlayer.cmd.buttons & BT_JUMP) && !BlockJump) || DashNumber)))
		{
			PainkillerAirMove();
			if(zm_ledgegrab) { LedgeGrabInitiator(); }
		}
		else
		{
			MaxGroundSpeed *= SpeedMulti();
			PainkillerGroundMove();
			Grappled = False;
			if(zm_dropprevention) { DropPrevention(); }
		}
	}
	
	void PainkillerFriction()
	{
		//Going too slow, stop
		if(WaterLevel >= 2 || bNOGRAVITY)
		{
			if(Vel.Length() < 1.f)
			{
				Vel.XY = (0, 0);
				return;
			}
		}
		else if(Vel.XY.Length() < 1.f)
		{
			Vel.XY = (0, 0);
			return;
		}
		
		Float Friction; //I modded PK to print to console the length of the velocity vector and it increased and decreased by a fixed value
		if(WaterLevel >= 2 || bNOGRAVITY)
		{
			Friction = MaxGroundSpeed / (WaterLevel >= 2 ? 2.f : 10.f);
			
			if(Vel.Length() >= Friction)
				Vel -= Friction * SafeUnit3(Vel);
			else if(Vel.Length())
				Vel -= Vel.Length() * SafeUnit3(Vel);
		}
		else
		{
			Friction = MaxGroundSpeed / (12.f - zm_friction);
			
			if(Vel.XY.Length() >= Friction)
				Vel.XY -= Friction * SafeUnit2(Vel.XY);
			else if(Vel.XY.Length())
				Vel.XY -= Vel.XY.Length() * SafeUnit2(Vel.XY);
		}
	}
	
	void PainkillerValuesReset()
	{
		MaxAirSpeed = ActualMaxAirSpeed = max(Vel.XY.Length(), MaxGroundSpeed / 4.f);
		SmallerJumpHeight = TrickFailed = 0;
		AirControl = 1;
	}
	
	void PainkillerGroundMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//Values Reset
		PainkillerValuesReset();
		
		//====================================
		//Actual Movement
		
		//Directional inputs
		Acceleration.XY = (cmd.forwardmove, - cmd.sidemove);
		Acceleration.XY = MaxGroundSpeed * 0.6f * SafeUnit2(Acceleration.XY);
		
		//Friction
		PainkillerFriction();
		
		//Acceleration
		Vel.XY += RotateVector(Acceleration.XY, Angle);
		
		//Limiter
		Vel.XY = min(Vel.XY.Length(), MaxGroundSpeed) * SafeUnit2(Vel.XY);
		
		//Sprite Animation
		GroundSpriteAnimation();
	}
	
	void PainkillerAirMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		Vector2 DirInput = SafeUnit2((cmd.forwardmove, - cmd.sidemove));
		ActualMaxAirSpeed = Vel.XY.Length(); //if speed is forcefully lowered due to impact with walls or actors we need to get along with that. Not lowering going up stairs
		
		if(!TrickFailed)
		{
			//Air Control
			AirControlCheck(DirInput.Length());
			//Trickjump check
			if(DirInput.Length()) { TrickJumpCheck(DirInput); }
		}
		
		if(ZMPlayer.OnGround) //ground hop
		{
			if(TrickFailed) //Trick jump failed
			{
				Acceleration.XY = MaxAirSpeed * DirInput;
				MaxAirSpeed = MaxGroundSpeed / 2.f; //penalty
				Vel.XY = RotateVector(Acceleration.XY, Angle); //redirect movement in the pressed direction before applying the uber low air control
				AirControl = 0.01f;
				TrickFailed = False;
			}
			else if(AirControl == 1) //regular movement
			{
				//Directional inputs
				Acceleration.XY = MaxAirSpeed * DirInput;
				
				//Top Speed
				if(ZMPlayer.CrouchFactor == 1) { MaxAirSpeed = clamp(Vel.XY.Length() + pk_acceleration * ActualSpeed, MaxGroundSpeed, zm_maxhopspeed); } //no cheap speed up coming out of QSlide
				ActualMaxAirSpeed = MaxAirSpeed;
			}
			else
			{
				//Top Speed
				MaxAirSpeed = clamp(Vel.XY.Length() - pk_acceleration * ActualSpeed, MaxGroundSpeed, zm_maxhopspeed);
			}
			
			//Acceleration
			Vel.XY += RotateVector(Acceleration.XY, Angle) * AirControl;
			
			//Limiter
			Vel.XY = min(Vel.XY.Length(), MaxAirSpeed) * SafeUnit2(Vel.XY);
		}
		else //mid air
		{
			if(TrickFailed) //Trick jump failed
			{
				PainkillerFriction();
			}
			else //regular movement
			{
				//Acceleration
				Vel.XY += RotateVector(Acceleration.XY, Angle) * AirControl;
				
				//Top speed penality
				TopSpeedPenality();
				
				//Limiter
				Vel.XY = min(Vel.XY.Length(), ActualMaxAirSpeed) * SafeUnit2(Vel.XY);
			}
		}
		
		//Sprite Animation
		AirSpriteAnimation();
	}
	
	void AirControlCheck(Bool DirInput)
	{
		if(!DirInput || Pain)
		{
			AirControl = 0.01f;
			if(!DirInput && Vel.XY.Length() <= 1.f)
			{
				Acceleration.XY = (0, 0);
				Vel.XY = (0, 0);
			}
		}
		else
		{
			AirControl = 1;
		}
	}
	
	void TrickJumpCheck(Vector2 DirInput)
	{
		Bool BadTrick = SafeUnit2(Acceleration.XY) dot DirInput <= 0;
		
		if(abs(FloorZ - Pos.Z) > 16)
		{
			if(BadTrick)
				TrickFailed = True;
			else
				TrickJumpAngle = Angle;
		}
		else
		{
			if(BadTrick && abs(Angle - TrickJumpAngle) < 90) { TrickFailed = True; }
		}
	}
	
	void TopSpeedPenality()
	{
		//Directional change top speed penalty
		Float AbsViewAngleDelta = abs(ViewAngleDelta);									//In Painkiller speed punishment
		if(AbsViewAngleDelta >= 3.f)													//is 5 times the angle variation,		
			ActualMaxAirSpeed -= AbsViewAngleDelta * 0.01f; //this feels good			//although in that engine view angle
		else																			//is 0 to pi for real world 0 to 180,
			ActualMaxAirSpeed += 0.2f; //this too										//and -pi to 0 for 180 to 360.
		
		ActualMaxAirSpeed = clamp(ActualMaxAirSpeed, MaxGroundSpeed, MaxAirSpeed);		//This is an as close as possible imitation
	}
	
	void PainkillerWaterMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//Value Resets
		PainkillerValuesReset();
		
		//====================================
		//Actual Movement
		
		//Directional inputs
		Acceleration = (cmd.forwardmove, -cmd.sidemove, 0);
		//XY
		Acceleration.XY = (MaxGroundSpeed / 2.f) * SafeUnit2(Acceleration.XY);
		//Z
		if(cmd.buttons & BT_JUMP || cmd.buttons & BT_CROUCH)
		{
			Acceleration.Z = (cmd.buttons & BT_JUMP ? 1 : -1) * 30.f * ActualSpeed;
		}
		else
		{
			Acceleration.Z = Acceleration.X * sin(-Pitch);
			Acceleration.X *= cos(Pitch);
		}
		
		//Friction
		PainkillerFriction();
		
		//Acceleration
		Vel += (RotateVector(Acceleration.XY, Angle), Acceleration.Z);
		
		//Limiter
		Vel = min(Vel.Length(), MaxGroundSpeed / 2.f) * SafeUnit3(Vel);
		
		//Sprite Animation
		GroundSpriteAnimation();
		
		//Set acceleration for when you stop swimming
		Acceleration.XY = 30.f * SafeUnit2(Acceleration.XY);
	}
	
	void PainkillerFlyMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//Value Resets
		PainkillerValuesReset();
		
		//====================================
		//Actual Movement
		
		//Directional inputs
		Acceleration = (cmd.forwardmove, -cmd.sidemove, 0);
		//XY
		Acceleration.XY = (MaxGroundSpeed * 3.f) / 2.f * SafeUnit2(Acceleration.XY);
		//Z
		if(cmd.buttons & BT_JUMP || cmd.buttons & BT_CROUCH)
		{
			Acceleration.Z = (cmd.buttons & BT_JUMP ? 1 : -1) * 30.f * ActualSpeed;
		}
		else
		{
			Acceleration.Z = Acceleration.X * sin(-Pitch);
			Acceleration.X *= cos(Pitch);
		}
		
		//Friction
		PainkillerFriction();
		
		//Acceleration
		Vel += (RotateVector(Acceleration.XY, Angle), Acceleration.Z);
		
		//Limiter
		Vel = min(Vel.Length(), (MaxGroundSpeed * 3.f) / 2.f) * SafeUnit3(Vel);
		
		//Sprite Animatiom
		PlayIdle();
		
		//Set acceleration for when the flight ends
		Acceleration.XY = 30.f * SafeUnit2(Acceleration.XY);
	}
	
	//====================================
	// Quake
	
	void QuakeFriction(float StopSpeed, float Friction)
	{
		if(WaterLevel >= 2 || bNOGRAVITY)
		{
			if(Vel.Length() < 0.5f)
			{
				Vel.XY = (0, 0);
				return;
			}
		}
		else if(Vel.XY.Length() < 1.f)
		{
			Vel.XY = (0, 0);
			return;
		}
		
		if(FloorAngle >= 45 && ZMPlayer.OnGround) //lower friction on steep slopes
		{
			StopSpeed *= 4;
			Friction /= 4;
		}
		
		Double Velocity = Vel.Length();
		Double Drop, Control;
		if(WaterLevel >= 2)
		{
			drop = Velocity * Friction / TICRATE; //very tight friction
		}
		else if(bNOGRAVITY)
		{
			drop = Velocity * Friction / TICRATE; //loose friction
		}
		else if(ZMPlayer.OnGround)
		{
			if(!Pain)
			{
				Control = Velocity < StopSpeed ? zm_friction : Velocity;
				Drop = Control * Friction / TICRATE;
			}
		}
		
		Double NewVelocity = (Velocity - Drop <= 0 ? 0 : Velocity - Drop) / Velocity;
		if(WaterLevel >= 2 || bNOGRAVITY)
			Vel *= NewVelocity;
		else
			Vel.XY *= NewVelocity;
	}
	
	void QuakeAcceleration(Vector3 WishDir, Float WishSpeed, Float Accel)
	{
		Float CurrentSpeed = WishDir dot Vel;
		Float AddSpeed = WishSpeed - CurrentSpeed;
		if(AddSpeed <= 0) { return; }
		
		Float AccelerationSpeed = min(Accel * WishSpeed / TICRATE, AddSpeed);
		Vel += AccelerationSpeed * WishDir;
	}
	
	//////////////////////////////////////////
	// Crouching							//
	//////////////////////////////////////////
	
	//====================================
	// Regular crouching
	
	Override void CheckCrouch(bool totallyfrozen)
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		if(cmd.buttons & BT_JUMP)
		{
			cmd.buttons &= ~BT_CROUCH;
		}
		
		if(ZMPlayer.health > 0)
		{
			if(!totallyfrozen)
			{
				int crouchdir = ZMPlayer.crouching;
				
				if(bNOGRAVITY || WaterLevel >= 2) //forcefully uncrouch when flying/swimming
					crouchdir = 1;
				else if(crouchdir == 0)
					crouchdir = (cmd.buttons & BT_CROUCH) ? -1 : 1;
				else if(cmd.buttons & BT_CROUCH)
					ZMPlayer.crouching = 0;
				
				if(crouchdir == 1 && ZMPlayer.crouchfactor < 1 && pos.Z + height < ceilingz)
					CrouchMove(1);
				else if(crouchdir == -1 && ZMPlayer.crouchfactor > 0.5)
					CrouchMove(-1);
			}
		}
		else
		{
			ZMPlayer.Uncrouch();
		}

		ZMPlayer.crouchoffset = -(ViewHeight) * (1 - ZMPlayer.crouchfactor);
	}
	
	Override void CrouchMove(int direction)
	{
		double defaultheight = FullHeight;
		double savedheight = Height;
		double crouchspeed = (CanCSlide && zm_crouchslide == 1 ? - 1.5 : direction) * CROUCHSPEED;
		double oldheight = ZMPlayer.viewheight;

		ZMPlayer.crouchdir = direction;
		ZMPlayer.crouchfactor += crouchspeed;

		// check whether the move is ok
		Height  = defaultheight * ZMPlayer.crouchfactor;
		if(!TryMove(Pos.XY, false, NULL))
		{
			Height = savedheight;
			if(direction > 0)
			{
				// doesn't fit
				ZMPlayer.crouchfactor -= crouchspeed;
				return;
			}
		}
		Height = savedheight;

		ZMPlayer.crouchfactor = clamp(ZMPlayer.crouchfactor, 0.5, 1.);
		ZMPlayer.viewheight = ViewHeight * ZMPlayer.crouchfactor;
		ZMPlayer.crouchviewdelta = ZMPlayer.viewheight - ViewHeight;

		// Check for eyes going above/below fake floor due to crouching motion.
		CheckFakeFloorTriggers(pos.Z + oldheight, true);
	}
	
	//////////////////////////////////////////
	// Crouch Sliding
	
	void CSlideInitiator()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		if(WaterLevel >= 2 || bNOGRAVITY) // in the water or flying forbid attempting to start a slide
		{
			CSlideStartTime = 1;
			QSlideDuration = 0;
			A_StopSound(CHAN_BODY);
			return;
		}
		else if(ZMPlayer.CrouchFactor == 1 && CSlideStartTime) // reallow attempting to slide after player stands back up
		{
			CSlideStartTime = 0;
			return;
		}
		else if(!ZMPlayer.OnGround && zm_crouchslide == 2)
		{
			QSlideDuration = abs(Vel.Z) * zm_qslideduration;
		}
		
		if(ZMPlayer.OnGround)
		{
			if(ZMPlayer.CrouchFactor != 1 && !CSlideStartTime)
			{
				if(cmd.forwardmove || cmd.sidemove)
				{
					//Not enough space for a slide
					Double SlideAngle = Angle - VectorAngle(cmd.forwardmove, cmd.sidemove);
					MaximumSlideSpeed = min(zm_cslidestrength * MaxGroundSpeed, zm_maxhopspeed);
					if(!CheckMove(Pos.XY + MaximumSlideSpeed * AngleToVector(SlideAngle))) { return; }
					
					if(zm_crouchslide == 1)
					{
						CanCSlide = True;
						A_PlaySound("slide",CHAN_BODY);
						Vel.XY = MaximumSlideSpeed * AngleToVector(SlideAngle);
					}
					else if(QSlideDuration)
					{
						CanCSlide = True;
						MaximumSlideSpeed = Vel.XY.Length();
					}
				}
				
				CSlideStartTime = Level.MapTime;
			}
			else if(!CanCSlide)
			{
				QSlideDuration = 0;
			}
		}
	}
	
	void CSlideMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//Value reset
		MaxAirSpeed = MaxGroundSpeed;
		
		//====================================
		//Actual Movement
		
		//Directional inputs
		Acceleration.XY = RotateVector((cmd.forwardmove, - cmd.sidemove), Angle);
		Acceleration.XY = 2.f * SafeUnit2(Acceleration.XY);
		
		//Friction if time has run out
		if(Level.MapTime > CSlideStartTime + zm_cslideduration)
		{
			Int FrictionDiv = abs(FloorZ - Pos.Z) > 16 ? 500 : 100;
			MaximumSlideSpeed *= 1 - Vel.XY.Length() / FrictionDiv;
		}
			
		//Acceleration
		Vel.XY += Acceleration.XY;
		
		//Limiter
		Vel.XY = MaximumSlideSpeed * SafeUnit2(Vel.XY);
		
		//Sprite animation
		PlayIdle();
		
		///////////////////////////////////////////
		//Fun is over
		if(WaterLevel >= 2 || bNOGRAVITY || MaximumSlideSpeed <= MaxGroundSpeed || !CheckMove(Pos.XY + Vel.XY))
		{
			CSlideStartTime = 1;
			CanCSlide = False;
		}
	}
	
	void QSlideMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		A_PlaySound("WallSlide", CHAN_BODY, 0.5, True);
		
		//====================================
		//Actual Movement
		
		//Directional inputs
		Acceleration.XY = (cmd.forwardmove, - cmd.sidemove);
		
		//Friction
		QuakeFriction(MaxGroundSpeed, 6.f);
		
		//Acceleration
		Vector2 PreAccelVel = Vel.XY;
		QuakeAcceleration((RotateVector(SafeUnit2(Acceleration.XY), Angle), 0), max(MaximumSlideSpeed, MaxGroundSpeed), zm_qslideaccel);
		
		//Decrease slide duration depending on how tight turns are
		QSlideDuration--;
		Float SlideRemoveTime = SafeUnit2(PreAccelVel) dot SafeUnit2(Vel.XY);
		SlideRemoveTime = (SlideRemoveTime - 0.99) * 100;
		QSlideDuration -= 1 - SlideRemoveTime;
		
		//Sprite animation
		PlayIdle();
		
		//====================================
		//Fun is over
		if(QSlideDuration <= 0 || abs(FloorZ - Pos.Z) > 16 || !Acceleration.XY.Length() || ZMPlayer.CrouchFactor == 1)
		{
			CSlideStartTime = QSlideDuration = CanCSlide = 0;
			A_StopSound(CHAN_BODY);
		}
	}
	
	//////////////////////////////////////
	// Dashing							//
	//////////////////////////////////////
	
	void DoubleTapCheck()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		Int	MaxTapTime = CVar.GetCVar("zm_maxtaptime", Player).GetInt();
		Int TapValue = (cmd.buttons & BT_FORWARD) + (cmd.buttons & BT_BACK) + (cmd.buttons & BT_MOVERIGHT) + (cmd.buttons & BT_MOVELEFT);
		Int	SecondTapValue;
		
		if(TapValue & ~OldTapValue)
		{
			if(!FirstTapValue)
			{
				FirstTapTime = Level.MapTime;
				FirstTapValue = TapValue;
			}
			else
			{
				if(TapValue != FirstTapValue)
				{
					FirstTapTime = FirstTapValue = 0;
				}
				else
				{
					SecondTapValue = TapValue;
				}
			}
		}
		
		if((FirstTapValue && SecondTapValue) || Level.Maptime > FirstTapTime + MaxTapTime)
		{
			if(SecondTapValue && Level.MapTime <= FirstTapTime + MaxTapTime) { DashInitiator(); }
			FirstTapValue = FirstTapTime = 0;
		}
		
		OldTapValue = TapValue;
	}
	
	void DashInitiator()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		if(WaterLevel >= 2 || bNOGRAVITY || ZMPlayer.CrouchFactor != 1 || LedgeGrabbed || CeilingZ - FloorZ <= Height || TrickFailed)
		{
			CheckForWJump = 0;
			Return;
		}
			
		///////////////////////////////////////////////////////
		
		//Ground Dash
		if(zm_dash && ZMPlayer.OnGround && !((cmd.buttons & BT_JUMP) & !BlockJump) && !DashCooler && (cmd.sidemove || cmd.forwardmove) && !CheckForWJump && !BlockJump)
		{
			Vector2 ProjectedVelXY = zm_dashboost * MaxGroundSpeed * AngleToVector(Angle - VectorAngle(cmd.forwardmove , cmd.sidemove));
			if(CheckMove(Pos.XY + ProjectedVelXY)) { Dash(ProjectedVelXY); }
			return;
		}
		
		if(ADashCooler) { return; }
		
		//Wall Jump
		if(!ZMPlayer.OnGround && zm_wjump)
		{
			if(!CheckForWJump)
			{
				CheckForWJump = 6;
				if(!WJumpSpeed) { WJumpSpeed = Vel.XY.Length(); } //this little trick helps make it feel much better
			}
			else
			{
				CheckForWJump--;
			}
			
			if(cmd.sidemove || cmd.forwardmove)
			{
				//Wall proximity check
				FLineTraceData WallCheck;
				Double WallAngle, WallDistance;
				Float DistanceCheck = Radius + 16;
				
				for(int w = 0; w < 8; w++)
				{
					LineTrace(w * 45, DistanceCheck, 0, 0, data: WallCheck);
					
					if(WallCheck.Distance < DistanceCheck)
					{
						if((!WallDistance || WallCheck.Distance <= WallDistance) && WallCheck.HitType == TRACE_HitWall) //Check for the minimum distance
						{
							WallDistance = WallCheck.Distance;
							WallAngle = VectorAngle(WallCheck.HitLine.Delta.X, WallCheck.HitLine.Delta.Y);
						}
					}
				}
				
				if(WallDistance)
				{
					//Check player is moving away from the wall
					Double WJumpAngle = Angle - VectorAngle(cmd.forwardmove, cmd.sidemove);
					Float DirDelta = AbsAngle(WallAngle, WJumpAngle);
					if(DirDelta > 90) { DirDelta = 180 - DirDelta; }
					
					if(DirDelta > 5)
					{
						//No obstacles near player check
						Float EstimatedWJumpSpeed1 = zm_wjumpboost * MaxGroundSpeed;
						Float EstimatedWJumpSpeed2 = zm_multipledashes + max(WJumpSpeed, Vel.XY.Length());
						WJumpSpeed = min(max(EstimatedWJumpSpeed1, EstimatedWJumpSpeed2), zm_maxhopspeed);
						Vector2 WJumpVector = WJumpSpeed * AngleToVector(WJumpAngle);
						
						if(CheckMove(Pos.XY + WJumpVector))
						{
							CheckForWJump = 0;
							WallJump(WJumpVector);
							return;
						}
						else
						{
							CheckForWJump = 0;
						}
					}
				}				
			}
		}
		else
		{
			CheckForWJump = 0;
		}
		
		//Air Dash
		if(zm_airdash && !ZMPlayer.OnGround && (cmd.sidemove || cmd.forwardmove) && !ADashTargetSpeed)
		{
			Vector2 ADashVector;
			if(Vel.XY.Length() <= MaxGroundSpeed)
			{
				ADashVector = (MaxGroundSpeed + zm_adashboost) * AngleToVector(Angle - VectorAngle(cmd.forwardmove , cmd.sidemove));		
				if(CheckMove(Pos.XY + ADashVector))
				{
					AirDash(ADashVector);
					return;	
				}
			}
			else
			{
				ADashVector = zm_adashboost * AngleToVector(Angle - VectorAngle(cmd.forwardmove , cmd.sidemove));
				if(CheckMove(Pos.XY + Vel.XY + ADashVector))
				{
					AirDash(ADashVector);
					return;	
				}
			}
		}
	}
	
	void DashCommon()
	{
		DashCooler = 102;
		DoubleJumpCooler = 5;
		bONMOBJ = False;
		Jumped = True;
	}
	
	void Dash(Vector2 DashVector)
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		if(DashNumber > 3) { return; }
		DashNumber++;
		DashCommon();
		ADashCooler = 8;
		
		Float DashVelZ = zm_jumpheight * zm_dashheight + ElevatorJumpBoost;
		Float JumpFac = GetPowerJump();
		if(JumpFac) { DashVelZ *= JumpFac; }
		Vel.Z = DashVelZ;
		
		if(!(ZMPlayer.cheats & CF_PREDICTING)) { A_PlaySound("*jump", CHAN_BODY); }
		
		Vel.XY = DashVector;
		MaxAirSpeed = min(Vel.XY.Length(), zm_maxhopspeed);
		
		SmallerJumpHeight++;
		Acceleration.XY = 30.f * SafeUnit2((cmd.forwardmove, - cmd.sidemove));
	}
	
	void AirDash(Vector2 ADashVector)
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		DashNumber++;
		DashCommon();
		ADashCooler = 53;
		
		if(!(ZMPlayer.cheats & CF_PREDICTING) && !JumpSoundCooler) { A_PlaySound("*jump", CHAN_BODY); }
		
		if(Vel.XY.Length() <= MaxGroundSpeed)
		{
			Vel.XY = ADashVector; //this way the air dash always grants a satisfying boost
			ADashTargetSpeed = MaxGroundSpeed + (Vel.XY.Length() - MaxGroundSpeed) / 4;
			ADashFrictionDelay = 8;
		}
		else
		{
			Float PreAirDashSpeed = Vel.XY.Length();
			Vel.XY += ADashVector;
			
			ADashTargetSpeed = min(PreAirDashSpeed + (Vel.XY.Length() - PreAirDashSpeed) / 4, zm_maxhopspeed);
			
			//if going above the speed limit your speed will start decaying immediately
			Float Velocity = Vel.XY.Length();
			if(Velocity > PreAirDashSpeed && Velocity <= zm_maxhopspeed) { ADashFrictionDelay = 8; }
		}
			
		MaxAirSpeed = Vel.XY.Length();
		
		Acceleration.XY = 30.f * SafeUnit2((cmd.forwardmove, - cmd.sidemove));
		ActualMaxAirSpeed = MaxAirSpeed;
	}
	
	void AirDashFriction()
	{
		if(!ADashFrictionDelay)
		{
			if(Vel.XY.Length() > ADashTargetSpeed)
			{
				Vel.XY *= 1 - Vel.Length() / (1000 * zm_adashfriction); //just like in real life air friction is proportional to the speed
				MaxAirSpeed = Vel.XY.Length();
			}
			else
			{
				MaxAirSpeed = ADashTargetSpeed;
				ADashTargetSpeed = 0;
			}
		}
		else
		{
			ADashFrictionDelay--;
		}
	}
	
	void WallJump(Vector2 WJumpVector)
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//Stop any eventual WallSlideMove
		StopWSlide();
		
		DashNumber++;
		DashCommon();
		ADashCooler = 8;
		if(DashNumber <= 3)
		{
			Float DashVelZ = zm_jumpheight * zm_dashheight;
			Float JumpFac = GetPowerJump();
			if(JumpFac) { DashVelZ *= JumpFac; }
			Vel.Z = DashVelZ;
		}
		
		if(zm_wjdoublejumprenew) { CanDoubleJump = True; }
		if(!(ZMPlayer.cheats & CF_PREDICTING) && !JumpSoundCooler) { A_PlaySound("*jump", CHAN_BODY); }
		
		Vel.XY = WJumpVector;
		MaxAirSpeed = min(Vel.XY.Length(), zm_maxhopspeed);
		
		SmallerJumpHeight++;
		ActualMaxAirSpeed = MaxAirSpeed;
		Acceleration.XY = 30.f * SafeUnit2((cmd.forwardmove, - cmd.sidemove));
	}
	
	//////////////////////////////////////
	// Wall Slide				 		//
	//////////////////////////////////////
	
	void WallSlideInitiator()
	{
		if(ZMPlayer.OnGround || WaterLevel >= 2 || bNOGRAVITY || LedgeGrabbed)
		{
			CheckForWSlide = 0;
			return;
		}
		else if(!CheckForWSlide)
		{
			CheckForWSlide = 24;
		}
		
		CheckForWSlide--;
		
		FLineTraceData DirTrace;
		Int SlideAngleDelta;
		
		if(!WSlideVelocity.Length())
		{
			LineTrace(VectorAngle(Vel.X, Vel.Y), 100, 0, 0, data: DirTrace);
			if(DirTrace.Distance < 100 && DirTrace.HitType == TRACE_HitWall) { WSlideVelocity = Vel.XY; }
		}
		else
		{
			SlideAngleDelta = AbsAngle(VectorAngle(WSlideVelocity.X, WSlideVelocity.Y), VectorAngle(Vel.X, Vel.Y));
		}
		
		if(SlideAngleDelta && SlideAngleDelta <= 45)
		{
			WSlideVelocity =  WSlideVelocity.Length() * SafeUnit2(Vel.XY);
			Vel.XY = WSlideVelocity;
			CanWSlide = True;
			CheckForWSlide = 0;
			return;
		}
	}
	
	void WallSlideMove()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		//====================================================
		//Dumb ways to fail...so many don't waste your time
		
		//Common reasons of failure
		if(!WaterLevel >= 2 || bNOGRAVITY || ZMPlayer.OnGround || (!cmd.forwardmove && !cmd.sidemove))
		{
			StopWSlide();
			return;
		}
		
		//WallCheck
		Float WallDistance;
		FLineTraceData SlideWallCheck;
		Int i;
		for(i = 0; i < 8; i++)
		{
			LineTrace(i * 45, (Radius * 3) / 2, 0, 0, data: SlideWallCheck);
			if(!WallDistance || SlideWallCheck.Distance <= WallDistance) { WallDistance = SlideWallCheck.Distance; }
		}
		if(WallDistance >= (Radius * 3) / 2)
		{
			StopWSlide();
			return;
		}
		
		//Moving away from wall
		Float WishDirection = Angle - VectorAngle(cmd.forwardmove, cmd.sidemove);
		Float VelAngle = VectorAngle(Vel.X, Vel.Y);
		Float DirAngle = AbsAngle(WishDirection, VelAngle);
		if(DirAngle >= 30)
		{
			StopWSlide();
			return;
		}
		
		//Wall changed angle, adjust slide velocity
		Int SlideAngleDelta = AbsAngle(VectorAngle(WSlideVelocity.X, WSlideVelocity.Y), VelAngle);
		if(SlideAngleDelta && SlideAngleDelta <= 30)
		{
			WSlideVelocity = WSlideVelocity.Length() * SafeUnit2(Vel.XY);
			Vel.XY = WSlideVelocity; //needed to not make velocity check fail
		}
		else if(SlideAngleDelta > 30)
		{
			StopWSlide();
			return;
		}
		
		//Too slow
		if(Vel.XY.Length() < MaxGroundSpeed)
		{
			StopWSlide();
			return;
		}
		
		//==============================================
		
		Vel.XY = WSlideVelocity;
		Vel.Z *= zm_wslidevelz;
		A_PlaySound("WallSlide", CHAN_BODY, 0.3, True);
		
		//Sprite animation
		PlayIdle();
	}
	
	void StopWSlide()
	{
		CanWSlide = False;
		WSlideVelocity = (0, 0);
		A_StopSound(CHAN_BODY);
	}
	
	//////////////////////////////////////
	// Ledge Grab						//
	//////////////////////////////////////
	
	void LedgeGrabInitiator()
	{
		//Already ledge grabbing, no clipping, moving away from where you are looking, ceiling already too low for sure
		if(LedgeGrabbed || (ZMPlayer.Cheats & CF_NOCLIP2) || Vel.XY dot AngleToVector(Angle) <= 0 || CeilingZ <= Pos.Z + Height * 1.6f) { return; }
		
		//============================================
		//Find ledge (if any)						//
		//============================================
		
		FLineTraceData LedgeTrace;
		Float TraceDistance = sqrt(2) * Radius + 1; //account for the fact that Doom's hitboxes are square
		LineTrace(Angle, TraceDistance, 0, TRF_BLOCKSELF|TRF_THRUACTORS, Height * 1.2f, data: LedgeTrace);
		Vector3 HitPos = LedgeTrace.HitLocation;
		
		Int LedgeCandidate;
		if(LedgeTrace.HitType == TRACE_HitWall) //hit wall scenario
		{
			if(LedgeTrace.Hit3DFloor != NULL) //3D floor
			{
				LedgeCandidate = LedgeTrace.Hit3DFloor.Top.ZAtPoint(HitPos.XY);
			}
			else //regular wall
			{
				Line HitLine = LedgeTrace.HitLine;
				if(HitLine.FrontSector != NULL && HitLine.FrontSector != CurSector)
					LedgeCandidate = HitLine.FrontSector.FloorPlane.ZatPoint(HitPos.XY);
				else if(HitLine.BackSector != NULL && HitLine.BackSector != CurSector)
					LedgeCandidate = HitLine.BackSector.FloorPlane.ZatPoint(HitPos.XY);
			}
		}
		else if(LedgeTrace.HitSector != CurSector)//tracer stopper mid air in a sector that is not the one where player currently is
		{
			LedgeCandidate = LedgeTrace.HitSector.NextLowestFloorAt(HitPos.X, HitPos.Y, HitPos.Z, FFCF_3DRESTRICT, 0);
		}
		else
		{
			return;
		}
		
		//Check if the candidate ledge can suffice
		if(LedgeCandidate > Pos.Z + Height * 0.6f && LedgeCandidate <= Pos.Z + Height * 1.2f)
		{	
			Vector3 OrigPos = Pos;
			SetXYZ((Pos.XY, LedgeCandidate));
			if(!CheckMove(Pos.XY + 5.f * AngleToVector(Angle))) //not enough space, cancel everything :(
			{
				SetXYZ(OrigPos);
				return;
			}
			SetXYZ(OrigPos);
			LedgeHeight = LedgeCandidate;
		}
		else
		{
			return; //too high/low
		}
		
		//============================================
		//Abemus ledge, execute						//
		//============================================
		
		//Switch to a weapon that forbids firing during the ledge grab
		ReselectWeapon = ZMPlayer.ReadyWeapon;
		GiveInventory("LedgeGrabWeapon", 1);
		ZMPlayer.ReadyWeapon = Null;
		Let AssignWeapon = LedgeGrabWeapon(FindInventory("LedgeGrabWeapon"));
		ZMPlayer.PendingWeapon = AssignWeapon;
		
		//Reset dash stuff just in case
		MaxAirSpeed = ADashTargetSpeed;
		DashCooler = ADashCooler = ADashTargetSpeed = WJumpSpeed = DashNumber = 0;
		
		//Allow ledge grab
		A_StopSound(CHAN_WEAPON); 	//stop looping weapon sounds
		StopHook();					//stop hook, not needed but just in case
		LedgeAngle = Angle;
		A_PlaySound("Climb", CHAN_BODY);
		LedgeGrabbed = True;
	}
	
	void LedgeGrab()
	{
		LedgeTime++;
		if(Pos.Z >= LedgeHeight || !Vel.Length() || LedgeTime >= 35)
		{
			//End Ledge Grab
			ZMPlayer.PendingWeapon = ReselectWeapon;
			TakeInventory("LedgeGrabWeapon", 1);
			LedgeGrabbed = LedgeTime = LedgeHeight = 0;
			//Only if ledge grab was successful
			if(LedgeTime >= 35) { return; }
			Vel = Vel.Length() ? (5.f * AngleToVector(LedgeAngle), -3) : (0, 0, 0); //push player forward and downward
			A_PlaySound("*land", CHAN_BODY);
		}
		else
		{
			Vel = Vel.Length() ? (0, 0, 8) : (0, 0, 0);
		}
		
		//Sprite animation
		PlayIdle();
	}
	
	//////////////////////////////////////
	// Grappling Hook					//
	//////////////////////////////////////
	
	void FireHook()
	{
		//Heavy metal music stops
		if(WaterLevel >= 2 || bNOGRAVITY) { return; }
		
		//Third click, detach hook
		if(PendulumLength || (GrappleVel.Length() && zm_hook == 1))
		{
			StopHook();
			return;
		}
		
		//Second click, activate pendulum physics
		if(GrappleVel.Length() && zm_hook == 2)
		{
			Float RopePitch = atan2(Rope.XY.Length(), Rope.Z);
			//Trust me, it's better if you do not see what happens otherwise
			if(RopePitch >= 90.f)
			{
				StopHook();
				return;
			}
			//Initiate pendulum
			PendulumLength = Rope.Length();
			RopePitch *= (Vel.Z < 0 ? -1 : 1);
			Float SwingPitch = RopePitch + 90;
			Float SwingAngle = VectorAngle(Vel.X, Vel.Y);
			Vel = GrappleVel.Length() * (sin(SwingPitch) * cos(SwingAngle), sin(SwingPitch) * sin(SwingAngle), cos(SwingPitch));
			GrappleVel = Vel;
			return;
		}
		
		//First click, fire hook
		if(HookFired || Grappled) { return; }
		A_PlaySound("HookLaunch", 7, 0.8);
		//Why actor projectile firing functions do not have a pitch parameter?
		FLineTraceData CrossHairProjection; LineTrace(Angle, 10000, Pitch, 0, ZMPlayer.ViewHeight, data: CrossHairProjection);
		Float PitchOffset = VectorAngle(CrossHairProjection.Distance, -AttackZOffset);
		Pitch += PitchOffset;
		HookFired = SpawnPlayerMissile("Hook", Angle, 0, 0, -AttackZOffset); //SpawnPlayerMissile fires a projectile at 8/14 of Player Height, I need it to be fired at half
		Pitch -= PitchOffset;
		//Set hook to move faster the faster player is moving
		HookFired.Vel += Vel;
	}
	
	bool HookLOS()
	{
		Float LOSPitch = atan2(Rope.XY.Length(), Rope.Z) - 90;
		Float LOSAngle = VectorAngle(Rope.X, Rope.Y);
		FLineTraceData LOSCheck; LineTrace(LOSAngle, Rope.Length(), LOSPitch, TRF_SOLIDACTORS|TRF_BLOCKSELF, Height / 2.f, data: LOSCheck);
		
		if(GrappledMonster != Null && LOSCheck.HitActor == GrappledMonster) { return true; }
		
		return LOSCheck.Distance == Rope.Length();
	}
	
	void GrapplingMove()
	{
		if(!ZMPlayer.OnGround) { Grappled = True; }
		
		//Fun is over kids, go home
		if((ZMPlayer.OnGround && Grappled) || WaterLevel >= 2 || bNOGRAVITY || Rope.Length() <= 4.f * Radius || !CheckMove(Pos.XY + Vel.XY) || !HookLOS())
		{
			StopHook();
			return;
		}
		
		//All good
		if(PendulumLength)
		{
			//Reached the peak
			Float RopePitch = atan2(Rope.XY.Length(), Rope.Z);
			if(RopePitch >= 90)
			{
				StopHook();
				return;
			}
			
			Vector3 SwingVel;
			if(Vel.Z < 0)
			{
				SwingVel = (GrappleVel.X, GrappleVel.Y, GrappleVel.Z - zm_setgravity);
			}
			else
			{
				SwingVel = (GrappleVel.X, GrappleVel.Y, GrappleVel.Z - zm_setgravity / 2.f);
				RopePitch *= -1;
			}
			Float SwingPitch = RopePitch + 90;
			Float SwingAngle = VectorAngle(Vel.X, Vel.Y);
			Vel = SwingVel.Length() * (sin(SwingPitch) * cos(SwingAngle), sin(SwingPitch) * sin(SwingAngle), cos(SwingPitch));
			
			//Rope tension
			Float Tension = Rope.Length() - PendulumLength;
			if(Tension) { Vel += Tension * SafeUnit3(Rope); }
			
			//Limiter
			MaxAirSpeed = min(Vel.XY.Length(), zm_maxhopspeed);
			Vel.XY = MaxAirSpeed * SafeUnit2(Vel.XY);
			
			GrappleVel = Vel;
		}
		else
		{
			GrappleVel = SafeUnit3(Rope) * GrappleVel.Length();
			Vel = GrappleVel;
		}
		
		//Sprite animation
		PlayIdle();
	}
	
	void StopHook()
	{
		Rope = GrappleVel = (0, 0, 0);
		PendulumLength = 0;
		GrappledMonster = Null;
	}
	
	//////////////////////////////////////
	// Bobbing							//
	//////////////////////////////////////
	
	void BobWeaponAuxiliary()
	{
		Usercmd cmd = ZMPlayer.cmd;
		
		Float Velocity = min(Vel.XY.Length(), zm_maxgroundspeed);
		Bool  InTheAirNoOffset = CanWSlide || CanCSlide || GrappleVel.Length() || bNOGRAVITY || WaterLevel >= 2;
		Bool  InTheAir = Jumped || abs(FloorZ - Pos.Z) > 16 || InTheAirNoOffset;
		
		//////////////////////////////////////////
		//Bobbing counter						//
		/////////////////////////////////////////
		
		DoBob = (cmd.forwardmove || cmd.sidemove) && Velocity > 1.f && !InTheAir && !VerticalOffset;
		if(DoBob || BobRange)
			BobTime += Velocity / zm_maxgroundspeed;
		else
			BobTime = 0;
		
		//////////////////////////////////////////
		//Horizontal sway and Vertical offset	//
		//////////////////////////////////////////
		
		Let PWeapon = ZMPlayer.ReadyWeapon;
		if(PWeapon == Null || PWeapon.bDontBob || !(ZMPlayer.WeaponState & WF_WEAPONBOBBING))
		{
			HorizontalSway = VerticalOffset = 0;
			return;
		}
		
		Let WeaponSprite = ZMPlayer.PSprites;
		if(WeaponSprite == Null) { return; }
		
		//=========================================
		//Horizontal Sway
		
		if(CVar.GetCVar("zm_sway", Player).GetBool())
		{
			HorizontalSway += (CVar.GetCVar("zm_swaydirection", Player).GetBool() ? -1 : 1) *
						       ViewAngleDelta * CVar.GetCVar("zm_swayspeed", Player).GetFloat() / 10;
			Int SwayRange = CVar.GetCVar("zm_swayrange", Player).GetInt();
			HorizontalSway = clamp(HorizontalSway, -SwayRange, SwayRange);
			
			if(HorizontalSway)
			{
				Float Realign = min(abs(HorizontalSway), SwayRange - 1);
				HorizontalSway *= Realign / SwayRange * (abs(HorizontalSway) > BOB_MIN_REALIGN);
			}
			
			WeaponSprite.X = HorizontalSway;
		}
		
		//=========================================
		//Vertical offset
		
		if(CVar.GetCVar("zm_offset", Player).GetBool())
		{
			Int	OffsetRange = CVar.GetCVar("zm_offsetrange", Player).GetInt();
			
			if(InTheAir && !InTheAirNoOffset)
			{
				Float OffsetSpeed = CVar.GetCVar("zm_offsetspeed", Player).GetFloat();
				
				if(!CVar.GetCVar("zm_offsetdirection", Player).GetBool())
				{
					if(Vel.Z >= 0)
						VerticalOffset += OffsetSpeed * Vel.Z * (1. - abs(VerticalOffset) / OffsetRange);
					else
						VerticalOffset += OffsetSpeed * Vel.Z * max(abs(VerticalOffset) / OffsetRange, 1);
				}
				else
				{
					if(Vel.Z >= 0)
						VerticalOffset -= OffsetSpeed * Vel.Z * max(abs(VerticalOffset) / OffsetRange, 1);
					else
						VerticalOffset -= OffsetSpeed * Vel.Z * (1. - abs(VerticalOffset) / OffsetRange);
				}
				VerticalOffset = clamp(VerticalOffset, 0, OffsetRange);
			}
			else if(VerticalOffset)
			{
				Float Realign = min(abs(VerticalOffset), OffsetRange - 1);
				VerticalOffset *= Realign / OffsetRange * (abs(VerticalOffset) > BOB_MIN_REALIGN);
			}
			
			WeaponSprite.Y = VerticalOffset + 32;
		}
	}
	
	void GetBobMulti(double ticfrac) //bobbing range and smooth transitioning
	{
		if(DoBob)
		{
			Double BobRangeCandidate = zm_maxgroundspeed * MoveFactor;
			if(BobRangeCandidate == BobRange) { return; }
			
			if(BobRangeCandidate > BobRange)
				BobRange = min(BobRange + abs(OldTicFrac - ticfrac) * abs(BobRangeCandidate - BobRange) / zm_maxgroundspeed, BobRangeCandidate); //make transitions proportional to frame time for fps consistency
			else
				BobRange = max(BobRange - abs(OldTicFrac - ticfrac) * abs(BobRangeCandidate - BobRange) / zm_maxgroundspeed, BobRangeCandidate); //and make the transition proportional to the value difference
		}
		else if(BobRange)
		{
			BobRange = max(BobRange - abs(OldTicFrac - ticfrac), 0);
		}
		OldTicFrac = ticfrac;
	}
	
	Override Vector2 BobWeapon(double ticfrac)
	{
		if(!ZMPlayer) { return (0, 0); }
		
		let weapon = ZMPlayer.ReadyWeapon;
		if(weapon == null) { return (0, 0); }
		
		Vector2 r;
		GetBobMulti(ticfrac);
		int bobstyle = weapon.BobStyle;
		double RangeY = weapon.BobRangeY;
		if(weapon.bDontBob || !BobRange || !(ZMPlayer.WeaponState & WF_WEAPONBOBBING)) //I should add a variable to do this very cleanly but I don't wanna
		{
			BobRange = BobTime = 0;
			switch(bobstyle)
			{
			case Bob_Dusk:
				r.Y = zm_maxgroundspeed * RangeY;
				break;
				
			case Bob_Painkiller:
				r.Y = zm_maxgroundspeed * RangeY;
				break;
					
			case Bob_UT:
				r.Y = zm_maxgroundspeed * RangeY;
			}
			return r;
		}
		
		double BobSpeed = weapon.BobSpeed * 128;
		double bobx = weapon.BobRangeX * BobRange;
		double boby = RangeY * BobRange;
		Vector2 p1, p2;
		
		for(int i = 0; i < 2; i++)
		{
			double BobAngle = BobSpeed * ZMPlayer.GetWBobSpeed() * (BobTime + i - 1) * (360. / 8192.);
			
			switch(bobstyle)
			{
			case Bob_Normal:
				r.X = bobx * cos(BobAngle);
				r.Y = boby * abs(sin(BobAngle));
				break;
			
			case Bob_Inverse:
				r.X = bobx * cos(BobAngle);
				r.Y = boby * (1. - abs(sin(BobAngle)));
				break;
				
			case Bob_Alpha:
				r.X = bobx * sin(BobAngle);
				r.Y = boby * abs(sin(BobAngle));
				break;
			
			case Bob_InverseAlpha:
				r.X = bobx * sin(BobAngle);
				r.Y = boby * (1. - abs(sin(BobAngle)));
				break;
			
			case Bob_Smooth:
				r.X = bobx * cos(BobAngle);
				r.Y = boby * (1. - (cos(BobAngle * 2))) / 2.f;
				break;
			
			case Bob_InverseSmooth:
				r.X = bobx * cos(BobAngle);
				r.Y = boby * (1. + (cos(BobAngle * 2))) / 2.f;
			
			case Bob_Build:
				r.X = 2. * bobx * cos(BobAngle);	
				r.Y = boby * (1. - abs(sin(BobAngle)));
				break;
			
			case Bob_Dusk:
				r.X = bobx * cos((BobAngle * 2.) / 3.);
				r.Y = boby * (cos(2.2 * BobAngle)) + zm_maxgroundspeed * RangeY;
				break;
			
			case Bob_Painkiller:
				r.X = bobx * cos(BobAngle);	
				r.Y = - boby * (1. - abs(sin(BobAngle))) + zm_maxgroundspeed * RangeY;
				break;
							
			case Bob_UT:
				r.X = 1.5 * bobx * cos(BobAngle);	
				r.Y = boby * sin(2. * BobAngle) + zm_maxgroundspeed * RangeY;
			}
			
			if (i == 0) p1 = r; else p2 = r;
		}
		
		return p1 * (1. - ticfrac) + p2 * ticfrac;
	}
}

Class LedgeGrabWeapon : Weapon
{
	States
	{
		Select:
			TNT1 A 0 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
			TNT1 A 0 A_Raise;
			Loop;
			
		Deselect:
			TNT1 A 0 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
			TNT1 A 0 A_Lower;
			Loop;
			
		Ready:
			TNT1 A 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
			Loop;
			
		Fire:
			TNT1 A 0 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
			Stop;
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////																						////
//// Event Handlers																			////
////																						////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

Class SpeedoMeterHandler : EventHandler
{
	override void renderOverlay(RenderEvent e)
	{
		if(CVar.FindCVar("zm_speedometer").GetInt() && Level.MapName != "TITLEMAP")
		{
			Actor mo = players[consoleplayer].mo;
			if(mo != NULL && PlayerInGame[consoleplayer])
			{
				Int Value = (CVar.FindCVar("zm_speedometer").GetInt() == 2 ? 32 : 10) * mo.Vel.XY.Length();
				Int OffsetX = Confont.StringWidth(String.Format("%d", Value)) / 2;
				Int VScreenX = 768, VScreenY = 480;
				Screen.DrawText(Confont, Font.CR_WHITE, VScreenX / 2 - OffsetX, VScreenY / 2 + 16, String.format("%i", Value),
								DTA_VirtualWidth, VScreenX, DTA_VirtualHeight, VScreenY);
			}
		}
	}
}

Class DashHandler : EventHandler
{
    Override void NetworkProcess(ConsoleEvent e)
    {
        if(e.Player >= 0 && PlayerInGame[e.Player] && Players[e.Player].Mo)
        {
            if(e.Name == "Dash")
            {
                Let DashPlayer = PainkillerPlayer(Players[e.Player].Mo);
                if(DashPlayer) { DashPlayer.DashInitiator(); }
            }
        }
    }
}

Class WallSlideHandler : EventHandler
{
    Override void NetworkProcess(ConsoleEvent e)
    {
		if(!zm_wslide) { return; }
		
        if(e.Player >= 0 && PlayerInGame[e.Player] && Players[e.Player].Mo)
        {
            if(e.Name == "WallSlide")
            {
                Let WSlidePlayer = PainkillerPlayer(Players[e.Player].Mo);
                if(WSlidePlayer) { WSlidePlayer.WallSlideInitiator(); }
            }
        }
    }
}

Class GrapplingHookHandler : EventHandler
{
    Override void NetworkProcess(ConsoleEvent e)
    {
		if(!zm_hook) { return; }
		
        if(e.Player >= 0 && PlayerInGame[e.Player] && Players[e.Player].Mo)
        {
            if(e.Name == "GrapplingHook")
            {
                Let GrapplingPlayer = PainkillerPlayer(Players[e.Player].Mo);
                if(GrapplingPlayer) { GrapplingPlayer.FireHook(); }
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////																						////
//// GrapplingHook																			////
////																						////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

Class Hook : Actor
{
	Default
	{
		+FORCEXYBILLBOARD;
		+HITMASTER;
		+MISSILE;
		+NOGRAVITY;
		+NOTELEPORT;
		+NOTONAUTOMAP;
		+THRUSPECIES;
		Damage 6;
		Height 4;
		Radius 2;
		Speed 80;
		Species "Hook";
	}
	
	vector3 HookToPlayer;
	vector3	HookToMonster;
	int		MonsterSpeed;
	int		MonsterFloatSpeed;
	
	vector3 SafeUnit3(Vector3 VecToUnit)
	{
		if(VecToUnit.Length()) { VecToUnit /= VecToUnit.Length(); }
		return VecToUnit;
	}
	
	vector2 SafeUnit2(Vector2 VecToUnit)
	{
		if(VecToUnit.Length()) { VecToUnit /= VecToUnit.Length(); }
		return VecToUnit;
	}
	
	Override void Tick()
	{
		Let HookOwner = PainkillerPlayer(Target);
		if(HookOwner)
		{
			Vector3 WaistPos = (HookOwner.Pos.X, HookOwner.Pos.Y, HookOwner.Pos.Z + HookOwner.Height / 2.f); // player position
			HookToPlayer = Pos - WaistPos; //hook-to-player vector
		}
		
		Super.Tick();
		
		UpdateTrail();
	}
	
	void UpdateTrail()
	{
		int b;
		for(b = 1; b <= 14; b++)
		{
			ActorIterator BallOfSteele = Level.CreateActorIterator(84115 + b);
			Actor Ball = BallOfSteele.Next();
			
			if(Ball != Null)
			{
				//Set trail velocity
				Vector3 TargetPos = Pos - (HookToPlayer * b / 15.f);
				Ball.Vel = TargetPos - Ball.Pos;
			}
		}
	}
	
	void InitiateGrapple(Bool Monster)
	{
		Let HookOwner = PainkillerPlayer(Target);
		
		Float	PushLength = HookOwner.MaxGroundSpeed * zm_hookboost;
		Vector3 HookPush = SafeUnit3(HookToPlayer) * PushLength;
		Float 	HookSpeed = max((HookOwner.Vel + HookPush).Length(), PushLength);
		HookOwner.Rope = HookToPlayer; //needed for the LOS check
		
		//Check hook is still in sight
		if(!HookOwner.HookLOS())
		{
			SetState(FindState("DespawnHook"));
			return;
		}
		
		//Stop any eventual wall slides
		HookOwner.StopWSlide();
		
		//Stop dashing stuff
		HookOwner.ADashCooler = HookOwner.ADashTargetSpeed = 0;
		
		//Initiate hook
		HookSpeed = HookOwner.MaxAirSpeed = min(HookSpeed, zm_maxhopspeed);
		HookOwner.Vel = HookOwner.GrappleVel = HookSpeed * SafeUnit3(HookPush);
		
		//Hooking monsters specific
		if(Monster)
		{
			Let Monster = Actor(Master);
			PainkillerPlayer(Target).GrappledMonster = Monster;
			SetMonsterSpeed(False);
			A_PlaySound("HookMeat", 7);
		}
		else
		{
			A_PlaySound("HookWall", 7);
		}
	}
	
	void SetMonsterSpeed(Bool Reset)
	{
		Let Monster = Actor(Master);
		
		if(!Reset)
		{
			MonsterSpeed = Monster.Speed;
			MonsterFloatSpeed = Monster.FloatSpeed;
			Monster.Speed = Monster.FloatSpeed = 0;
		}
		else
		{
			Monster.Speed = MonsterSpeed;
			Monster.FloatSpeed = MonsterFloatSpeed;
		}
	}
	
	void SpawnTrail()
	{
		int h;
		for(h = 1; h <= 14; h++)
		{
			A_SpawnItemEx("HookTrail",0,0,0,0,0,0,0,SXF_ISTRACER|SXF_SETTARGET|SXF_ORIGINATOR|SXF_NOCHECKPOSITION);
			
			Let SlaveTrail = HookTrail(Tracer);
			SlaveTrail.ChangeTid(84115 + h);
		}
	}
	
	States
	{
	//====================================
	//Hook is traveling through space
	Spawn:
		OCLW A 0 NoDelay
		{
			A_AlertMonsters();
			SpawnTrail();
		}
	Looper:
		OCLW A 1
		{
			Let HookOwner = PainkillerPlayer(Target);
			//Despawn if no geometry was found
			if(HookToPlayer.Length() >= 1000.f || !HookOwner)
			{
				SetState(FindState("DespawnHook"));
				return;
			}
		}
		Loop;
	
	//====================================
	//Hook hit a wall or ceiling
	Death:
		OCLW A 0
		{
			Let HookOwner = PainkillerPlayer(Target);
			if(!HookOwner)
			{
				SetState(FindState("DespawnHook"));
				return;
			}
			
			InitiateGrapple(False);
		}
	
	TillDeathDoesUsApart:
		OCLW A 1
		{
			Let HookOwner = PainkillerPlayer(Target);
			if(!HookOwner.GrappleVel.Length() || !HookOwner)
			{
				SetState(FindState("DespawnHook"));
				return;
			}
			
			HookOwner.Rope = HookToPlayer;
		}
		Loop;
		
	//====================================
	//Hit actor
	XDeath:
		OCLW A 0
		{
			Let Monster = Actor(Master);
			if(!Monster.bISMONSTER)
			{
				SetState(FindState("DespawnHook"));
				return;
			}
			
			InitiateGrapple(True);
		}
	
	TillXDeathDoesUsApart:
		OCLW A 1
		{
			Let HookOwner = PainkillerPlayer(Target);
			Let Monster = Actor(Master);
			
			if(!HookOwner.GrappleVel.Length() || !HookOwner || Monster.Health <= 0)
			{
				SetState(FindState("DespawnHook"));
				return;
			}
			
			Vel = Monster.Vel;
			HookOwner.Rope = HookToPlayer;
		}
		Loop;
		
	//====================================
	//Die Monster! You don't belong in this world
	DespawnHook:
		OCLW A 0
		{
			Let HookOwner = PainkillerPlayer(Target);
			if(HookOwner)
			{
				HookOwner.StopHook();
				HookOwner.A_PlaySound("HookFailed", 7, 0.2);
			}
			
			Let Monster = Actor(Master);
			if(Monster && MonsterSpeed) { SetMonsterSpeed(True); }
		}
		Stop;
	}
}

Class HookTrail : Actor
{
	Default
	{
		+FORCEXYBILLBOARD;
		+MISSILE;
		+NOGRAVITY;
		+NOTELEPORT;
		+NOTONAUTOMAP;
		+THRUSPECIES;
		Radius 2;
		Height 4;
		Scale 0.5;
		Species "HookTrail";
	}
	
	States
	{
		Spawn:
		Looper:
			TEND A 1
			{
				if(!Hook(Target))
				{
					SetState(FindState("DespawnTrail"));
					return;
				}
			}
			Loop;
			
		Death:
			TEND A 1
			{
				if(!Hook(Target))
				{
					SetState(FindState("DespawnTrail"));
					return;
				}
			}
			Loop;
			
		DespawnTrail:
			Stop;
	}
}