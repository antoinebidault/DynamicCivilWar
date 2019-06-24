/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

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
//&& {_hitSelection in ["", "head", "body"]}
if !(local _unit) exitWith {false};
if (_damage == 0) exitWith {false};

// Reducing damage with a factor of 3
_damage = 0.9 min (_damage * 0.33);
if ( _damage >= .9 && !isPlayer _unit && !(_unit getVariable["unit_injured",false])) then {
	
	[_unit] call fnc_injured,

    // [_unit] call fnc_removeFAKS;

	_unit setDamage .9;
	_damage = .9;

	[leader GROUP_PLAYERS, ["Man down ! Man down !",format["%1 is down !",name _unit],format["%1 needs a medic !",name _unit]] call BIS_fnc_selectRandom] remoteExec ["fnc_talk"];
	
    _marker = createMarker [format["DCW-injured-%1", name _unit], position _unit];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorOrange";
    _marker setMarkerText format["An injured comrade : %1", name _unit];
	_unit setVariable ["DCW_marker_injured",  _marker];

}else{
	if (_unit getVariable["unit_injured",false])then{
		_damage = .9;
	};
};

//_unit setDamage _damage;

_damage;