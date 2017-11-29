/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


private _numberOfmen = 1;
private _minRange = 300;
private _unitPool = [];
private _firstTrigger = true;
while{true}do {
	if (count _unitPool < MAX_RANDOM_CIVILIAN)then{

		//Get random pos
		if (_firstTrigger) then {_minRange = 1; _firstTrigger = false;}else{_minRange = 500;};
		_pos = [position player, _minRange, 550, 4, 0, 20, 0,MARKER_WHITE_LIST] call BIS_fnc_findSafePos;
		_numberOfmen =  1;
		_group = createGroup CIV_SIDE;

		for "_j" from 1 to _numberOfmen do {
			_unitName = CIV_LIST_UNITS call BIS_fnc_selectRandom;
			_unit = _group createUnit [_unitName, _pos,[],0,"NONE"];
			
			[_unit,"ColorBlue"] call fnc_addMarker;
			[_unit] call fnc_handlekill;
			[_unit] call fnc_handleFiredNear;
			[_unit] call fnc_addCivilianAction;
			_unit call fnc_handleDamaged;
			_unitPool pushBack _unit;
			_unit setBehaviour "SAFE";
			UNITS_SPAWNED pushBack _unit;
			sleep .4;
		};
		[leader _group] spawn fnc_civilianPatrol;
	};	

	{
		/*if (!alive _x)then{
			_unitPool = _unitPool - [_x];
		};*/
		
		if(_x distance player > 600)then{
			UNITS_SPAWNED - [_x];
			_unitPool = _unitPool - [_x];
			if (DEBUG)then{
				deleteMarker (_x getVariable["marker",""]);
			};
			deleteVehicle _x;
		}
	}foreach _unitPool;

	sleep 12;
};
