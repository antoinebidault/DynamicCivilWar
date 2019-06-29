

private ["_unit","_injured","_pos","_dir","_addAction"];
params ["_unit","_injured"];

DCW_fnc_dropAction = {
	_unit = _this select 0;
	_injured = _this select 3;

	detach _unit;
	detach _injured;
	[_unit, "AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon"] remoteExec["switchMove"];
	[_injured , "AinjPpneMrunSnonWnonDb_release"] remoteExec["switchMove"];

	_injured setVariable ["DCW_unit_dragged", false, true];
	_injured selectWeapon (primaryWeapon _injured);

	waitUntil {animationState _injured != "AinjPpneMrunSnonWnonDb_release"};
	[_injured,"unconsciousrevivedefault"] remoteExec ["switchMove"] ;
	_injured call DCW_fnc_addActionHeal;
};


if (isNull _injured) exitWith {};
if (!alive _injured) exitWith {};
if (!(_injured getVariable ["DCW_unit_injured", false])) exitWith {};

_addAction = false;
_dropActionId = 0;
_injured setVariable ["DCW_unit_dragged", true, true];

while {_injured getVariable ["DCW_unit_dragged", false]} do {
	if (!_addAction) then {

		[_unit, "grabDrag"] remoteExec ["playActionNow"];
		_injured attachto [_unit,[0.1, 1.01, 0]];
		_injured setDir 180;
		[_injured,"AinjPpneMrunSnonWnonDb_grab"] remoteExec ["switchMove"] ;
		uiSleep 2;
		[_injured,"AinjPpneMrunSnonWnonDb_still"] remoteExec ["switchMove"] ;

		[_injured,"DCW_fnc_carry"] call DCW_fnc_RemoveAction; 
		_injured call DCW_fnc_removeActionHeal;
		_dropActionId = _unit addAction ["drop", DCW_fnc_dropAction,_injured, 0, false, true];

		uiSleep 1;
		_addAction = true;
	};

	if (speed _unit != 0) then {
		[_injured,"AinjPpneMrunSnonWnonDb"] remoteExec ["switchMove"];
		sleep 1;
	} else {
		[_injured,"AinjPpneMrunSnonWnonDb_still"] remoteExec ["switchMove"];
	};
	

	if (vehicle _unit != _unit) then {
		_unit action ["eject", vehicle _unit];
		[cursorTarget, _unit, _unconscious, _injured] call DCW_fnc_dropAction;
	};

	uiSleep 0.001;
};

_unit removeAction _dropActionId;
if (alive _injured) then {
	_injured call DCW_fnc_addActionHeal;
	[_injured,"DCW_fnc_carry"] call DCW_fnc_AddAction; 
};

