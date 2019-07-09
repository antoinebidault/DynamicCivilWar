
/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

[_this, {
	params["_unit","_actionName"];
	_actionID = _unit getVariable[_actionName, -1];
	if (_actionId != -1) then {
		[_unit,_actionID] remoteExec ["removeAction"]; 
		_unit setVariable[_actionName, -1];
	};
}] remoteExecCall ["call", 0]; 