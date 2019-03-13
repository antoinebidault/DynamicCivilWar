/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_group","_bonus","_silent", "_unit"];
_silent = if (isNil '_silent' ) then{false}else{true};

_score = _group getVariable ["DCW_SCORE",0];
_score = (_score + _bonus);

_group setVariable ["DCW_SCORE",_score];
private _scoreType = if (_bonus > 0) then {"+"}else{""};

if (!_silent)then{
	["ScoreAdded",[format["Total points = %1",_score],_bonus,_scoreType]] remoteExec ["BIS_fnc_showNotification"];
};

{
  _x remoteExec ["fnc_displayscore",_x, false];
} foreach allPlayers;
	