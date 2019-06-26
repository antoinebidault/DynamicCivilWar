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
			file = "fnc\Behavior";
			class myFunction {};
		};

	};
};