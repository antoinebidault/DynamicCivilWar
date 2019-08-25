/*
  Author: 
    Bidass

  Version:
    0.9.1

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
	[leader (group _unit), localize "STR_DCW_voices_teamLeader_kia",true] spawn DCW_fnc_talk;
};
