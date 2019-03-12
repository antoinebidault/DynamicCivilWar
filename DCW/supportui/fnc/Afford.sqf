/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

	params ["_group","_price"];

	_score = _group getVariable ["DCW_SCORE",0];
	_score = (_score - _price);
	if (_score < 0) then{
		hint "Can't afford this";
		false;
	}else{
		[_group,-_price] spawn fnc_updatescore;
		true;
	};