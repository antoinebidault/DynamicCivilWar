/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit", "_killer"];


if (_unit getVariable ["unit_injured", false]) then {
	_unit setVariable["unit_injured",false, true];
};