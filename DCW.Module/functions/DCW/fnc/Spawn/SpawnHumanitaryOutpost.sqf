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
private _nb = 2 max (_this select 2);
private _meetingPointPosition = _this select 3;
private _buildings = _this select 4;
private _units = [];

//List positions;
private _posResult = [];
private _posResult = [_pos,_radius] call DCW_fnc_spawnPosition;
private _posSelects = _posResult select 0;
private _enterable = _posResult select 1;

if (_nb < 1) exitWith { _units };

//Spawn an armed vehicke

private _road = [_pos,4*_radius,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad;
if (!isNil '_road' && count nearestObjects[_pos,["Car"],10] == 0)then{
    _car = ([getPos _road, 0,HUMANITAR_LIST_CARS call BIS_fnc_selectRandom, SIDE_CIV] call bis_fnc_spawnvehicle)  select 0;
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
    { _units pushback _x } foreach crew _car;
    
};

private _flagPos = [_pos,0, 20, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_unit = "Flag_UNO_F" createVehicle _flagPos;
_units pushBack _unit;

//Ajout des enemis 
for "_xc" from 1 to _nb  do {

    _posSelected = [];

    if (count _posSelects > 0)then{
        _posSelected = _posSelects call BIS_fnc_selectRandom;
        _posSelects = _posSelects - [_posSelected];
    }else{
        private _spawnPos = _pos;
        if (count _enterable > 0) then {
          _randomBuilding = _enterable call BIS_fnc_selectRandom;
          _spawnPos = getPos _randomBuilding;
        };
        _posSelected = [_spawnPos,1, 22, 1.5, 0, 20, 0] call BIS_fnc_findSafePos;
    };

      
   //   _unitName = ALLIED_LIST_UNITS call BIS_fnc_selectRandom;
    //  _unit = _grp createUnit [_unitName, _posSelected,[],1,"NONE"];
      _grp = createGroup SIDE_CIV;
      _unit = [_grp,_posSelected,false] call DCW_fnc_spawnhumanitar;
      _unit setVariable["DCW_Type","humanitar"];
      _units pushBack _unit;

      //Si c'est une patrouille
       // spawn DCW_fnc_humanitarPatrol;
			[_grp,"DCW_fnc_humanitarPatrol", [_grp,_radius,_meetingPointPosition,_buildings,_pos]] call DCW_fnc_patrolDistributeToHC;
};

_units;