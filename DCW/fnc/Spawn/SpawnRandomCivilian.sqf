/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/


if (!isServer) exitWith{false};
private _numberOfmen = 1;
private _minRange = 300;
private _firstTrigger = true;

while{true}do {
	if ({ _x getVariable["DCW_type",""] == "civpatrol" } count UNITS_SPAWNED_CLOSE  < MAX_RANDOM_CIVILIAN)then{

		//Get random pos
		if (_firstTrigger) then {_minRange = 1; _firstTrigger = false;}else{_minRange = 450;};
		_pos = [position (([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom), _minRange, 600, 1, 0, 2, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST,[]] call BIS_fnc_findSafePos;
		if (_pos isEqualTo [] || _pos isEqualTo [2048,2048,2048]) then {
			sleep 2;
		} else {
			_numberOfmen =  1;
			_group = createGroup SIDE_CIV;

			for "_j" from 1 to _numberOfmen do {
				_unit = [_group,_pos] call DCW_fnc_spawnCivil;
				_unit setVariable["DCW_type","civpatrol"]; // overload
				_unit setBehaviour "SAFE";
				sleep .4;
			};
			
			// Send group to HC
			[_group,"DCW_fnc_civilianPatrol", [_group]] call DCW_fnc_patrolDistributeToHC;

			//[_group] spawn DCW_fnc_civilianPatrol;
		};
	};	


	sleep 12;
};