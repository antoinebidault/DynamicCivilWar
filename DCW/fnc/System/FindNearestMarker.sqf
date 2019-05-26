/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params["_pos","_excludeTheClosest","_notSecured"];
if (isNil '_excludeTheClosest')then {_excludeTheClosest = true;};
if (isNil '_notSecured')then {_notSecured = true;};

private _nearest = "";
private _return = [];
if(count(MARKERS)>0) then {
	_nearest = (MARKERS select 0) select 0;
	
	{
		private _m = _x select 0;
		if(((_notSecured && _x select 12 == "default") || !_notSecured) && ((getmarkerpos _m) distance _pos < (getmarkerpos _nearest) distance _pos) &&  (!_excludeTheClosest || ((getmarkerpos _m) distance _pos > 300))  ) then
		{
			_return = _x;
			_nearest = _m;
		};
	} forEach MARKERS;
};

if (count _return == 0) then { _return = (MARKERS select 0); };

_return;