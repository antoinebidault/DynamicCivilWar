/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/
if (!isServer) exitWith{};

params ["_group","_bonus","_silent", "_unit"];
private _silent = if (isNil "_silent") then{ false } else { _silent };

DCW_SCORE = (DCW_SCORE + _bonus);
publicVariable "DCW_SCORE"; 
private _scoreType = if (_bonus > 0) then {"+"}else{""};

if (!_silent)then{
	["ScoreAdded",[format["Total points = %1",str DCW_SCORE],_bonus,_scoreType]] remoteExec ["BIS_fnc_showNotification", _group, false];
};
[] remoteExec ["DCW_fnc_displayscore",_group, false];
