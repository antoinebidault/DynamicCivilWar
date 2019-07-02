params["_grp","_fnName","_params"];

if (!isMultiplayer) then {
	_params remoteExec [_fnName];
} else{
	_HC_ID = _grp call DCW_fnc_sendToHC;
	_params remoteExec [_fnName,_HC_ID];
};