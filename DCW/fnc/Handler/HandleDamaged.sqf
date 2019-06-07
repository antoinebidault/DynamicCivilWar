/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
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
	
	if ( _damage > .9 && !(_unit getVariable["unit_injured",false])) then {
		[_unit] spawn fnc_shout;	
		_unit setUnconscious true;
		_unit setVariable ["unit_injured", true, true];
		
		_unit setDamage .9;
		_damage = .9;
		_unit setHit ["legs", 1];

		if (DEBUG) then {
			_marker = createMarker [format["body-%1", name _unit], position _unit];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerColor "ColorOrange";
			_marker setMarkerText "Injured civil";
			_unit setVariable ["marker", _marker];
		};

		_unit call fnc_addActionHeal;
		
	}else{
		if (_unit getVariable["unit_injured",false])then{_damage = .9;};
	};
	_damage;
}];