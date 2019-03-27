/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_transportHelo = _this select 0;
_side = _this select 1;
_units = _this select 2;

_groupReplacement = createGroup _side;

{
	_soldier = _groupReplacement createUnit [typeOf(_x), position _transportHelo, [], 0, "NONE"];
	_soldier setUnitLoadout (getUnitLoadout _x);
	_soldier addEventHandler ["HandleDamage",{_this call fnc_HandleDamage;}];
	_soldier addMPEventHandler ["MPKilled",{_this call fnc_HandleKilled;}];
	addSwitchableUnit _soldier;
	_soldier moveInCargo _transportHelo; 
} foreach _units ;

_groupReplacement;