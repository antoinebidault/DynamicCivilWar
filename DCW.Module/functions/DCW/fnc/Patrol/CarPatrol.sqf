/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Car patrol script
 * Inspired by SPUn / LostVar
 */

private ["_unit","_radius","_centeredOnPlayer","_newPos","_bPoss","_dir","_curPos","_pos"];

_unit = _this select 0;
_radius = _this select 1;
_centeredOnPlayer = if (count _this > 2) then {_this select 2;} else {true;};

while { sleep 5; alive _unit }do{
    _dir = random 360;
    _curPos = if (_centeredOnPlayer) then { getPosASL (allPlayers call BIS_fnc_selectRandom) ; }else{ getPosASL _unit; };
    _pos = [_curPos, 0, _radius, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _newPos = getPosASL( [_pos,_radius,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad);
    _unit move _newPos;
    _timer = time;
    waitUntil {sleep 5; unitReady _unit || _unit distance _newPos < 2 || time > _timer + 900};
    sleep 5 + random 25;
};