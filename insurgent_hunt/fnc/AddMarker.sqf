params["_unit","_color"];

if (!DEBUG) exitWith {""};
private _marker = createMarker [format["sold%1",random 100000], position _unit];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [3,3];
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor _color;
_unit setVariable["marker",_marker];
_marker;