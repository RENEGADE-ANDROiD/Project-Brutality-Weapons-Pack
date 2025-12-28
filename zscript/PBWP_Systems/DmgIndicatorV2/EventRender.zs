Class D4DHandler : EventHandler
{
	override void OnRegister()
	{
		SetOrder(666);
		Super.OnRegister();
	}
	
	override void WorldLoaded(WorldEvent e)
	{
		ArrowManager = D4VisualDamageManager.Create();
	}
	
	override void RenderOverlay(RenderEvent e)
	{
		RenderDamageIndicators(e);
	}
	
	override void WorldTick()
	{
		TickDamageIndicators();
	}
	
	override void WorldThingDamaged(WorldEvent e)
	{
		Actor damaged =	e.Thing;
		
		if (damaged.player)
		{
			Actor	src = e.DamageSource,
					inf = e.Inflictor;
			if (!src && !inf)
				return;
			//console.printf("Damagetype: (\cd%s\c-).",e.damagetype);
			AddEventDamageIndicator(e);
		}
	
	}
	
	private D4VisualDamageManager ArrowManager;
	
	private ui void RenderDamageIndicators(RenderEvent e)
	{
		if (ArrowManager)
			ArrowManager.Render(e);
	}
	
	private void TickDamageIndicators()
	{
		if (ArrowManager)
			ArrowManager.Tick();
	}
	
	private void AddEventDamageIndicator(WorldEvent e)
	{
		if (ArrowManager)
			ArrowManager.AddIndicator(e.DamageSource, e.Inflictor, e.Thing, e.Damage,e.DamageType);
	}
	
}

//==============================================================================
// Damage Indicators
//==============================================================================

