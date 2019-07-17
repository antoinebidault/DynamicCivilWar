_object = _this select 0;
_caller = _this select 1;
_pos = _this select 2;


_playerArr = [_caller];
_allPlayers = playableUnits - _playerArr;
_closestPlayerDist = 9999;

{
	_playerDistance = _object distance2d _x;
	if ((_playerDistance < _closestPlayerDist)) then {
	  _closestPlayerDist = _playerDistance;
	};
} forEach _allPlayers;

if (!(player getVariable ["DCW_buildItemGrabbed",false])) then {

	if (_closestPlayerDist > 4) then {

			if (isNil "_pos") then {
				[_object, _caller] call BIS_fnc_attachToRelative ;
			} else {
				_object attachTo [_caller, _pos, "Pelvis"];
				_playerDir = _caller getRelDir _object; 
				_dir = _this select 3;
				_holdDir = _playerDir + _dir;
				_object setdir _holdDir;
			};
		
			{
				[_object, _x] remoteExec ["disableCollisionWith", 0];
			} forEach playableUnits;

			[_object] remoteExec ["removeAllActions", 0];

			_actionID = _caller addAction [
				"<t color='#cd8700'>Drop object</t>",
				'[_this select 3, _this select 1, _this select 2,true] call DCW_fnc_placeObject;',
				_object
			];

			_caller setVariable["DCW_build_action",_actionID ,true];
			_caller setVariable ["DCW_buildItemGrabbed", true, true];
			_object setVariable ["DCW_buildItemGrabbed", true, true];

	} else {
		hintSilent "Other players too close";
	};
} else {
	hintSilent "You're already carrying an object";	
};