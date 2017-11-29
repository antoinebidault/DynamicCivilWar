/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private ["_timer","_rndMarker","_rndPos","_radius","_newPos"];
params ["_unit","_marker"];

_unit addWeapon "Binocular";

while { alive _unit }do{
    _rndMarker = ([position _unit] call fnc_findNearestMarker) select 0;;
    _rndPos = getMarkerPos _rndMarker;
    _radius = (getMarkerSize _rndMarker) select 0;
    _newPos = [_rndPos, 1, _radius, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    group _unit move _newPos;
    
    waitUntil {sleep 5;unitReady _unit || _unit distance _newPos < 2 };

    _unit setUnitPos "Middle";
    _unit selectWeapon "Binocular";
    sleep 10 + random 60;
    _unit selectWeapon (primaryWeapon _unit);
    _unit setUnitPos "AUTO";

    sleep 5;
    [_unit] call fnc_gotomeeting;
    sleep 5;
};