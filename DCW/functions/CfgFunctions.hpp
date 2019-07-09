class CfgFunctions
{
	class DCW
	{
		class DCWFunctions
		{
			tag = "DCW"; //Custom tag name
			requiredAddons[] = {"A3_Data_F"}; //Optional requirements of CfgPatches classes. When some addons are missing, functions won't be compiled.
		};

		class Behavior
		{	
			file = "DCW\functions\behavior";
			class actionCamp {};
			class addCivilianAction {};
			class addTorch {};
			class badGuyLoadout {};
			class camp {};
			class discussion {};
			class localChief {};
			class medic {};
			class mortarbombing {};
			class prepareAction {};
			class randomAnimation {};
			class shout {};
			class surrender {};
			class updateRep {};
		};

		class CutScene
		{	
			file = "DCW\functions\cutscene";
			class CamFollow {};
			class CompoundSecuredCutScene {};
		};
	};
};