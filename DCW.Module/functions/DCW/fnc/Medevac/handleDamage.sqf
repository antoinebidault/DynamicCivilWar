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
if (_damage == 0) exitWith {false};

// Reducing damage with a factor of 3
//_damage = 0.9 min _damage;

if (_damage >= .9 && !isPlayer _unit && !(_unit getVariable["unit_injured",false])) then {

	_unit setDamage .9;
	_damage = .9;
	
	[_unit] call fnc_injured,

    // [_unit] call fnc_removeFAKS;

	[leader GROUP_PLAYERS, ["Man down ! Man down !",format["%1 is down !",name _unit],format["%1 needs a medic !",name _unit]] call BIS_fnc_selectRandom] remoteExec ["fnc_talk"];
	
    _marker = createMarker [format["DCW-injured-%1", name _unit], position _unit];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorOrange";
    _marker setMarkerText format["An injured comrade : %1", name _unit];
	_unit setVariable ["DCW_marker_injured",  _marker];

	_foundCloseUnit = objNull;
	_dist = 200;
	{
		if(!isPlayer _x && alive _x && (_x distance _unit) < _dist && (lifeState _x == "HEALTHY" || lifeState _x == "INJURED")) then {
			_foundCloseUnit = _x;
			_dist = _x distance _unit;
		};
	}foreach units GROUP_PLAYERS;

	if (!isNull _foundCloseUnit) then {
		[_foundCloseUnit, ["I'm on it sir !","I'm gonna help him !","I am looking after him !"] call BIS_fnc_selectRandom] remoteExec ["fnc_talk"];
		[_foundCloseUnit,_unit,false] spawn fnc_firstaid;
	};

}else{
	if (_unit getVariable["unit_injured",false])then{
		_damage = .9;
	};
};

_damage;