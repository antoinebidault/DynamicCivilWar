[_this, {
	[_this,_this getVariable["DCW_fnc_addActionHeal", -1]] call BIS_fnc_holdActionRemove;
	_this setVariable ["DCW_fnc_addActionHeal", -1, true];
}] remoteExec["call",0];