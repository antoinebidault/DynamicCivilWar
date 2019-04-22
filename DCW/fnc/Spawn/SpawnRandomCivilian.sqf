/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


if (!isServer) exitWith{false};
private _numberOfmen = 1;
private _minRange = 300;
private _firstTrigger = true;

while{true}do {
	if ({ _x getVariable["DCW_type",""] == "civpatrol" } count UNITS_SPAWNED  < MAX_RANDOM_CIVILIAN)then{

		//Get random pos
		if (_firstTrigger) then {_minRange = 1; _firstTrigger = false;}else{_minRange = 500;};
		_pos = [position (allPlayers call BIS_fnc_selectRandom), _minRange, 550, 4, 0, 20, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST,[]] call BIS_fnc_FindSafePos;
		if (_pos isEqualTo [] || _pos isEqualTo [2048,2048,2048]) then {
			sleep 2;
		} else {
			_numberOfmen =  1;
			_group = createGroup SIDE_CIV;

			for "_j" from 1 to _numberOfmen do {
				_unit = [_group,_pos] call fnc_SpawnCivil;
				_unit setVariable["DCW_type","civpatrol"]; // overload
				_unit setBehaviour "SAFE";
				sleep .4;
			};
			[leader _group] spawn fnc_civilianPatrol;
		};
	};	


	sleep 12;
};