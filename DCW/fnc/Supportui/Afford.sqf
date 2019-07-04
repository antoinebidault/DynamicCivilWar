/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Buying function 
 * Can be executed locally
 */

params ["_group","_price"];

_score = DCW_SCORE;
_score = (_score - _price);
if (_score < 0) then{ 
	hint "Can't afford this";
	false;
}else{
	[_group,-_price] remoteExec ["DCW_fnc_updateScore",2];   
	true;
};