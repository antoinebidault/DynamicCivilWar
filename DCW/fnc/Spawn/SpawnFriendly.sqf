/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _group = _this select 0;
private _pos = _this select 1;
private _excludedFromSpawnedUnit = _this select 2;

private _unitName = FRIENDLY_LIST_UNITS call BIS_fnc_selectRandom;
private _unit = _group createUnit [_unitName, _pos,[],ENEMY_SKILLS,"NONE"];

if (DEBUG)then{
    [_unit,"ColorGreen"] call fnc_addmarker;
};

_unit remoteExec ["addActionGiveUsAHand"];

if (!_excludedFromSpawnedUnit)then{
    UNITS_SPAWNED pushback _unit;
};

_unit


