/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_group = _this select 0;
_pos = _this select 1;

_unitName = ENEMY_LIST_UNITS call BIS_fnc_selectRandom;
_unit = _group createUnit [_unitName, _pos,[],ENEMY_SKILLS,"NONE"];

if(isNull(_unit findNearestEnemy _unit))then{
    _unit forceWalk  true;
    _unit setBehaviour "SAFE";
}else{
    _unit forceWalk  false;
};

if (DEBUG)then{
    [_unit,"ColorRed"] call fnc_addmarker;
};

[_unit] call fnc_AddTorch;
[_unit] call fnc_handlekill;

_unit