Class D4VisualDamageManager play
{
	private Array<D4DamageIndicator> Arrows;
	private int Timer;
	const ClearTimer = 5 * 5;
	int indtype;
	static D4VisualDamageManager Create()
	{
		let vdm = new('D4VisualDamageManager');
		vdm.Init();
		return vdm;
	}
	
	protected void Init()
	{
		Arrows.Clear();
	}
	
	void AddIndicator(Actor src, Actor inf, Actor plr, int damage = 0, name dmgtype = 'Normal')
	{
		if ((!src && !inf) || !plr || src == plr)
			return;
		
		for (int i = 0; i < Arrows.Size(); i++)
		{
			if (Arrows[i] && Arrows[i].src == src)
			{
				Arrows[i].ResetTimer(plr.player ? cvar.getcvar("D4D_DITimer",plr.player).getint() : -1);
				Arrows[i].col = GetArrowColor(dmgtype);
				//Console.Printf("Updated arrow.");
				return;
			}
		}
		if(plr.player)
			indtype = cvar.GetCVar("D4D_IndicatorType",plr.player).getint();
			
		let arrow = new('D4DamageIndicator');
		arrow.src = src;
		arrow.inf = inf;
		if (src)	arrow.srcpos = src.pos;
		else if ((inf && inf.bMISSILE && inf.target) || inf)
		{
			src = (inf.target) ? inf.target : inf;
			arrow.srcpos = src.pos;
		}
		if (inf)	arrow.infpos = inf.pos;
		
		arrow.col = GetArrowColor(dmgtype);
		
		arrow.plr = plr;
		arrow.highlightreq = false;
		switch(indtype)
		{
			case 1:
				arrow.tex = TexMan.CheckForTexture(D4DamageIndicator.texname,TexMan.Type_Any);
				arrow.htex = TexMan.CheckForTexture(D4DamageIndicator.txthigh,TexMan.Type_Any);
				arrow.highlightreq = true;
				break;
			case 0:
			default:
				arrow.tex = TexMan.CheckForTexture(D4DamageIndicator.texalt,TexMan.Type_Any);
				break;
		}
		
		arrow.type = indtype;
		arrow.ResetTimer(plr.player ? cvar.getcvar("D4D_DITimer",plr.player).getint() : -1);
		arrow.Init();
		Arrows.Push(arrow);
	}
	
	void Tick()
	{
		int size = Arrows.Size();
		if (size < 1)	return;
		
		// Tick all the arrows and keep their information up to date.
		for (int i = 0; i < size; i++)
		{
			if (Arrows[i])
				Arrows[i].Tick();
		}
		
		// Memory management. Remove all empty slots.
		if (++Timer >= ClearTimer)
		{
			Timer = 0;
			Array<D4DamageIndicator> temp; temp.Clear();
			
			for (int i = 0; i < size; i++)
				if (Arrows[i])	temp.Push(Arrows[i]);
			
			Arrows.Move(temp);
		}
	}
	
	ui void Render(RenderEvent e)
	{
		if (Arrows.Size() < 1)
			return;
		
		PlayerInfo plr = players[consoleplayer];
		
		bool disabled;
		let CDEnable = Cvar.GetCvar('D4D_DamageIndicators', plr);
		if(CDEnable)
			disabled = !CDEnable.getbool();
		if(disabled)	return;
		
		let CDIAlpha = Cvar.GetCvar('D4D_DIAlpha', plr);
		let CDIScale = Cvar.GetCvar('D4D_DIScale', plr);
		let CDIAnim  = Cvar.GetCvar('D4D_DIAnim',plr);
		double Alpha = 1.0, Scale = 0.5;
		int AnimType = 0;
		
		
		if (CDIAlpha)	Alpha = CDIAlpha.GetFloat();
		if (CDIScale)	Scale = CDIScale.GetFloat();
		if(CDIAnim)		AnimType = CDIAnim.GetInt();
		
		int size = Arrows.Size();
		for (int i = 0; i < size; i++)
		{
			let arrow = D4DamageIndicator(Arrows[i]);
			if (arrow && arrow.pinfo == plr)
				Arrows[i].Render(e, Alpha, Scale,AnimType);
		}
	}
	
	//damage type based color handling
	//to add a new color for a type, add a case and return a hex color number 
	color GetArrowColor(name damagetype = 'Normal')
	{
		switch(damagetype)
		{
			case 'ExplosiveImpact':
			case 'Explosive':	return color("F2AE24"); 	break;
			
			case 'Electric':	return color("FFFFFF");		break;
			
			case 'Disintegrate': case 'GreenFire': case 'Slime':
			case 'Acid':		return color("00FF00");		break;
			
			case 'incinerate': case 'Burn':
			case 'Fire':		return color("FF5101");		break;
			
			case 'Freeze':
			case 'Ice':			return color("98F5F9"); 	break;
			
			case 'Plasma':		return color("0675F5");		break;
			
			case 'blackhole':
			case 'Void':		return color("B732DC");		break;
			
			case 'Hitscan':
			case 'Normal':
			default:			return color("FF0000");		break;
		}
		return color("FF0000");
	}
}

