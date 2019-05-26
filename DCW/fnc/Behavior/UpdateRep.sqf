/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params["_unit","_score"];

// Always executed on server side
if (!isServer) exitWith{};
if (isNull _unit) exitWith{};

/*
_startScore = _unit getVariable["DCW_Friendliness",50];
_unit setVariable["DCW_Friendliness",(0 max (100 min (_startScore + _score))), true];
*/
// Get the closest marker
_compound = ([position _unit,false] call fnc_findNearestMarker);
[_compound,_score,0] spawn fnc_setCompoundSupport;