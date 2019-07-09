/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Spawn a sniper team around the designated position and radius

  Parameters:
    0: ARRAY - position
    1: NUMBER - radius
    2: NUMBER - Nb snipers (min 1)

  Returns:
    ARRAY - units array 
*/

private _pos = _this select 0;
private _radius = _this select 1;
private _nbSnipers = _this select 2;
private _units = [];

if (_nbSnipers > 0) then {
    _sniperPos = [_pos,1.1*_radius, 1.4*_radius, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _grp = createGroup SIDE_ENEMY;
    for "_xc" from 1 to _nbSnipers do {
        
        _unitName = ENEMY_SNIPER_UNITS call BIS_fnc_selectRandom;
        _unit = _grp createUnit [_unitName, _sniperPos,[],AI_SKILLS,"NONE"];
        [_unit] joinSilent _grp;

        [_unit,"ColorRed"] call DCW_fnc_addmarker;
        _unit setVariable["DCW_Type","sniper", true];
        UNITS_SPAWNED_CLOSE pushback _unit;
        _unit doWatch _pos;

        // Spawn the sniper
        if (_xc == 1)then{
          _unit call DCW_fnc_loadoutSniper;
          _unit setVariable["DCW_TaskNotCompleted",true, true];
          _unit setUnitPos "DOWN";
          
           //Handle success of the mission
          _unit addMPEventHandler ["MPKilled",
          { 
            params["_unit","_killer"];
            if (group _killer == GROUP_PLAYERS) then{
                _unit remoteExec ["DCW_fnc_success",2, false];
            };
          }];
        }else{
          // Spawn the spotter
          _unit call DCW_fnc_loadoutSpotter;
          _unit setUnitPos "MIDDLE";
          _unit addWeapon "Binocular";
          _unit selectWeapon "Binocular";
        };

        _units pushBack _unit;
    };
};


_units;