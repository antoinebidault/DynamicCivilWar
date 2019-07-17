/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

private _group = _this select 0;
private _pos = _this select 1;
private _excludedFromSpawnedUnit = [_this,2,false] call BIS_fnc_param;
private _forcedUnitClass = [_this,3,""] call BIS_fnc_param;

// Handle the forced unit class
_unitName = "";
if (_forcedUnitClass == "") then {
  _unitName = ALLIED_LIST_UNITS call BIS_fnc_selectRandom;
}else{
  _unitName = _forcedUnitClass;
};

_unit = _group createUnit [_unitName, _pos,[],AI_SKILLS,"NONE"];
[_unit] joinsilent _group;
// _group call DCW_fnc_sendToHC;

if (DEBUG)then{
    [_unit,"ColorGreen"] call DCW_fnc_addmarker;
};

_unit remoteExec ["DCW_fnc_addActionJoinAsAdvisor"];
_unit remoteExec ["DCW_fnc_addActionJoinAsTeamMember"];

// Remove all action on death
_unit addMPEventHandler ["MPKilled",
    { 
        params["_unit","_killer"];
        _unit remoteExec ["RemoveAllActions",0];
    }
];

if (!_excludedFromSpawnedUnit)then{
    UNITS_SPAWNED_CLOSE pushback _unit;
};

_unit


