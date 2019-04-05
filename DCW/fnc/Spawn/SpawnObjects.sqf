/**
 * DYNAMIC CIVIL WAR
 * Created: 2019-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_unitName","_civ"];
private _pos = _this select 0;
private _radius = _this select 1;
private _people = _this select 3;
private _buildings = _this select 5;

if (count _buildings > 0) then {
    _nb = count _buildings; 
    for "_xc" from 1 to _nbUnit do {
        
        _posSelected = [_pos,1, _radius, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
    }
};