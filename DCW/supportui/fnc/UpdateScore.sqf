/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
if (isnull player) exitWith{ hint "executed on server..." };

params ["_group","_bonus","_silent", "_unit"];
private _silent = if (isNil "_silent") then{ false } else { _silent };

DCW_SCORE = (DCW_SCORE + _bonus);
private _scoreType = if (_bonus > 0) then {"+"}else{""};

if (!_silent)then{
	["ScoreAdded",[format["Total points = %1",str DCW_SCORE],_bonus,_scoreType]] remoteExec ["BIS_fnc_showNotification", _group, false];
};
[] remoteExec ["fnc_displayscore",_group, false];
