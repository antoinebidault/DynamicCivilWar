/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

params["_pos","_excludeTheClosest","_compoundState"];
if (isNil '_excludeTheClosest')then {_excludeTheClosest = true;};
if (isNil '_compoundState')then {_compoundState = "neutral";};
if (!isServer) then {MARKERS = [ missionNamespace, "MARKERS", []] call BIS_fnc_getServerVariable;};

private _nearest = "";
private _return = [];
if(count(MARKERS)>0) then {
	_nearest = (MARKERS select 0) select 0;
	
	{
	     _m = _x select 0;
		_state = _x select 12;
		if((_compoundState == "any" || _state == _compoundState) && ((getmarkerpos _m) distance _pos < (getmarkerpos _nearest) distance _pos) &&  (!_excludeTheClosest || ((getmarkerpos _m) distance _pos > 300))  ) then
		{
			_return = _x;
			_nearest = _m;
		};
	} forEach MARKERS;
};

if (count _return == 0) then { _return = (MARKERS select 0); };

_return;