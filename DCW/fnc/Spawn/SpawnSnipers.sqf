/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _pos = _this select 0;
private _radius = _this select 1;
private _nbSnipers = _this select 2;
private _units = [];

if (_nbSnipers > 0)then{
    _sniperPos = [_pos,1.1*_radius, 1.4*_radius, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _grp = createGroup SIDE_ENEMY;
    for "_xc" from 1 to _nbSnipers do {
        
        _unitName = ENEMY_SNIPER_UNITS call BIS_fnc_selectRandom;
        _unit = _grp createUnit [_unitName, _sniperPos,[],AI_SKILLS,"NONE"];
        [_unit] joinSilent _grp;

        [_unit,"ColorRed"] call fnc_addmarker;
        [_unit] call fnc_handlekill;

        _unit setVariable["DCW_Type","sniper", true];
        UNITS_SPAWNED_CLOSE pushback _unit;
        
        _unit doWatch _pos;
        if (_xc == 1)then{
        _unit setVariable["DCW_IsIntel",true, true];
        _unit setUnitPos "MIDDLE";
        _unit addWeapon "Binocular";
        _unit selectWeapon "Binocular";

        //Handle success of the mission
        _unit addMPEventHandler ["MPKilled",
            { 
            params["_unit","_killer"];
            if (group _killer == GROUP_PLAYERS) then{
                _unit call fnc_success;
                };
            }
        ];

        }else{
        _unit setUnitPos "DOWN";
        };

        _units pushBack _unit;
    };
};


_units;