    


/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Credits to psycho & BonInf* 
 */

params["_healer","_injuredperson","_ambient"]; 

private ["_injuredperson","_healer","_behaviour","_timenow","_relpos","_dir","_offset","_time","_damage","_isMedic","_healed","_animChangeEVH","_skill_factor"];
_behaviour = behaviour _healer;
if(!isNull (_injuredperson getVariable ["healer", objNull])) exitWith{false};
_injuredperson setVariable ["healer", _healer, true];
_injuredperson setUnconscious true;

if (!isPlayer _healer && {_healer distance _injuredperson > 6}) then {
	_healer setBehaviour "AWARE";
	_healer doMove (position _injuredperson);
	_timenow = time;
	WaitUntil {
		sleep 1;
		_healer distance _injuredperson <= 4		 		||
		{!alive _injuredperson}			 					||
		{!alive _healer}				 					||
		{_timenow + 120 < time}
	};
};


_healer selectWeapon primaryWeapon _healer;
sleep 1;
_healer playAction "medicStart";

if (!isPlayer _healer) then {
	_healer stop true;
	_healer disableAI "MOVE";
	_healer disableAI "TARGET";
	_healer disableAI "AUTOTARGET";
	_healer disableAI "ANIM";
};

_offset = [0,0,0]; _dir = 0;
_relpos = _healer worldToModel position _injuredperson;
if((_relpos select 0) < 0) then{_offset=[-0.2,0.7,0]; _dir=90} else{_offset=[0.2,0.7,0]; _dir=270};

_injuredperson attachTo [_healer,_offset];
_injuredperson setDir _dir;
_time = time;


if (_ambient) then {
	waitUntil {sleep 10; lifeState _injuredperson != "INCAPACITED" || !alive _healer;};
} else{
	sleep 1;
	_skill_factor = 40+(random 10);
	_damage = (damage _injuredperson * _skill_factor);
	if (_damage < 5) then {_damage = 5};
	while {
		time - _time < _damage
		&& {alive _healer}
		&& {alive _injuredperson}
		&& {(_healer distance _injuredperson) < 2}
	} do {
		sleep 0.5;
	};
};

detach _healer;
detach _injuredperson;

_injuredperson setDamage 0;
_injuredperson setUnconscious false;
_injuredperson setVariable["unit_injured",false];

if (!isPlayer _healer) then {
	_healer stop false;
	_healer enableAI "MOVE";
	_healer enableAI "TARGET";
	_healer enableAI "AUTOTARGET";
	_healer enableAI "ANIM";
};

if (alive _healer) then {
	_healer playAction "medicStop";
	_healer setBehaviour _behaviour;
};

if (!alive _injuredperson) exitWith {};
if (!alive _healer) exitWith {};
_injuredperson setVariable ["healer",ObjNull,true];
