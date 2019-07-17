/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    A very light patrol script

  Parameters:
    0: OBJECT - unit
    1: NUMBER - max range o feach waypoint

  Returns:
    BOOL - true 
*/

private ["_unit","_radius","_newPos","_bPoss","_dir","_curPos"];

_grp = (_this select 0);
_unit = leader _grp;
_radius = _this select 1;
_canChase =  [_this, 2, true] call BIS_fnc_param; // If the unit has the ability to chase enemies
_anims = ["STAND","STAND_IA","SIT_LOW","WATCH","WATCH1","WATCH2"];
_startPos = getPosASL _unit;

 if(isNull(_unit findNearestEnemy _unit))then{
    //_unit forceWalk  true;
    (group _unit) setSpeedMode "LIMITED";
    (group _unit) setBehaviour "SAFE";
}else{
    //_unit forceWalk  false;
    (group _unit) setBehaviour "AWARE";
};

while { alive _unit }do{

    if ( _unit getVariable["DCW_disable_patrol",false])exitWith{false};

    _dir = random 360;
    _curPos = getPosASL _unit;
    _newPos = [_startPos ,0,(_radius+ 10), 1, 0, 20, 0, if (_canChase) then { MARKER_WHITE_LIST } else {[]},[]] call BIS_fnc_findSafePos;
    if (_newPos isEqualTo []) exitWith{};
    
    _unit move _newPos;
    _timer = time;

    waitUntil {sleep 1;!isNull(_unit findNearestEnemy _unit) || unitReady _unit || _unit distance _newPos < 2 || _unit getVariable["DCW_disable_patrol",false] || time > _timer + 150};
    if(_canChase && !isNull(_unit findNearestEnemy _unit))exitWith {[_grp,(_unit findNearestEnemy _unit)] call DCW_fnc_chase};

    if (side _unit == SIDE_ENEMY) then{
        _unit stop true;
        sleep 2;
        [_unit,_anims call BIS_fnc_selectRandom,"FULL"] remoteExec ["BIS_fnc_ambientAnimCombat"];
    };
    sleep 20 + random 25;
    if (side _unit == SIDE_ENEMY) then{
        if (alive _unit)then{
            _unit stop false;
            [_unit] remoteExec ["BIS_fnc_ambientAnim__terminate"];
        };
    };
    sleep 5;
};

true;