private ["_enemy","_unitName"];
private _units = [];
private _nbUnit = (PATROL_SIZE select 0) + round(random(PATROL_SIZE SELECT 1));;
private _grp = createGroup ENEMY_SIDE;
private _posSelected = [position player ,SPAWN_DISTANCE+50,SPAWN_DISTANCE+100, 2, 0, 20, 0] call BIS_fnc_findSafePos;

 for "_xc" from 1 to _nbUnit do {
    _enemy = [_grp,_posSelected] call fnc_spawnEnemy;
    _enemy setVariable["IH_type","chaser"];
    _enemy setDir random 360;
    _units pushback _enemy;
 };

 //Trigger chase
 (leader _grp) spawn fnc_chase;

 _units;