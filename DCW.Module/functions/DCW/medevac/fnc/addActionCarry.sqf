
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


_this addAction ["<t color='#ff0000'>Drag</t>",{
	params["_unit","_asker","_action"];
	_unit removeAction _action;
	[_asker, _unit] call fnc_carry;
},[], 1.5, true, true, "","true", 2, false, "",""];