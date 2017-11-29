/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

_transportHelo = _this select 0;
_side = _this select 1;
_units = _this select 2;

_groupReplacement = createGroup _side;

{
	_soldier = _groupReplacement createUnit [typeOf(_x), position _transportHelo, [], 0, "NONE"];
	_soldier moveInCargo _transportHelo; 
} foreach _units ;

_groupReplacement;