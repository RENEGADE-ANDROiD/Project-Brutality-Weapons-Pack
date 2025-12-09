class E1Boss : Actor
{
	Default {
		Radius 8;
		Height 16;
		RenderRadius 128;
		+SOLID;
		-SHOOTABLE;
		+NODAMAGE;
		+NOGRAVITY;
	}
	
		States {
		Spawn:
			NO3D A 35;
			Loop;
	}
}

Class E1_Export_1 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E1_Export_2 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E2_Export_1 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E2_Export_2 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E2_Export_3 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E2_Export_4 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E3_Export_1 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
		RenderRadius 512;
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E3_Export_2 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
		RenderRadius 512;
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E4_Export_1 : Actor {
	Default {
		Radius 8;
		Height 8;
		RenderRadius 512;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class E5_Export_1 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}

Class Mount1 : Actor {
	Default {
		Radius 8;
		Height 8;
		+NOGRAVITY
	}

	States {
		Spawn:
			BAR1 A -1;
			Stop;
	}
}