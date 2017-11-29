/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

	params ["_unit","_bonus","_silent"];
	_silent = if (isNil '_silent') then{false}else{true};
	_score = _unit getVariable ["IH_SCORE",0];
	_score = (_score + _bonus);
	_unit setVariable ["IH_SCORE",_score];
	private _scoreType = if (_bonus > 0) then {"+"}else{""};

	if (!_silent)then{
		["ScoreAdded",[format["Total points = %1",_score],_bonus,_scoreType]] call BIS_fnc_showNotification;
	};
	_unit call fnc_displayscore;

	