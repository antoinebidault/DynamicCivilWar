/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Get a random item from units spawn in markers around the selected _unit.

  Parameters:
    0: OBJECT - Unit who is interrogated
    1: OBJECT - Unit who is asking (The player)
    2: NUMBER - Probability 

  Returns:
    ARRAY - [BOOL,OBJECT] 
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
            if (!(_x getVariable["DCW_IsIntelRevealed",false]) && _x != _unit  && _x getVariable["DCW_TaskNotCompleted",false] && _pos distance _x < 500)then{
                _potentialIntel pushBack _x;
            };
        } foreach (_x select 5);
    };
} forEach MARKERS;

// If nothing found 
if (count _potentialIntel == 0 || random 100 < _probability ) exitWith { 
  if (alive _unit) then {
      [_unit, ["I have no idea...","I can't talk about this..."] call BIS_fnc_selectRandom,true] remoteExec ["DCW_fnc_talk",owner _asker]; 
  };
  [false,"Nothing found"];
};

_intel = _potentialIntel call BIS_fnc_selectRandom;
_task = [_intel,true] call DCW_fnc_createtask;
_taskId = _task select 0;
_message = _task select 1;
_intel setVariable["DCW_IsIntelRevealed",true, true];
_marker = createMarker [format["s%1",random 13100],getPos _intel];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerType "hd_objective";
_intel setVariable["DCW_MarkerIntel",_marker];
[_asker, "HQ, I found some informations !",true] remoteExec ["DCW_fnc_talk",owner _asker];
[HQ, "Good job, keep up the good work !",true] remoteExec ["DCW_fnc_talk",owner _asker];

// Increment the stat of intel found
STAT_INTEL_FOUND = STAT_INTEL_FOUND + 1;
publicVariable "STAT_INTEL_FOUND";

[true,_message];