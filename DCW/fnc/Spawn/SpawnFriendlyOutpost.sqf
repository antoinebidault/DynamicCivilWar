/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
 
if (!isServer) exitWith{false};

private ["_unitName","_civ"];
private _pos = _this select 0;
private _radius = _this select 1;
private _nb = _this select 2;
private _meetingPointPosition = _this select 3;
private _buildings = _this select 4;
private _units = [];

//List positions;
private _posResult = [];
private _posResult = [_pos,_radius] call DCW_fnc_SpawnPosition;
private _posSelects = _posResult select 0;
private _enterable = _posResult select 1;
private _cancel = true;

if (_nb < 1) exitWith { _units };

_nbVehicles = if (_nb > 7) then {2} else {if (_nb <= 3) then {0} else {1};};

_roads = _pos nearRoads _radius; 

if (count _roads > 0) then {
  for "_xc" from 1 to _nbVehicles  do  {
    _road = _roads call BIS_fnc_selectRandom;
    if (!isNil '_road')then{
        _roads = _roads - [_road];
        _car = ([getPos _road, 0,ALLIED_LIST_CARS call BIS_fnc_selectRandom, SIDE_FRIENDLY] call bis_fnc_spawnvehicle)  select 0;
        _car setVehicleLock "LOCKED";
        _roadConnectedTo = roadsConnectedTo _road;
        if (count _roadConnectedTo == 0) then{
          _car setDir floor(random 360);
        }else{
          _connectedRoad = _roadConnectedTo select 0;
          _car setDir ([_road, _connectedRoad] call BIS_fnc_DirTo);
        };
        _car setPos [getPos _car select 0, getPos _car select 1, getPos _car select 2];
        _units pushBack _car;
    };
  };
};

private _flagPos = [_pos,0, 20, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_unit = FRIENDLY_FLAG createVehicle _flagPos;
_units pushBack _unit;

_ammoBox = "Box_Syndicate_Ammo_F" createVehicle (_unit modelToWorld [1,1,0]);
_ammoBox call DCW_fnc_spawncrate;
_units pushBack _ammoBox;


//Ajout des enemis 
for "_xc" from 1 to _nb  do {

    _cancel = false;
    _posSelected = [];

    if (count _posSelects > 0)then{
       _posSelected = _posSelects call BIS_fnc_selectRandom;
       _posSelects = _posSelects - [_posSelected];
    }else{
        _cancel = true;
    };

    if (!_cancel) then {
      
      _grp = createGroup SIDE_FRIENDLY;
      _unit = [_grp,_posSelected,false] call DCW_fnc_spawnfriendly;
      _unit setVariable["DCW_Type","friendly"];
      _units pushBack _unit;

      //Si c'est une patrouille
      [_grp,"DCW_fnc_EnemyCompoundPatrol", [_grp,_radius,_meetingPointPosition,_buildings]] call DCW_fnc_patrolDistributeToHC;
      
    };
};

_units;