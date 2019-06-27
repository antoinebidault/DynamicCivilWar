
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */




[_this, {
	params["_unit","_actionName"];
	_actionID = _unit getVariable[_actionName, -1];
	if (_actionId != -1) then {
		[_unit,_actionID] remoteExec ["removeAction"]; 
		_unit setVariable[_actionName, -1];
	};
}] remoteExecCall ["call", 0]; 