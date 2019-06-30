/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_timer","_rndMarker","_rndPos","_radius","_newPos"];
params ["_unit"];

_unit setSpeedMode "LIMITED";
_unit forceWalk  true;

while { !(_unit getVariable ["civ_insurgent", false]) && lifeState _unit == "HEALTHY" && group _unit != GROUP_PLAYERS }do{

    _newPos = [getPos (([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom), 1, 350, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    group _unit move _newPos;
    waitUntil {sleep 5;unitReady _unit || _unit distance _newPos < 2 || _unit getVariable ["civ_insurgent", false] || lifeState _unit != "HEALTHY" };
    if (lifeState _unit != "HEALTHY" || _unit getVariable ["civ_insurgent", false]) exitWith {false};
    [_unit] call DCW_fnc_randomAnimation;
   
    _rndMarker = ([position _unit, true, "any"] call DCW_fnc_findNearestMarker) select 0;
    
    _rndPos = getMarkerPos _rndMarker;
    _radius = (getMarkerSize _rndMarker) select 0;
    _newPos = [_rndPos, 1, _radius, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    group _unit move _newPos;
    
    waitUntil {sleep 5;unitReady _unit || _unit distance _newPos < 2 || lifeState _unit != "HEALTHY" };
     if (lifeState _unit != "HEALTHY") exitWith {false};
    [_unit] call DCW_fnc_randomAnimation;
   
    _potentialIntel = [];
    {
        if (_x select 2)then{
            {
                if (!(_x getVariable["DCW_IsIntelRevealed",false]) && _x getVariable["DCW_IsIntel",false] && _newPos distance _x < 500)then{
                    _potentialIntel pushBack _x;
                };
            } foreach (_x select 5);
        };
    } forEach MARKERS;
    if (count _potentialIntel > 0 ) then {
        _newPos = [getPos (_potentialIntel call BIS_fnc_selectrandom), 1, 10, 1, 0, 20, 0] call BIS_fnc_findSafePos;
        group _unit move _newPos;
         waitUntil {sleep 5;unitReady _unit || _unit distance _newPos < 2 || lifeState _unit != "HEALTHY" };
        if (lifeState _unit != "HEALTHY" || _unit getVariable ["civ_insurgent", false]) exitWith {false};
         [_unit] call DCW_fnc_randomAnimation;
    };

    sleep 5;
	[_unit] call DCW_fnc_gotomeeting;
    sleep 5;
};

_unit forceWalk false;