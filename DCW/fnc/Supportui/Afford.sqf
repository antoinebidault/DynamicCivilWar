/*
  Author: 
    Bidass

  Description:
    Buying function

  Parameters:
    0: OBJECT - Group of players => The money is collected for the whole group
	1: NUMBER - The price

  Returns:
    BOOL - true if the buying is successful.
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