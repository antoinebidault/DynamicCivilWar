/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/


if (!isServer) exitWith{false};

private _numberOfmen = 1;
private _minRange = 600;
private _maxRange = SPAWN_DISTANCE;
private _side = SIDE_ENEMY;
private _unit = objNull;

while{true}do {
	_nbUnitSpawned = { _x getVariable["DCW_type",""] == "patrol" } count UNITS_SPAWNED_CLOSE;
	if (_nbUnitSpawned < MAX_RANDOM_PATROL)then{
		_nbFriendlies = { _x getVariable["DCW_type",""] == "patrol" && side _x == SIDE_FRIENDLY} count UNITS_SPAWNED_CLOSE;
		//Get random pos
		_side = SIDE_ENEMY;

		_pos = [position (([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom), _minRange, _maxRange, 1, 0, 20, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST,[]] call BIS_fnc_findSafePos;
		if (_pos isEqualTo [] || _pos isEqualTo [2048,2048,2048]) then{
			sleep 3;
		} else {
			_numberOfmen =  (PATROL_SIZE select 0) + round(random(PATROL_SIZE SELECT 1));
			if (floor (random 100) < PERCENTAGE_FRIENDLIES && _nbFriendlies == 0) then {
				_side = SIDE_FRIENDLY;
				_numberOfmen = 4;
			};

			_grp = createGroup _side;

			for "_j" from 1 to _numberOfmen do {

				if (_side == SIDE_FRIENDLY) then{
					_unit = [_grp,_pos,false] call DCW_fnc_spawnFriendly;
					[_unit] remoteExec ["DCW_fnc_addActionGiveUsAHand"];
				} else {
					_unit = [_grp,_pos,false] call DCW_fnc_spawnEnemy;
				};

				_unit setVariable["DCW_Type","patrol"];
				_unit setDir random 360;
				_unit setBehaviour "SAFE";
				sleep .4;
			};

			[_grp,"DCW_fnc_simplePatrol", [_grp, 120]] call DCW_fnc_patrolDistributeToHC;
		};
	};	
	
	if (_nbUnitSpawned < 10) then{
		sleep 20;
	}else{
		sleep 200;
	};
};
