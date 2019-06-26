/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
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

[_leader,_target] spawn DCW_fnc_Heal;

waitUntil { sleep 3; isNil '_assistant' || !alive _assistant || !alive _target || _target getVariable["unit_stabilized",false] };
if (isNil '_assistant' || !alive _assistant || !alive _target) exitWith { MEDEVAC_State = "aborted"; };

_assistant setUnitPos "AUTO";
[_assistant] joinSilent group _leader;

true;