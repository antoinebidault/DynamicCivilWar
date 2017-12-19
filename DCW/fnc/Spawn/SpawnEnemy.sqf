/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _group = _this select 0;
private _pos = _this select 1;
private _excludedFromSpawnedUnit = _this select 2;

private _unitName = ENEMY_LIST_UNITS call BIS_fnc_selectRandom;
private _unit = _group createUnit [_unitName, _pos,[],ENEMY_SKILLS,"NONE"];

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
//[_unit] call fnc_handleAttacked;

if (!_excludedFromSpawnedUnit)then{
    UNITS_SPAWNED pushback _unit;
};

_unit


