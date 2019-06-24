/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
//--------------------------------

//Some config functions
_output = [];
_CfgVehicles = configFile >> "CfgVehicles";
_CfgVehicleClass = configFile >> "CfgVehicleClass";

for "_i" from 1 to ((count _CfgVehicles) - 1) do 
{
	_Vehicle = _CfgVehicles select _i;

	if ((isClass _Vehicle) && ((getnumber(_Vehicle >> "scope")) == 2) && !((configName _Vehicle) isKindOf "Building") && !((configName _Vehicle) isKindOf "Thing")) then 
	{
		_output pushback _Vehicle;
	};
};
_output;