Class D4DamageIndicator play
{
	const texname = "Graphics/HUD/DmgDir2.png";
	const txthigh = "Graphics/HUD/DmgDir3.png";
	const texalt = "Graphics/HUD/DmgDir4.png";
	Actor inf, src, plr;
	PlayerInfo pinfo;
	Vector3 infpos, srcpos;
	TextureID tex,htex;
	color col;
	int type;
	bool highlightreq;
	private double Alpha, Scale;
	private int Timer,origTimer;
	private bool hadsrc, hadinf;
	private Vector2 siz;
	private Shape2D flat;
	private Shape2DTransform trans;
	
	void Init()
	{
		hadsrc = src != null;
		hadinf = inf != null;
		pinfo = plr.player;
		flat = new("Shape2D");
		
		// simple coords
		flat.PushCoord((0,0));	// 0
		flat.PushCoord((1,0));	// 1
		flat.PushCoord((0,1));	// 2
		flat.PushCoord((1,1));	// 3
		
		// PushTriangle takes INDEXES of coords pushed to it in order from
		// first to last, as numbered above.
		flat.PushTriangle(0,2,1); // (0,0) (0,1) (1,0)
		flat.PushTriangle(2,3,1); // (0,1) (1,1) (1,0)
		
		siz = TexMan.GetScaledSize(tex);
		
		// Create the vertices and push them into the array.
		Vector2 vertices[4];
		vertices[0] = (-siz.x,-siz.y);
		vertices[1] = ( siz.x,-siz.y);
		vertices[2] = (-siz.x, siz.y);
		vertices[3] = ( siz.x, siz.y);
		
		flat.Clear(Shape2D.C_Verts);
		for ( int i=0; i<4; i++ ) flat.PushVertex(vertices[i]);
		
		trans = new('Shape2DTransform');
	}
	
	void ResetTimer(int time = -1)
	{
		if (time < 1)	time = (5 * 5);
		Timer = time;
		origTimer = time;
	}
	
	void Tick()
	{
		if (--Timer < 0 || !plr)
		{
			Destroy();	return;	
		}
		
		if (!src && inf && inf.bMISSILE)
			src = inf.target;
		
		if (src)	srcpos = src.pos;
		if (inf)	infpos = inf.pos;
		
	}
	const ThirtyFifth = (1.0 / 35.0);
	ui void Render( RenderEvent e, double _Alpha, double _Scale,int animType = 0)
	{	
		// Alpha is already clamped below.
		double Alpha = (ThirtyFifth * Timer) * _Alpha;
		double maxalpha = clamp(min(_Alpha,1.0),0.0,1.0);	//use the alpha defined in the option rather than 1.0 always
		double Scale = _Scale;
		if (bDESTROYED || Alpha <= 0.0 || !plr || plr.pos == srcpos || !hadsrc)
			return;
		
		//animations handling
		//nothing fancy, actually
		switch(AnimType)
		{
			case 0:		//expand but subtle
				Scale += LinearMap(timer,0,origTimer,0.1,-0.01);
				break;
				
			case 1:		//shrink fast
				Scale += LinearMap(timer,origTimer,0,0.25,-2.0);
				if(Scale < _Scale)	//go back to its original scale fast
					Scale = _Scale;
				break;
				
			case 2:		//expand fast
				Scale += LinearMap(timer,0,origTimer,1.5,0.0);
				if(Scale > (_Scale + 0.3))
					Scale = _Scale + 0.3;
				break;
			
			case 3:		//shrink subtle
				Scale += LinearMap(timer,origTimer,0,0.08,-0.01);
				if(Scale < _Scale)	//go back to its original scale
					Scale = _Scale;
				break;
				
			case 4:		//silly and weird blink
				if(alpha >= maxalpha - (maxalpha * 0.1))
				{
					Alpha -= (timer % (origTimer / 5)) * 0.2; 
				}
				else
				{
					double oa = Alpha;	//this could be far better done, but idk, it works for now
					Alpha -= (timer % (origTimer / 5)) * 0.2;
					Alpha = Clamp(Alpha,0.0,oa);
				}
				break;
				
			default:	//none
				break;
		}
		
		// Grab the player preferences.
		trans.Clear();
		
		// Rotate the damage indicator towards the one responsible.
		Vector3 diff = level.Vec3Diff(srcpos, plr.pos);
		double ang = VectorAngle(diff.X, diff.Y);
		ang = -plr.DeltaAngle(plr.angle, ang);

		Vector2 s = (Screen.GetWidth() / 2, Screen.GetHeight() / 2);
		
		double off = (siz.y + (siz.y * Scale)) * 0.75;
		Vector2 add = (-sin(ang) * off, cos(ang) * off);
		s += add;
		
		trans.Scale((1, 1) * Scale);
		trans.Rotate(ang + 180.0);
		trans.Translate(s);
		
		flat.SetTransform(trans);
		
		// draw the shape 
		Screen.DrawShape(tex,false,flat,DTA_Alpha, Clamp(Alpha, 0.0,maxalpha),DTA_ColorOverlay,col | 0xFF000000); // this requires a color in format AARRGGBB, so mask the Alpha at the beggining or it will be just white
		if(highlightreq) //keep the white part of the graphic white
			Screen.DrawShape(htex,false,flat,DTA_Alpha, Clamp(Alpha, 0.0,maxalpha));
		
	}
	
	clearscope Double LinearMap(Double Val, Double O_Min, Double O_Max, Double N_Min, Double N_Max) 
	{
		Return (Val - O_Min) * (N_Max - N_Min) / (O_Max - O_Min) + N_Min;
	}
}

