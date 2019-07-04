[_this, {
	_actionId = _this getVariable["DCW_fnc_addActionHeal", -1];
	if (_actionId != -1) then {
		[_this,_actionId] call BIS_fnc_holdActionRemove;
		_this setVariable ["DCW_fnc_addActionHeal", -1, true];
	};
}] remoteExec["call",0];