/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Adapted from Zonekiller's Array Builder -- Moser 07/18/2014
//http://forums.bistudio.com/showthread.php?109423-Zonekiller-s-Array-Builder
//Determines faction and classname of player, then convert them to strings (strings are easier to work with configs!)



params["_faction"];
private ["_type"];

_allowedmenclass = ["Man"]; //required if you want to only find men and not vehicles

// Men not to add -- optional

_forbidedmenclass = [];

// List of arrays it will make -- only need one global array to pass to the rest of Bon's scripts
//-----------------------------------

results = [];

//--------------------------------

//Some config functions
	
_CfgVehicles = configFile >> "CfgVehicles";
_CfgVehicleClass = configFile >> "CfgVehicleClass";


for "_i" from 1 to ((count _CfgVehicles) - 1) do 
{
	_Vehicle = _CfgVehicles select _i;


	if ((isClass _Vehicle) && ((getnumber(_Vehicle >> "scope")) == 2) && !((configName _Vehicle) isKindOf "Building") && !((configName _Vehicle) isKindOf "Thing")) then 
	{

	_go = 0;

		{if ((configName _Vehicle) isKindOf _x) exitwith {_go = 1;

		{if ((configName _Vehicle) isKindOf _x) exitwith {_go = 0}} foreach _forbidedmenclass;		
		
		// Makes arrays of men from the faction and subfaction

			if (_go == 1) then		
			{
				if (getText(_Vehicle >> "faction") == _faction) then {
					results = results + [configName _Vehicle];
				};
			};

		_go = 0;			

		}} foreach _allowedmenclass;
	};
};

results;