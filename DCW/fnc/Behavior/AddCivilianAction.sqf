 /*
	Author: 
		Bidass

  Version:
    {VERSION}

	Description:
		Add the base civilian action.
		"Say hello"
		"Leave"
		"Capture him"

	Parameters:
		0: OBJECT - unit (Must be a civilian)

	Returns:
		BOOL - true 
*/

params ["_unit"];

_unit call DCW_fnc_addActionHalt;
_unit call DCW_fnc_addActionLeave;
_unit call DCW_fnc_addActionHandcuff;

true;