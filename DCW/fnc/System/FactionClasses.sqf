/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

//Adapted from Zonekiller's Array Builder -- Moser 07/18/2014
//http://forums.bistudio.com/showthread.php?109423-Zonekiller-s-Array-Builder
//Determines faction and classname of player, then convert them to strings (strings are easier to work with configs!)



params["_unitParam","_unitType","_nameFilter"];
private ["_unit","_type"];

_unit = if (typeName (_unitParam) == 'String') then{ 
	missionNamespace getVariable [_unitParam , objNull];
 }else{
	_unitParam;
}; 
_type = if (count _this > 1) then { _unitType;} else {"Man"};	
_nameFilter = if (count _this > 2) then { _nameFilter;} else {[]};	



_faction = [format["%1",faction _unit]];
_classname = format["%1",typeOf _unit]; 

_allowedmenclass = [_type]; //required if you want to only find men and not vehicles

// Men not to add -- optional

_forbidedmenclass = [];

// List of arrays it will make -- only need one global array to pass to the rest of Bon's scripts
//-----------------------------------

bon_recruit_recruitableunits = [];

//--------------------------------

//Some config functions
	
_CfgVehicles = configFile >> "CfgVehicles";
_CfgVehicleClass = configFile >> "CfgVehicleClass";

//Find player's subfaction
_subfaction = [getText(_CfgVehicles >> _classname >> "vehicleClass")];

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
				if (getText(_Vehicle >> "faction") in _faction) then {
					if (count _nameFilter == 0) then{
						bon_recruit_recruitableunits = bon_recruit_recruitableunits + [configName _Vehicle];
					}else{
						{
							_result = toLower(getText(_Vehicle >> "displayName")) find (toLower(_x));
							if (_result > -1)then{
								bon_recruit_recruitableunits = bon_recruit_recruitableunits + [configName _Vehicle];
							}
						}foreach _nameFilter;
					}
				};
			};

		_go = 0;			

		}} foreach _allowedmenclass;
	};
};

bon_recruit_recruitableunits;