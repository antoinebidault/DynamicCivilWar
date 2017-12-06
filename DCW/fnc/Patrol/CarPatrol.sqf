/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Inspired by SPUn / LostVar
private ["_unit","_radius","_newPos","_bPoss","_dir","_curPos","_pos"];

_unit = _this select 0;
_radius = _this select 1;
_anims = ["STAND","STAND_IA","SIT_LOW","WATCH","WATCH1","WATCH2"];
_startPos = getPosASL _unit;
while { alive _unit }do{
    _dir = random 360;
    _curPos = getPosASL _unit;
    _pos = [position player, 0, _radius, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _newPos = getPosASL( [_pos,_radius] call BIS_fnc_nearestRoad);
    _unit move _newPos;
    _timer = time;
    waitUntil {unitReady _unit || _unit distance _newPos < 2 || time > _timer + 150};
    sleep 20 + random 25;
};