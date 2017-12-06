/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Credits : Psycho

params [
	"_healer",
	"_injured"
];
HEALER = _healer;
{_healer disableAI _x; true} count ["TARGET","FSM","AUTOTARGET","AUTOCOMBAT"];
_healer doMove position _injured;
waitUntil { _healer distance _injured < 5 || speed _healer == 0 };
sleep 5;

if (speed _healer == 0) exitWith{ [_healer,_injured] call fnc_heal;};

_injured setVariable ["unit_healed", _healer, true];

// move the wounded out of the vehicle
if (!isNull objectParent _injured) exitWith {
	_injured action["Eject", vehicle _injured];
	sleep 1;
    [_healer, _injured] call fnc_heal;
};

//[_injured, "AinjPpneMstpSnonWrflDnon_rolltoback"] remoteExec ['playMove', 0];

// switch to primary weapon if possible. Small delay for handling is needed.
if (primaryWeapon _healer != "") then {
	_healer selectWeapon primaryWeapon _healer;
	sleep 0.5;
};

_healer setPos (getPos _injured);	// avoid to move the injured a few metres away

_healer stop true;

_healer playActionNow "medicStart";
sleep 1;

_offset = [0,0,0]; _dir = 0;
_relpos = _healer worldToModel position _injured;
if ((_relpos select 0) < 0) then {_offset = [-0.2,0.7,0]; _dir = 90} else {_offset = [0.2,0.7,0]; _dir = 270};

_injured attachTo [_healer, _offset];
[_injured, _dir] remoteExec ["setDir", 0, false];

private _duration = [_healer, _injured] call fnc_calculateTimeToHeal;
[_healer, _injured,_duration] call fnc_spawnHealEquipement;

_injured setVariable ["unit_stabilized", false];

private _startTime = diag_tickTime + _duration;
waitUntil {
	diag_tickTime > _startTime ||
	!alive _healer ||
	!alive _injured ||
	_injured getVariable ["unit_stabilized", false]
};


detach _healer;
detach _injured;

if (!alive _healer) exitWith {};
_healer playActionNow "medicStop";

_healer stop false;
_healer setBehaviour "CARELESS";

if (alive _injured) then {
	hint "unit revived";
	_injured setBehaviour "CARELESS";
	{_injured disableAI _x; true} count ["TARGET","FSM","AUTOTARGET","AUTOCOMBAT"];
	_injured setUnconscious false;
	_injured setCaptive false;
    removeHeadgear _injured;
    removeGoggles _injured;
    removeBackpack _injured;
    removeAllWeapons _injured;
    _injured setSpeedMode "FULL";
	_injured setDamage 0;
    _injured setHit ["legs", 0]; 
	_injured forceWalk false;
	_injured stop false;
	_injured setUnitPos "UP";
	[_injured] join grpNull;

	deleteMarker _injured setVariable ["unit_marker", ""];
	_injured removeEventHandler ["HandleDamage",0];
	_injured addEventHandler ["Killed",{ [transportHelo] call fnc_abortMedevac; }];
	
    sleep 3;

	{_injured enableAI _x; } count ["MOVE","TARGET","AUTOTARGET","ANIM"];
	_injured setVariable ["unit_stabilized", true];
	_marker = _injured getVariable ["unit_marker", ""];

};


true