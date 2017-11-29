/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

/*
Add a marker associated to a unit. 
The marker name is stored in a variable.
BIDASS
*/

params["_unit","_color"];

if (!DEBUG) exitWith {""};
private _marker = createMarker [format["sold%1",random 100000], position _unit];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [3,3];
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor _color;
_unit setVariable["marker",_marker];
_marker;