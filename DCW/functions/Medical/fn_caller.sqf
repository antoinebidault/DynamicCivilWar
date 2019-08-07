/*
  Author: 
    Bidass

  Version:
    0.9.1

  Description:
    Init the state of the chopper helo evacuation
	NOTE : this is actually obsolete.

  Parameters:
    0: OBJECT - unit
    1: OBJECT - dead soldiers

  Returns:
    BOOL - true 
*/



params["_unit","_soldiersDead"];

if (MEDEVAC_State == "menu") then {
	// Delete all useless commmenu item
	MEDEVAC_MENU_LASTID = [_unit, localize "STR_DCW_fnCaller_medevacMenu"] call BIS_fnc_addCommMenuItem;
};

if (MEDEVAC_State == "inbound") then{
	MEDEVAC_action = _unit addAction [localize "STR_DCW_fnCaller_abortMedevac", { 
		params["_unit","_actionId"];
		_unit removeAction MEDEVAC_action;
		MEDEVAC_State = "aborted";
		publicVariableServer "MEDEVAC_State";
	}];
	publicVariableServer "MEDEVAC_ACTION";
};
