_object = _this select 0;
_caller = _this select 1;
_action = _this select 2;
_snapToGround = _this select 3;

_objectPos = getPosATL (_object);
detach _object;

if (_snapToGround) then {
	[_object, false] remoteExec ["enableSimulation", 0];
	[_object, _objectPos] remoteExec ["setPosATL", 0];
	[_object, true] remoteExec ["enableSimulation", 0];
};

{
	[_object, _x] remoteExec ['enableCollisionWith', 0];
} forEach playableUnits;

[_caller,_caller getVariable["DCW_build_action",0]] remoteExec ["removeAction", 0];

[_object] remoteExec ["DCW_fnc_addActionObject", 0];

_object setVehiclePosition [_object, [], 0, 'CAN_COLLIDE'];

_caller setVariable ["DCW_buildItemGrabbed", false, true];
_object setVariable ["DCW_buildItemGrabbed", false, true];


if (!isNil (_object getVariable["DCW_initField",nil])) then {
	_object spawn (_object getVariable["DCW_initField",nil]);
};