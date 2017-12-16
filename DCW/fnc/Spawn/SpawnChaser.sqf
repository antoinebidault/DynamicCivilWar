/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_enemy","_unitName"];
private _units = [];
if ( {_x getVariable["DCW_Type",""] == "chaser"} count UNITS_SPAWNED >= MAX_CHASERS) exitWith {_units;};

private _nbUnit = (PATROL_SIZE select 0) + round(random(PATROL_SIZE SELECT 1));;
private _grp = createGroup ENEMY_SIDE;
private _posSelected = [position player ,SPAWN_DISTANCE,SPAWN_DISTANCE+100, 2, 0, 20, 0] call BIS_fnc_FindSafePos;

 for "_xc" from 1 to _nbUnit do {
    _enemy = [_grp,_posSelected,false] call fnc_spawnEnemy;
    _enemy setVariable["DCW_Type","chaser"];
    _enemy setDir random 360;
    _units pushback _enemy;
 };

 //Trigger chase
 (leader _grp) spawn fnc_chase;

 _units;