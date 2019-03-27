class CfgCommunicationMenu
{
	class Attack;
	class Medevac: Attack
	{
		text = "Medevac and reinforcement";
		expression = "MEDEVAC_State = ""map"";";
		icon = "\a3\ui_f\data\map\markers\nato\b_med.paa";
		removeAfterExpressionCall = 1;
	};
};