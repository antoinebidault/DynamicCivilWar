/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Adapted from Zonekiller's Array Builder -- Moser 07/18/2014
//http://forums.bistudio.com/showthread.php?109423-Zonekiller-s-Array-Builder
//Determines faction and classname of player, then convert them to strings (strings are easier to work with configs!)



params["_faction","_classes","_patternIncluded"];

_forbidedmenclasses = ["pilot","crew","driver","unarmed","diver","_VR","_AA_","Survivor","Story","officer"];

_results = [];

//--------------------------------


{
	_Vehicle = _x;
	_go = 0;
	{
		if ((configName _Vehicle) isKindOf _x) then {_go = 1;};

		if (_go == 1) then		
		{
			if (getText(_Vehicle >> "faction") == _faction) then {
				_results = _results + [configName _Vehicle];
			};
		};

		_go = 0;			

	} foreach _classes;
} foreach CONFIG_VEHICLES;

// Post process pattern restriction and inclusions
_filteredArray = [];
{
	_go = 1;
	_vehName = str _x;
	{
		if ([_x,_vehName, false] call BIS_fnc_inString) exitwith {_go = 0};
	} foreach _forbidedmenclasses;		

	if (_go == 1 && count _patternIncluded > 0) then {
		_go =0;
		{
			if ([_x, _vehName, false] call BIS_fnc_inString) exitWith {_go = 1;};
		} foreach _patternIncluded;
	};

	if (_go == 1) then {
		_filteredArray pushBackUnique _x;
	};
	
} foreach _results;
_results = _filteredArray;


_results;


