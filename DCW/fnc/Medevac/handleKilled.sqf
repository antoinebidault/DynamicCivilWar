/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

params ["_unit", "_killer"];


if (_unit getVariable ["unit_KIA", false]) then {
	_unit setVariable["unit_KIA",true, true];
	[leader (group _unit), "Shit ! We have a KIA soldier here !",true] spawn DCW_fnc_talk;
};