class cl_Token : Inventory
	{
	default
		{
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		inventory.MaxAmount 1;
		}
	}

class cl_BulwarkToken	: cl_Token {}
class cl_BruteToken		: cl_Token {}
class cl_SwiftToken		: cl_Token {}
class cl_VolatileToken	: cl_Token {}
class cl_ToxicToken		: cl_Token {}
class cl_BlinkToken		: cl_Token {}
class cl_StalkerToken	: cl_Token {}
class cl_SplitterToken	: cl_Token {}
class cl_VeteranToken	: cl_Token {}
class cl_CaptainToken	: cl_Token {}

class cl_GiantToken		: cl_Token {}
class cl_SpectralToken	: cl_Token {}
class cl_RampageToken	: cl_Token {}

class cl_NullToken : Inventory
	{
	default
		{
		+INVENTORY.UNTOSSABLE;
		+INVENTORY.UNDROPPABLE;
		}
	}
