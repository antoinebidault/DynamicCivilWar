/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit", "_killer"];


if (_unit getVariable ["unit_KIA", false]) then {
	_unit setVariable["unit_KIA",true, true];
	[leader (group _unit), "Shit ! We have a KIA soldier here !",true] spawn fnc_talk;
};