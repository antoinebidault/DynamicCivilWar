/*
  Author: 
    Bidass

  Description:
    

  Parameters:
    0: OBJECT - 

  Returns:
    BOOL - true 
*/


params [
	"_unit",
	"_target",
	"_helo"
];


_unit playAction "released";
private _pos = getPosATL _target;

detach _unit;
detach _target;

if (alive _target) then {
	_target setVariable["DCW_unit_injured",false, true];
	_target setVariable["unit_onback",false];
	[_target, "AinjPpneMstpSnonWrflDb_release"] remoteExec ["switchMove", 0];
	_target setPos _pos;
	sleep 3;
	_target moveInCargo _helo;
};
