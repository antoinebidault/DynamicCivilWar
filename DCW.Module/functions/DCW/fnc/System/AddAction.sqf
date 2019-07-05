
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

if ((_this select 0) getVariable[(_this select 1),-1] != -1) exitWith{};

[_this,{
	params["_unit","_actionName"];
	_actionId = _unit addAction ["<t color='#ff0000'>Drag</t>",format["
		params[""_unit"",""_asker"",""_action""];
		[_asker, _unit] call DCW_fnc_carry;
	",_actionName],[], 1.5, true, true, "","true", 2, false, "",""];
	_unit setVariable[_actionName, _actionId];
}] remoteExecCall ["call", 0]; 