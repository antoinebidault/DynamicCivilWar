/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Handle damage to civilian

  Parameters:
    0: OBJECT - civilian unit

  Returns:
    BOOL - true 
*/


_this addEventHandler["HandleDamage",{
	params [
		"_unit",			// Object the event handler is assigned to.
		"_hitSelection",	// Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
		"_damage",			// Resulting level of damage for the selection.
		"_source",			// The source unit (shooter) that caused the damage.
		"_projectile",		// Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.) (String)
		"_hitPartIndex",	// Hit part index of the hit point, -1 otherwise.
		"_instigator",		// Person who pulled the trigger. (Object)
		"_hitPoint"			// hit point Cfg name (String)
	];
	
	if !(local _unit) exitWith {false};
	if (_damage == 0) exitWith {false};
	
	if ( _damage > .9 && !(_unit getVariable["DCW_unit_injured",false])) then {
		[_unit] spawn DCW_fnc_shout;	
		_unit setUnconscious true;
		_unit setVariable ["DCW_unit_injured", true, true];
		
		_unit setDamage .9;
		_damage = .9;
		_unit setHit ["legs", 1];

		if (DEBUG) then {
			_marker = createMarker [format["body-%1", name _unit], position _unit];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerColor "ColorOrange";
			_marker setMarkerText localize "STR_DCW_handleKill_injuredCivil";
			_unit setVariable ["marker", _marker];
		};

		// Score penalty
        [GROUP_PLAYERS,-40,false,_source] remoteExec ["DCW_fnc_updateScore",2];   

		_unit call DCW_fnc_addActionHeal;
		
	}else{
		if (_unit getVariable["DCW_unit_injured",false])then{_damage = .9;};
	};
	_damage;
}];
