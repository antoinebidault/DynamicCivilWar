/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * 
 * Add a marker to map
 */


params["_unit"];

//Populate with friendlies
_securedMarker = ([position _unit,false] call fnc_findNearestMarker);

MARKERS = MARKERS - [_securedMarker];

_marker = createMarker [format["secured-whitelist-%1",str random 10000],_pos];
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerSize [300,300];

MARKER_WHITE_LIST pushback _mkrToAvoid;
    
//Suppress temporarly the marker
MARKERS = MARKERS - [_securedMarker];

_peopleToSpawn set [9,(_peopleToSpawn select 0) + ceil(random 3)];
_securedMarker  set [6,_peopleToSpawn];

_units = _securedMarker select 5;
_units = _units + ([_pos,_radius,_peopleToSpawn select 9,_meetingPointPosition, _securedMarker select 11] call fnc_SpawnFriendlyOutpost);

_marker = createMarker [format["secured-pos-%1",str random 10000],_pos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorGreen";
_marker setMarkerType "hd_flag";

MARKERS pushback _securedMarker;
