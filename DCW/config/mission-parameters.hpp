class Params
{
	class AISkill
	{
		title = "AI Skill"; // Param name visible in the list
		values[] = {0,1,2}; // Values; must be integers; has to have the same number of elements as 'texts'
		texts[] = {"Recruit","Regular","Veteran (Recommended)"}; // Description of each selectable item
		default = 2; // Default value; must be listed in 'values' array, otherwise 0 is used
	};
	class Debug
	{
		title = "Debug";
		texts[] = {"Yes","No"};
		values[] = {1,0};
		default = 0;
		isGlobal = 1; 
	};
	class Respawn
	{
		title = "Respawn";
		texts[] = {"Yes (default)","No"};
		values[] = {1,0};
		default = 1;
		isGlobal = 1; 
	};
	class Reviving
	{
		title = "Reviving (With medevac module that replaces dead AI)";
		texts[] = {"Yes (default)","No"};
		values[] = {1,0};
		default = 1;
		isGlobal = 1; 
	};
	class NumberRespawn
	{
		title = "Number of respawn";
		texts[] = {"1","4 (default)","Unlimited"};
		values[] = {1,4,9999};
		default = 4;
		isGlobal = 0; 
	};
	class Daytime
	{
		title = "Time";
		texts[] = {"Morning","Day (default)","Evening","Night"};
		values[] = {6,12,18,0};
		default = 12;
		function = "BIS_fnc_paramDaytime"; // (Optional) [[Functions_Library_(Arma_3)|Function]] [[call]]ed when player joins, selected value is passed as an argument
		isGlobal = 1; // (Optional) 1 to execute script / function locally for every player who joins, 0 to do it only on server
	};
	//#include "\a3\Functions_F\Params\paramRevive.hpp"
};