// Deflects non-homing projectiles aimed at player
class PowerDeflect : Powerup 
{
	bool zeroTurn;	// "random" deflection direction when projectile aims directly at player
	
	Default
	{
		Powerup.Duration -60;
		Powerup.Color "ff 80 00", 0.2;
	}
	
	override void InitEffect ()
	{
		Super.InitEffect();
		
		zeroTurn = random(0,1);
	}

	override void DoEffect ()
	{
		Super.DoEffect();
		Actor ob;
		ThinkerIterator iter = ThinkerIterator.Create();

		while (ob = Actor(iter.Next()))
		{
			if (!ob || !ob.bMissile || ob.bSeekermissile || ob.target == Owner) continue;
			
			double v = ob.vel.Length();	// speed of projectile
			double ang = VectorAngle(ob.vel.x, ob.vel.y);	// direction of projectile
			double dist = ob.Distance3D(Owner);	// distance from player

			if (dist > 35*v) continue;	// too far away, no need to deflect
			
			zeroTurn = !zeroTurn;
			
			vector2 vecToPlayer = ob.Vec2To(Owner);	
			double angleToPlayer = VectorAngle(vecToPlayer.x, vecToPlayer.y); // direction from projectile to player
			double angleDelta = deltaangle(ang, angleToPlayer);	// how much the projectile is off
			
			if (abs(angleDelta) > 60) continue;	// not going to player (too much off)
			
			double newDiff;		// new direction difference
			if (angleDelta < 0) newDiff = 3.0;
			else if (angleDelta > 0 || zeroTurn) newDiff = -3.0;
			else newDiff = 3.0;
			
			ang += newDiff;
			double flatVel = sqrt(ob.vel.x*ob.vel.x + ob.vel.y*ob.vel.y);
			ob.vel.x = flatVel * cos(ang);
			ob.vel.y = flatVel * sin(ang);
			ob.angle += newDiff;
			
		}
	}
}
