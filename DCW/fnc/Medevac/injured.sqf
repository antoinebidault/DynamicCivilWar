params["_unit"];

if (vehicle _unit != _unit) then {
	doGetOut _unit;
};

_unit setUnconscious true; 
_unit setCaptive true;
_unit setVariable ["DCW_unit_injured", true, true];
_unit setHit ["legs", 1];  

sleep 6;

// Stabilize action
_unit call DCW_fnc_addActionHeal;
[_unit,"DCW_fnc_carry"] call DCW_fnc_AddAction; 

_deathsound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 1.5, 1, 150];	

if (isPlayer _unit && _unit == player) then {
	DCW_ai_reviving_cancelled = false;
	_idAction = [_unit, "Force respawn","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", "true", "true", {  }, { }, { DCW_ai_reviving_cancelled = true; }, {  }, [], 3, nil, true, true] call BIS_fnc_holdActionAdd;

	DCW_ai_current_medic = objNull;

	// Reviving loop
	while {_unit getVariable["DCW_unit_injured",false] && !DCW_ai_reviving_cancelled} do {

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
			_unit setVariable ["DCW_healer", objNull, true];
			DCW_ai_current_medic = _foundCloseUnit;
			[_foundCloseUnit, _unit,false] spawn DCW_fnc_firstAid;
		};

		hintSilent format["Medic at %1m",str round _dist];

		sleep .5;

	};

	hintSilent "";
	[_unit,"DCW_fnc_carry"] call DCW_fnc_RemoveAction; 
	[_unit,_idAction] remoteExec ["BIS_fnc_holdActionRemove"];
	_unit call DCW_fnc_removeActionHeal;
	// The soldier has been revived successfully
	if ( !(_unit getVariable["DCW_unit_injured",false]) ) exitWith { };

	// If in multiplayer => kill him
	if (isMultiplayer) then { _unit setDamage 1; };
	
	_unit setVariable["DCW_unit_injured",false,true];

} else {
	_foundCloseUnit = objNull;
	_dist = 200;
	{
		if(!isPlayer _x && alive _x && (_x distance _unit) < _dist && (lifeState _x == "HEALTHY" || lifeState _x == "INJURED")) then {
			_foundCloseUnit = _x;
			_dist = _x distance _unit;
		};
	}foreach units GROUP_PLAYERS;

	if (!isNull _foundCloseUnit) then {
		[_foundCloseUnit, ["I'm on it sir !","I'm gonna help him !","I am looking after him !"] call BIS_fnc_selectRandom] remoteExec ["DCW_fnc_talk"];
		[_foundCloseUnit,_unit,false] spawn DCW_fnc_firstAid;
	};
};
