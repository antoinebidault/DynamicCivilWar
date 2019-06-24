

private ["_unit","_injured","_pos","_dir","_addAction"];
params ["_unit","_injured"];

fnc_dropAction = {
	_unit = _this select 0;
	_injured = _this select 3;

	detach _unit;
	detach _injured;
	_unit switchMove "AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";
	_injured switchMove "AinjPpneMrunSnonWnonDb_release";
	_injured setVariable ["unit_dragged", false, true];
	
	//lie on back

};


if (isNull _injured) exitWith {};
if (!alive _injured) exitWith {};
if (!(_injured getVariable ["unit_injured", false])) exitWith {};


_addAction = false;
_dropActionId = 0;
_injured setVariable ["unit_dragged", true, true];

while {_injured getVariable ["unit_dragged", false]} do {
	if (!_addAction) then {

		_unit playActionNow "grabDrag";
		_injured attachto [_unit,[0.1, 1.01, 0]];
		_injured setDir 180;
		_injured switchMove "AinjPpneMrunSnonWnonDb_grab";
		uiSleep 2;
		_injured switchMove "AinjPpneMrunSnonWnonDb_still";

		//rotate wounded units so that it is facing the correct direction
		_injured remoteExec ["RemoveAllActions",0];
		_dropActionId = _unit addAction ["drop", fnc_dropAction,_injured, 0, false, true];

		uiSleep 1;
		_addAction = true;
	};

	if (speed _unit != 0) then {
		_injured switchMove "AinjPpneMrunSnonWnonDb";
		sleep 1;
	} else {
		_injured switchMove "AinjPpneMrunSnonWnonDb_still";
	};
	

	if (vehicle _unit != _unit) then {
		_unit action ["eject", vehicle _unit];
		[cursorTarget, _unit, _unconscious, _injured] call fnc_dropAction;
	};

	uiSleep 0.001;
};

_unit removeAction _dropActionId;
if (alive _injured) then {
	_injured remoteExec ["fnc_addActionHeal"];
};
_injured remoteExec ["fnc_addActionCarry"]; 
