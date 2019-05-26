/**
 * DYNAMIC CIVIL WAR
 * Created: 2019-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
private["_unit"];
private _pos = _this select 0;
private _buildings = _this select 1;
private _succeeded = _this select 2;
_side = if (_succeeded) then {SIDE_FRIENDLY} else{SIDE_ENEMY};
_nbBuildings = count _buildings;
_objs = [];
_tmpTurrets = compos_turrets;
_tmpObjects = compos_objects;
_nbCompos = round(_nbBuildings/3) min 8;


for "_xc" from 1 to _nbCompos do {
    if (_buildings isEqualTo [])exitWith{};
    _buildingRandom = _buildings call BIS_fnc_selectRandom;
    _buildings = _buildings - [_buildingRandom];
    _nicePos = [getPos _buildingRandom,2, 19, 6, 0, .3, 0, [], []] call BIS_fnc_FindSafePos;

    if (isNil "_nicePos")exitWith{};
    if (_nicePos isEqualTo [])exitWith{};
    if (isOnRoad _nicePos)exitWith{};

  /*  if (random 100 > 70) then {
        if (_tmpTurrets isEqualTo [])exitWith{};
        _curr = _tmpTurrets call bis_fnc_selectrandom;
        _tmpTurrets = _tmpTurrets - [_curr];
        _newObjs = [_nicePos, 180 - (_buildingRandom getRelDir _nicePos), _curr] call BIS_fnc_ObjectsMapper;
        _turrets = nearestObjects [ _nicePos, [ "LandVehicle" ], 20 ];
         if (count _turrets > 0 ) then {
            _turret = _turrets select 0;  
            
            if (_side == SIDE_ENEMY) then {
                _unit = [createGroup _side, _nicePos, false] call fnc_spawnenemy;
            } else{
                _unit = [createGroup _side, _nicePos, false] call fnc_spawnfriendly;
            };
            [_newObjs select 0, "ColorPink"] call fnc_addMarker;
            _unit moveInGunner _turret;
            _objs = _objs + _newObjs;
        };
    } else{*/
        if (_tmpObjects isEqualTo [])exitWith{};
         _curr = _tmpObjects call bis_fnc_selectrandom;
        _tmpObjects = _tmpObjects - [_curr];
        _newObjs = [_nicePos,  random 360, _curr] call BIS_fnc_ObjectsMapper;
         [_newObjs select 0, "ColorWhite"] call fnc_addMarker;
        _objs = _objs + _newObjs;
   // };
};

_objs;