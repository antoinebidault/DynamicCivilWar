/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_unit = _this;

if(!alive ENEMY_COMMANDER)exitWith {false};
if(count COMMANDER_LAST_POS == 0) exitWith {[_unit,"I don't know where he is."] spawn fnc_Talk;false;};

_pos = COMMANDER_LAST_POS call BIS_fnc_selectRandom;
COMMANDER_LAST_POS = COMMANDER_LAST_POS - [_pos];


[_unit,"I marked you on the map where I think he is."] spawn fnc_Talk;

_ratio = 0.8;
_offset = 40;
_distance = 250 + random 250;

/*if (getMarkerColor "commander_intel" != "") then{
    _distance = ENEMY_COMMANDER distance (getMarkerpos "commander_intel");
};*/

//Get the marker position
_pos = [_pos, _offset, (_distance - _offset) , 0, 0, 20, 0] call BIS_fnc_FindSafePos;

deleteMarker "DCW_intel_q";
_marker = createMarker ["DCW_intel_q",_pos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "SearchArea";
_marker setMarkerType "hd_unknown";
_marker setMarkerPos _pos;

deleteMarker "DCW_intel_c";
_marker = createMarker ["DCW_intel_c",_pos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorRed";
_marker setMarkerBrush "Border";
_marker setMarkerSize [_distance,_distance];
_marker setMarkerPos _pos;

true;