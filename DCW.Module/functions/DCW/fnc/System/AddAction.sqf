
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
[_this,{
	params["_unit","_actionName"];
	_actionId = _unit addAction ["<t color='#ff0000'>Drag</t>",format["
		params[""_unit"",""_asker"",""_action""];
		[_asker, _unit] call DCW_fnc_carry;
	",_actionName],[], 1.5, true, true, "","true", 2, false, "",""];
	_unit setVariable[_actionName, _actionId,true];
}] remoteExecCall ["call", 0]; 