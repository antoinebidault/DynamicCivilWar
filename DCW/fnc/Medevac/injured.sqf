params["_unit"];

if (vehicle _unit != _unit) then {
	_unit leaveVehicle (vehicle _unit);
};

_unit setUnconscious true;
_unit setCaptive true;
_unit setVariable ["unit_injured", true, true];
_unit setHit ["legs", 1];  
[_unit,"DCW_fnc_carry"] call DCW_fnc_AddAction; 

// Stabilize

[_unit, {
	_actionId = [_this,"Heal","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target <= 2","true",{
			params["_injured","_healer"];
			if (!alive _injured) exitWith {};
			_healer playActionNow "medicStart";
			[_injured,"DCW_fnc_carry"] call DCW_fnc_RemoveAction; 
			_healer setVariable["healer", _injured];
			[_injured,"Aaaargh...", false] spawn DCW_fnc_talk;
			[_injured,["Sorry man... I just fucked up...","Shit ! It's a fucking mess...","I am in pain...","Don't forget the letter..."] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
			[_healer,["Don't give up mate !","Stay with us !","Stay alive !","We won't abandon you !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
			[_injured] spawn DCW_fnc_shout;
			[_healer,_injured,20] spawn DCW_fnc_spawnHealEquipement;
			_offset = [0,0,0]; _dir = 0;
			_relpos = _healer worldToModel position _injured;
			if ((_relpos select 0) < 0) then {_offset = [-0.2,0.7,0]; _dir = 90} else {_offset = [0.2,0.7,0]; _dir = 270};
			_injured attachTo [_healer, _offset];
			[_injured, _dir] remoteExec ["setDir", 0, false];
		},{
			params["_injured","_healer"];
			//_healer playActionNow "medicStart";
		},{
			params["_injured","_healer","_action"];
			_healer setVariable["healer", objNull];
			_injured setVariable ["unit_injured", false, true];
			_healer playActionNow "medicStop";
			detach _injured;
			_injured setUnconscious false;
			_injured setDamage 0;
			_injured setCaptive false;
			_injured setHit ["legs", 0]; 
			_injured call DCW_fnc_carryRemoveAction; 
			[_injured,"DCW_fnc_carry"] call DCW_fnc_RemoveAction; 
			deleteMarker (_injured getVariable ["DCW_marker_injured",  ""]);
			[_healer,["Ok, you're good to go !","Get a cover to take back strength !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
			_injured;
		},{
			params["_injured","_healer"];
			_healer setVariable["healer", objNull];
			_healer playActionNow "medicStop";
			[_injured, "DCW_fnc_carry"] call DCW_fnc_AddAction; 
			detach _injured;
		},[],15,nil,true,false] call BIS_fnc_holdActionAdd;
	_this setVariable["DCW_addAction_Injured",_actionId];
}] remoteExec ["call",0];


_deathsound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 1.5, 1, 150];	

if (isPlayer _unit && _unit == player) then {
	DCW_ai_reviving_cancelled = false;
	_idAction = [_unit, "Force respawn","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", "true", "true", {  }, { }, { DCW_ai_reviving_cancelled = true; }, {  }, [], 3, nil, true, true] call BIS_fnc_holdActionAdd;

	DCW_ai_current_medic = objNull;

	// Reviving loop
	while {_unit getVariable["unit_injured",false] && !DCW_ai_reviving_cancelled} do {

		private _foundCloseUnit = objNull;
		private _dist = 999999;
		
		if (!isNull DCW_ai_current_medic && lifeState DCW_ai_current_medic != "HEALTHY" && lifeState DCW_ai_current_medic != "INJURED") exitWith {DCW_ai_current_medic = objNull;};

		{
			if(alive _x && (_x distance _unit) < _dist && (lifeState _x == "HEALTHY" || lifeState _x == "INJURED")) then {
				_foundCloseUnit = _x;
				_dist = _x distance _unit;
			};

		}foreach units GROUP_PLAYERS;

		// Check the status
		if (_dist == 999999 || isNull _foundCloseUnit) exitWith { DCW_ai_current_medic = objNull; };
		
		if (!isNull _foundCloseUnit && isNull DCW_ai_current_medic) then {
			_unit setVariable ["healer", objNull, true];
			DCW_ai_current_medic = _foundCloseUnit;
			[_foundCloseUnit, _unit,false] spawn DCW_fnc_firstAid;
		};

		hintSilent format["Medic at %1m",str round _dist];

		sleep .5;

	};

	hintSilent "";
	[_unit,"DCW_fnc_carry"] call DCW_fnc_RemoveAction; 
	[_unit,_idAction] remoteExec ["BIS_fnc_holdActionRemove"];
	[_unit, {
		[_this,_this getVariable["DCW_addAction_Injured", 0]] call BIS_fnc_holdActionRemove;
	}] remoteExec["call",0];

	if ( !(_unit getVariable["unit_injured",true]) ) exitWith { };
	_unit setVariable["unit_injured",false,true];
};
