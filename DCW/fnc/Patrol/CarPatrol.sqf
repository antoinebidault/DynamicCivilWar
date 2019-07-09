/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
   Car patrol script
    Inspired by SPUn / LostVar

  Parameters:
    0: OBJECT - vehicle driver
    1: NUMBER - Patrol range in meters
    2: BOOL - True to center the patrol around spawned players

*/

private ["_driver","_radius","_centeredOnPlayer","_newPos","_bPoss","_dir","_curPos","_pos"];

_driver = _this select 0;
_radius = _this select 1;
_centeredOnPlayer = if (count _this > 2) then {_this select 2;} else {true;};

while { sleep 5; alive _driver }do{
    _dir = random 360;
    _curPos = if (_centeredOnPlayer) then { getPosASL (([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom) ; }else{ getPosASL _driver; };
    _pos = [_curPos, 0, _radius, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _newPos = getPosASL( [_pos,_radius,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad);
    _driver move _newPos;
    _timer = time;
    waitUntil {sleep 5; unitReady _driver || _driver distance _newPos < 2 || time > _timer + 900};
    sleep 5 + random 25;
};