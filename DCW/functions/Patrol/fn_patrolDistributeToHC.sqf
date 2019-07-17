/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Distribute the patrol to Headless client if in multiplayer.

  Parameters:
    0: OBJECT - GROUP 
    1: STRING - Function to execute
    2: ARRAY - Params
*/


params["_grp","_fnName","_params"];

if (!isMultiplayer) then {
	_params remoteExec [_fnName];
} else{
	_HC_ID = _grp call DCW_fnc_sendToHC;
	_params remoteExec [_fnName,_HC_ID];
};