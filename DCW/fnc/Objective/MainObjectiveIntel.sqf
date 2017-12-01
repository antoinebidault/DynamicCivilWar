/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

_unit = _this;

if(!alive ENEMY_COMMANDER)exitWith {false};


[_unit,"I marked you on the map where I think the commander is."] call fnc_Talk;
_pos = getPos ENEMY_COMMANDER;
_ratio = 0.8;
_distance = 2000;

if (getMarkerColor "commander_intel" != "") then{
    _distance = ENEMY_COMMANDER distance (getMarkerpos "commander_intel");
};

//Get the marker position
//_posMarker = ([_pos,false] call fnc_FindNearestMarker) select 1;
_pos = [_pos, 0.8 * _distance, 0.98 * _distance , 0, 0, 20, 0] call BIS_fnc_findSafePos;

deleteMarker "commander_intel";
_marker = createMarker ["commander_intel",_pos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerType "hd_unknown";

_marker setMarkerPos _pos;

true;