
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


[_this,  ["<t color='#ff0000'>Drag</t>",{
	params["_unit","_asker","_action"];
	_this setVariable["DCW_carry_actionid", _action,true];
	[_asker, _unit] call DCW_fnc_carry;
},[], 1.5, true, true, "","true", 2, false, "",""]] remoteExec ["addAction"];
