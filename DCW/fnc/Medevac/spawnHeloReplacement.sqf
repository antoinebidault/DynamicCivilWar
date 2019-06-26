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
	[_soldier] joinSilent _groupReplacement;
	_soldier setUnitLoadout (getUnitLoadout _x);

	_x setskill 1;
	_x setUnitAbility 1;
	_x allowFleeing 0;
	_x setskill ["aimingAccuracy", 1];
	_x setskill ["aimingShake", 1];
	_x setskill ["aimingSpeed", 1];
	_x setskill ["spotDistance", 1];
	_x setskill ["spotTime", 1];
	_x setskill ["commanding", 1];
	_x setskill ["courage", 1];
	_x setskill ["general", 1];
	_x setskill ["reloadSpeed", 1];
	_x removeAllEventHandlers "HandleDamage";
	_soldier addEventHandler ["HandleDamage",{_this call DCW_fnc_HandleDamage;}];
	_soldier addMPEventHandler ["MPKilled",{_this call DCW_fnc_HandleKilled;}];
	
	addSwitchableUnit _soldier;
	_soldier moveInCargo _transportHelo; 

} foreach _units ;

_groupReplacement;