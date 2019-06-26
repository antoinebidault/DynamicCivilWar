/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 *
 * Modified script of SPUn / LostVar
 */


private _unit = _this select 0;
private _radius = _this select 1;
private _meetPoint = _this select 2;
private _buildings = _this select 3;
private _center = _this select 4;
private _foundInjuredUnit = objNull;
sleep 10 + floor(random 30);

{
    if (side _x == SIDE_CIV && isNull(_x getVariable["healer",objNull]) && lifeState _x == "INCAPACITATED") then {
        _foundInjuredUnit = _x;
    };
} foreach nearestObjects [_center,["Man"],_radius];

if (!isNull _foundInjuredUnit) then {
    [_unit, _foundInjuredUnit,true] spawn DCW_fnc_firstaid;
} else {
    [_unit,_radius,_meetPoint,_buildings] spawn DCW_fnc_CivilianCompoundPatrol;
};

false;
