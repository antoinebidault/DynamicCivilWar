/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

private _group = _this select 0;
private _pos = _this select 1;
private _excludedFromSpawnedUnit = _this select 2;

private _unitName = HUMANITAR_LIST_UNITS call BIS_fnc_selectRandom;
private _unit = _group createUnit [_unitName, _pos,[],AI_SKILLS,"NONE"];
[_unit] joinsilent _group;
// _group call DCW_fnc_sendToHC;

if (DEBUG)then{
    [_unit,"ColorBlue"] call DCW_fnc_addmarker;
};

if (!_excludedFromSpawnedUnit)then{
    UNITS_SPAWNED_CLOSE pushback _unit;
};

_unit


