params ["_unit"];

// Faks from the uniform
{
	if (_x == "FirstAidKit") then {
		_unit removeItemFromUniform "FirstAidKit";
	};
	nil
} count (uniformItems _unit);

// Faks from the vest
{
	if (_x == "FirstAidKit") then {
		_unit removeItemFromVest "FirstAidKit";
	};
	nil
} count (vestItems _unit);

// Faks and Medikits from the backpack. Kits can only be in backpack, so we don't search for them anywhere else
{
	if (_x == "FirstAidKit") then {
		_unit removeItemFromBackpack "FirstAidKit";
	};
	if (_x == "Medikit") then {
		_unit removeItemFromBackpack "Medikit";
	};
	nil
} count (backpackItems _unit);
