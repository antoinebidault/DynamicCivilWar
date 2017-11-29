class CfgCommunicationMenu
{
	class Attack;
	class Medevac: Attack
	{
		text = "Medevac";
		expression = "MEDEVAC_FirstTrigger = true;";
		icon = "\a3\ui_f\data\map\markers\nato\b_inf.paa";
		removeAfterExpressionCall = 1;
	};
};