
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_actionID = _this getVariable["DCW_carry_actionid", 0];
if (_actionId != 0) then {
	[_this,_actionID] remoteExec ["removeAction"]; 
};