class ElecPodCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Electric Pod");
		tokens.push("WW_ElecPodSelected");
		img.push("graphics/Equipments/electricpod.png");
		sx.push(1.0);
		sy.push(1.0);
	}
}

class ShieldGrenadeCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Shield Grenade");
		tokens.push("WW_ShieldSelected");
		img.push("graphics/Equipments/shieldgrenade.PNG");
		sx.push(1.0);
		sy.push(1.0);
	}
}

class VoidGrenadeCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Void Grenade");
		tokens.push("WW_VoidGrenadeSelected");
		img.push("graphics/Equipments/voidgrenade.png");
		sx.push(1.0);
		sy.push(1.0);
	}
}

class SwarmerCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Swarmer");
		tokens.push("WW_SwarmerSelected");
		img.push("graphics/Equipments/swarmer.png");
		sx.push(1.0);
		sy.push(1.0);
	}
}

class LaserChargeCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Laser Charge");
		tokens.push("WW_LaserChargeSelected");
		img.push("graphics/Equipments/lasercharge.png");
		sx.push(1.0);
		sy.push(1.0);
	}
}

class AcidChargeCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Acid Charge");
		tokens.push("WW_AcidChargeSelected");
		img.push("graphics/Equipments/acidcharge.png");
		sx.push(1.0);
		sy.push(1.0);
	}
}

class AxeCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Axe");
		tokens.push("WW_AxeSelected");
		img.push("graphics/Equipments/axe.png");
		sx.push(0.3);
		sy.push(0.3);
	}
}

class HookCard : equipmentCard
{
	override void InfoFiller(out array<string> tags,out array<string> tokens,out array<string>img,out array<double>sx,out array<double>sy)
	{
		tags.push("Meat Hook");
		tokens.push("WW_HookSelected");
		img.push("graphics/Equipments/hook.png");
		sx.push(0.3);
		sy.push(0.3);
	}
}