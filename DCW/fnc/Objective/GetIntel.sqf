/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _unit = _this select 0;
private _asker = _this select 1;
private _probability  =  if (count _this == 3) then { _this select 2 } else { 50 };

private _pos = getPosASL _unit;
private _potentialIntel = [];
{
    if (_x select 2)then{
        {
          //  && _x getVariable["DCW_type",""] != "ied"
            if (!(_x getVariable["DCW_IsIntelRevealed",false]) && _x != _unit  && _x getVariable["DCW_IsIntel",false] && _pos distance _x < 500)then{
                _potentialIntel pushBack _x;
            };
        } foreach (_x select 5);
    };
} forEach MARKERS;

if (count _potentialIntel == 0 || random 100 < _probability ) exitWith { 
    if (alive _unit) then {
        [_unit, ["I have no idea...","I can't talk about this..."] call BIS_fnc_selectRandom,true] remoteExec ["fnc_talk",0]; 
    };
};

private _intel = _potentialIntel call BIS_fnc_selectRandom;
_task = [_intel,true] call fnc_createtask;
_taskId = _task select 0;
_message = _task select 1;
_intel setVariable["DCW_IsIntelRevealed",true];
private _marker = createMarker [format["s%1",random 13100],getPos _intel];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorBlack";
_marker setMarkerType "hd_objective";
_intel setVariable["DCW_MarkerIntel",_marker];
[_asker, "HQ, I found some informations !",true] remoteExec ["fnc_talk"];
[HQ, "Good job, keep up the good work !",true] remoteExec ["fnc_talk"];
[true,_message];