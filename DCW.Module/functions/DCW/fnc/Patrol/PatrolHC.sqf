params["_grp","_fn","_params"];

_HC_ID = _grp call DCW_fnc_sendToHC;

[[_fn,_params],{
	params["_fn","_params"]
	_params call _fn;
}] remoteExec ["spawn",_HC_ID];