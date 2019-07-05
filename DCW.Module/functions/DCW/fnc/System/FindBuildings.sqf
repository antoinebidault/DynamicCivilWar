/*
  Author: 
    Bidass

  Description:
    Find enterable buildings in the specified range.
	return array of enterable building objects which have min 3 positions inside
	passed params are [[pos], radius]

  Usage : 
	_buildings = [[pos], radius] call DCW_fnc_findbuildings;

  Parameters:
    0: ARRAY - position
	1: NUMBER - Radius

  Returns:
    BOOL - true 
*/

params ["_center","_radius"];
private _blackList = [ "Land_Lighthouse_03_red_F" , "Land_Lighthouse_03_green_F" , "Land_LightHouse_F","Land_Nasypka","Land_HouseV2_03"];
private _buildings = nearestObjects [_center, ["house"], _radius];
private _go = true;
private _enterable = [];
{
	if ([_x, 1] call BIS_fnc_isBuildingEnterable) then {
		//this both buildings are not enterable but pickedup by BIS_fnc_isBuildingEnterable
	    _building = _x;
		_go = true;
		{
			if (typeof _building == _x) exitWith{ _go = false; };
		} foreach _blackList;

		if (_go) then {
			_enterable pushback _x;
		};
		
	};
} foreach _buildings;
_enterable;


	