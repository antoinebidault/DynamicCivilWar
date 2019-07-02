/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
params["_unitChased"];
private ["_enemy","_unitName"];
private _units = [];

if ( {_x getVariable["DCW_Type",""] == "chaser"} count UNITS_SPAWNED_CLOSE >= MAX_CHASERS) exitWith {_units;};

private _nbUnit = MAX_CHASERS - round(random 3);
private _grp = createGroup SIDE_ENEMY;
private _posSelected = [position _unitChased, SPAWN_DISTANCE,SPAWN_DISTANCE+100, 2, 0, 20, 0, MARKER_WHITE_LIST] call BIS_fnc_findSafePos;

 for "_xc" from 1 to _nbUnit do {
    _enemy = [_grp,_posSelected, false] call DCW_fnc_spawnEnemy;
    _enemy setVariable["DCW_Type","chaser"];
    _enemy setDir random 360;
    _units pushback _enemy;
 };

[HQ, format["Be careful, our drone has watched %1 of them moving straight to your position, and there are other reinforcements incoming !",_nbUnit], true] remoteExec["DCW_fnc_talk", GROUP_PLAYERS, false];

 //Trigger chase
 // [leader _grp, _unitChased] spawn DCW_fnc_chase;
[_grp,"DCW_fnc_simplePatrol", [leader _grp, _unitChased]] call DCW_fnc_chase;

 _units;