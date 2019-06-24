/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
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
	_target setVariable["unit_injured",false, true];
	_target setVariable["unit_onback",false];
	[_target, "AinjPpneMstpSnonWrflDb_release"] remoteExec ["switchMove", 0];
	_target setPos _pos;
	sleep 3;
	_target moveInCargo _helo;
};
