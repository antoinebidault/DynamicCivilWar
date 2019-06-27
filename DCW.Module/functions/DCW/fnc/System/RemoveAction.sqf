
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */




[_this,{
	params["_unit","_actionName"];
	_actionID = _unit getVariable[_actionName, 0];
	if (_actionId != 0) then {
		[_unit,_actionID] remoteExec ["removeAction"]; 
	};
}] remoteExecCall ["call", 0]; 