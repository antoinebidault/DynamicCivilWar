/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

_unit = _this;

if(!alive ENEMY_COMMANDER)exitWith {false};
if(count COMMANDER_LAST_POS == 0) exitWith {false};

_pos = COMMANDER_LAST_POS call BIS_fnc_selectRandom;
COMMANDER_LAST_POS = COMMANDER_LAST_POS - [_pos];


[_unit,"I marked you on the map where I think he is."] spawn fnc_Talk;

_ratio = 0.8;
_offset = 40;
_distance = 500;

if (getMarkerColor "commander_intel" != "") then{
    _distance = ENEMY_COMMANDER distance (getMarkerpos "commander_intel");
};

//Get the marker position
//_posMarker = ([_pos,false] call fnc_FindNearestMarker) select 1;
_pos = [_pos, _offset, (_distance - _offset) , 0, 0, 20, 0] call BIS_fnc_findSafePos;

deleteMarker "commander_intel";
_marker = createMarker ["commander_intel",_pos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "SearchArea";
_marker setMarkerType "hd_unknown";
_marker setMarkerPos _pos;

deleteMarker "commander_intel_2";
_marker = createMarker ["commander_intel_2",_pos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorRed";
_marker setMarkerBrush "Border";
_marker setMarkerSize [_distance,_distance];
_marker setMarkerPos _pos;

true;