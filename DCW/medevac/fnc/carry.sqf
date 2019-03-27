/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Carry script
// Not used
//Credits to Psycho

params["_unit","_target"];


_DummyClone = {
	private ["_dummy", "_dummygrp", "_dragger"];
	_dragger = _this;
	// create Dummy unit that dragger attaches to, dummy unit moves and simulates dragger moving
	_dummygrp = createGroup EAST;
	_dummy = _dummygrp createUnit ["RU_soldier", Position _dragger, [], 0, "FORM"];
	_dummy setUnitPos "up";
	_dummy hideobject true;
	_dummy allowdammage false;
	_dummy setBehaviour "CARELESS";
	_dummy disableAI "FSM";
    _dummy forceSpeed 1.5;
	_dragger attachTo [_dummy, [0, -0.2, 0]]; 
	_dragger setDir 180;
	// return dummy object
	_dummy
};

if (primaryWeapon _unit != "") then {
	_unit switchmove "amovpercmstpsraswrfldnon";
	_unit selectWeapon (primaryWeapon _unit);
};
sleep 3;
doStop _unit;
_unit doMove position _target;
waitUntil { _unit distance2D _target < 3 };

detach _unit;
detach _target;

_pos = _unit ModelToWorld [0,1.8,0];
_target setPos _pos;
[_target, "grabCarried"] remoteExec ["playActionNow", 0, false];
disableUserInput true;
sleep 2.5;
if (!isPlayer _target) then {_target disableAI "ANIM"};
[_unit, "grabCarry"] remoteExec ["playActionNow", 0, false];
//_unit playActionNow "grabCarry";
disableUserInput false;
disableUserInput true;
disableUserInput false;

_timenow = time;
waitUntil {!alive _target || {!alive _unit} ||  {time > _timenow + 16}};
_state = _target getVariable ["unit_injured", false];
if (!alive _target || {!alive _unit} || {!_state}) then {
	if (alive _target) then {
		[_target, "agonyStart"] remoteExec ["playActionNow", 0, false];
	};
	if (alive _unit && {!(_state)}) then {
		[_unit, "amovpknlmstpsraswrfldnon"] remoteExec ["playMoveNow", 0, false];
	};
	_target setVariable ["unit_onback", objNull];
} else {
	_dummy = _unit call _DummyClone;
	_target setVariable ["unit_onback", _dummy];
	_target attachTo [_unit, [-0.6, 0.28, -0.05]];
	[_target, 0] remoteExec ["setDir", 0, false];
};

