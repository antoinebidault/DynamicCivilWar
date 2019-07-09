/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

params [
	"_leader",
	"_assistant",
	"_target",
	"_helo"
];

_assistant setUnitPos "MIDDLE";
_leader setUnitPos "MIDDLE";
_assistant disableAI "AUTOCOMBAT";
_leader disableAI "AUTOCOMBAT";
[_assistant] joinSilent grpNull;
sleep 3;

_assistant doMove [((position _target) select 0) + (1 + random 3) ,((position _target) select 1) + random 3 ,((position _target) select 2)];

[_leader,_target] spawn DCW_fnc_heal;

waitUntil { sleep 3; isNil '_assistant' || !alive _assistant || !alive _target || _target getVariable["unit_stabilized",false] };
if (isNil '_assistant' || !alive _assistant || !alive _target) exitWith { MEDEVAC_State = "aborted"; };

_assistant setUnitPos "AUTO";
[_assistant] joinSilent group _leader;

true;