    


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
if(!isNull (_injuredperson getVariable ["DCW_healer", objNull])) exitWith{false};
_injuredperson setVariable ["DCW_healer", _healer, true];
_injuredperson setUnconscious true;

sleep 4;

if (!isPlayer _healer && {_healer distance _injuredperson > 6}) then {
	_healer setBehaviour "AWARE";
	_healer doMove (position _injuredperson);
	_timenow = time;
	WaitUntil {
		sleep 1;
		!(_injuredperson getVariable["DCW_unit_injured",false]) ||
		_healer distance _injuredperson <= 4		 		||
		{!alive _injuredperson}			 					||
		{!alive _healer}				 					||
		{_timenow + 220 < time}
	};
};

// The player has revived him before
if (!(_injuredperson getVariable["DCW_unit_injured",false]) ) exitWith{ _injuredperson setVariable ["DCW_healer", objNull, true]; };

// Another player is healing him
if (_injuredperson getVariable ["DCW_healer", objNull] != _healer ) exitWith{}; 

// The injured is dragged by another player
if (_injuredperson getVariable ["DCW_unit_dragged", false]) exitWith{}; 

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

// Pop a smoke
if ([0,1] call BIS_fnc_selectRandom == 1 && !_ambient) then {
	_smoke = "SmokeShell" createVehicle  (_injuredperson modelToWorld[.5 + random 2,.5 + random 1,0]); 
};

[_injuredperson,"DCW_fnc_carry"] call DCW_fnc_removeAction;
_injuredperson call DCW_fnc_removeActionHeal;

if (_ambient) then {
	waitUntil {sleep 10; lifeState _injuredperson != "INCAPACITATED" || !alive _healer;};
} else{
	sleep 1;
	_skill_factor = 30+(random 10);
	_damage = (damage _injuredperson * _skill_factor);
	if (_damage < 5) then {_damage = 5};
	[_healer, _injuredperson,_damage] call DCW_fnc_spawnHealEquipement;
	while {
		time - _time < _damage
		&& _injuredperson getVariable["DCW_unit_injured",false]
		&& {alive _healer}
		&& {alive _injuredperson}
		&& lifeState _healer != "INCAPACITATED"
		&& {(_healer distance _injuredperson) < 2}
	} do {
		sleep 0.5;
	};
};

detach _healer;
detach _injuredperson;

if (alive _healer && alive _injuredperson && _injuredperson getVariable["DCW_unit_injured",false]) then {
	
	if (rating _injuredperson < 0) then {
		_injuredperson addRating ((-(rating _injuredperson)) + 1000);
	};
	_injuredperson setDamage 0;
	_injuredperson setCaptive false;
	_injuredperson setUnconscious false;
	_injuredperson setVariable["DCW_unit_injured",false,true];
	deleteMarker (_injuredperson getVariable ["DCW_marker_injured",  ""]);

	if (isPlayer _injuredperson && (leader GROUP_PLAYERS) == _injuredperson) then {
		_injuredperson remoteExec ["removeAllActions"];
		sleep .3;
		_injuredperson call DCW_fnc_actionCamp;
		_injuredperson call DCW_fnc_addSupportUi;
	};

	resetCamShake;
} else {
	if (damage _injuredperson >= .9 && lifeState _injuredperson == "INCAPACITATED") then {
		[_injuredperson,"DCW_fnc_carry"] call DCW_fnc_addAction; 
		_injuredperson call DCW_fnc_addActionHeal;
	};
};

_injuredperson setVariable ["DCW_healer",ObjNull,true];

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
