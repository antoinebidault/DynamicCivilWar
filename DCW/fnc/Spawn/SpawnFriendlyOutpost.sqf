/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_unitName","_civ"];
private _pos = _this select 0;
private _radius = _this select 1;
private _nb = _this select 2;
private _meetingPointPosition = _this select 3;
private _units = [];


//List positions;
private _posResult = [];
private _posResult = [_pos,_radius] call fnc_SpawnPosition;
private _posSelects = _posResult select 0;
private _enterable = _posResult select 1;
private _cancel = true;

if (_nb < 1) exitWith { _units };



//Spawn an armed vehicke
private _road = [_pos,4*_radius,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad;
if (!isNil '_road')then{
    _car = ([getPos _road, 0,FRIENDLY_LIST_CARS call BIS_fnc_selectRandom, SIDE_CURRENT_PLAYER] call bis_fnc_spawnvehicle)  select 0;
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

private _flagPos = [_pos,0, 20, 1, 0, 20, 0] call BIS_fnc_FindSafePos;
_unit = FRIENDLY_FLAG createVehicle _flagPos;
_units pushBack _unit;

//Ajout des enemis 
for "_xc" from 1 to _nb  do {

    _isPatrol = false;
    _cancel = false;
    _posSelected = [];

    //if (random 100 > 75) then{_nbUnit = ((PATROL_SIZE select 0) + floor random (PATROL_SIZE select 1)); _isPatrol = true; };

    if (_isPatrol)then{
      _posSelected = [_pos,1, _radius, 5, 0, 20, 0] call BIS_fnc_FindSafePos;
    }else{
      if (count _posSelects > 0)then{
         _posSelected = _posSelects call BIS_fnc_selectRandom;
        _posSelects = _posSelects - [_posSelected];
      }else{
         _cancel = true;
      }
    };

    if (!_cancel) then {
      _grp = createGroup SIDE_CURRENT_PLAYER;
      _unitName = FRIENDLY_LIST_UNITS call BIS_fnc_selectRandom;
      _unit = _grp createUnit [_unitName, _posSelected,[],1,"NONE"];


      if (DEBUG)then{
          [_unit,"ColorGreen"] call fnc_addmarker;
      };

      [_unit] call fnc_AddTorch;

      _unit setVariable["DCW_Type","friendly"];
      _unit setDir random 360;
      _units pushBack _unit;

      //Si c'est une patrouille
      [leader _grp,_radius,_meetingPointPosition] spawn fnc_patrol;
      
    };
};




_units;