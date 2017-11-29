/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private ["_unit","_side","_transportHelo","_soldier"];
_transportHelo = _this select 0;
_side = _this select 1;

_interventionGroup = createGroup _side;
_soldier = typeOf(missionNamespace getVariable ["medevac_crew" , objNull]);

for "_xc" from 0 to 1 do {
	_unit = _interventionGroup createUnit [_soldier, position _transportHelo, [], 0, "FORM"];
	_unit addEventHandler["Killed",{
		[transportHelo] call fnc_abortMedevac;
	}];
};

{_x moveInCargo _transportHelo; } foreach units _interventionGroup;

_interventionGroup;