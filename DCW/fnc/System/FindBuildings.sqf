/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

// return array of enterable building objects which have min 3 positions inside
// passed params are [[pos], radius]
// usage : _avaible_buildings = [[pos], radius] call fnc_findbuildings;
params ["_center","_radius"];

private _buildings = nearestObjects [_center, ["house"], _radius];
private _enterable = [];
{
	if ([_x, 3] call BIS_fnc_isBuildingEnterable) then {
		//this both buildings are not enterable but pickedup by BIS_fnc_isBuildingEnterable
		if (typeof _x == "Land_HouseV2_03" || typeof _x == "Land_Nasypka") exitWith {};
	
		_enterable  pushback _x;

	};
} foreach _buildings;
_enterable;


	