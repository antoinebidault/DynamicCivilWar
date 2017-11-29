/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private["_pos","_radius","_roads","_car","_cars","_connectedRoad","_roadConnectedTo"];

_pos = _this select 0;
_radius = _this select 1;
_nb = _this select 2;

_cars = [];

_roads = _pos nearRoads _radius;
_roadSelects = [];
//_i = floor(_radius/100);
_i = _nb;
if (count _roads == 0) exitWith {_cars};
while {_i > 0} do {
	if (_i > count _roads) exitWith{};
    _rnd = _roads call BIS_fnc_selectRandom;
    _roadSelects pushBack _rnd;
    _roads = _roads - [_rnd];
    _i = _i-1;
};

{
  _x;
  _r = floor random 100;
  if (_r < PERCENTAGE_ENEMIES)then{
  	_car = createVehicle [ENEMY_LIST_CARS call BIS_fnc_selectRandom, getPos _x, [], random 5, "NONE"];
  }else{
  	_car = createVehicle [CIV_LIST_CARS call BIS_fnc_selectRandom, getPos _x, [], random 5, "NONE"];
  };
  _car setVariable ["DCW_type","car"];
  _car setVehicleLock "LOCKED";
  _roadConnectedTo = roadsConnectedTo _x;
  ROAD = _roadConnectedTo;
  if (count _roadConnectedTo == 0) then{
    _car setDir floor(random 360);
  }else{
    _connectedRoad = _roadConnectedTo select 0;
   _car setDir ([_x, _connectedRoad] call BIS_fnc_DirTo);
  };
  _car setPos [(getPos _car select 0)-4.5, getPos _car select 1, getPos _car select 2];
  _cars pushBack _car;
} forEach _roadSelects;

_cars;