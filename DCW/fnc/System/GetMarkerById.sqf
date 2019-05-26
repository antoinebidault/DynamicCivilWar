params["_markerId"];


_markerIndex = 0;
_marker = MARKERS select _markerIndex;

{
	if (_markerID == (_x select 0)) exitWith { _marker = _x; _markerIndex = _foreachIndex; };
} foreach MARKERS;

_marker = MARKERS select _markerIndex;

[_marker,_markerIndex];