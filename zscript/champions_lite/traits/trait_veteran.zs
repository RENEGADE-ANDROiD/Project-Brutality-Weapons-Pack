// Veteran: takes reduced damage from frontal attacks via cl_VeteranFrontArmor power.

class cl_VeteranController : cl_BaseController
	{
	override color GetParticleColour()
		{
		static const color Colours[] = { "c19971", "a67c52", "d4a574", "ffffff" };
		return Colours[random(0, Colours.Size() - 1)];
		}

	override void cl_GiveToken()
		{
		champion.A_GiveInventory("cl_VeteranToken");
		}

	override void cl_InitEffect()
		{
		champion.Health = int(champion.Health * 1.35);
		champion.PainChance = int(champion.PainChance * 0.6);
		champion.A_GiveInventory("cl_VeteranFrontArmorGiver");
		}
	}
