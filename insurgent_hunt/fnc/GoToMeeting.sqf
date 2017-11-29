private ["_friend"];
params["_unit","_meetingPoint"];

if (isNil '_meetingPoint') then{_meetingPoint = ([getPosASL _unit,false] call fnc_findnearestmarker) select 8; };
if (!alive _unit) exitWith{false;};
if (_unit getVariable["civ_affraid",false]) exitWith{false;};

_anims = [
		"STAND",
		"STAND_IA",
		"SIT_LOW",
		"WATCH",
		"WATCH1",
		"WATCH2"
	];
//_group allowFleeing 0;
//{_unit disableCollisionWith _x;}foreach _chairs;
//{_unit disableCollisionWith _x;}foreach _objs;

_newPos = [_meetingPoint, .2, 1.5, 0, 0, 10, 0] call BIS_fnc_findSafePos;
_unit doMove _newPos;
_timer = time;

sleep 1;

waitUntil {unitReady _unit || _unit distance _newPos < 2.3 || time > _timer + 500};
if (time > _timer + 149) exitWith{false;}; 

sleep 3;

//look for a chair around
/*
_chairFound = [];
{
	_obj = nearestObject [_unit, _x select 0];
	if (([_obj,_unit] call BIS_fnc_distance2D) < 1.5) exitWith
	{
		_chairFound = _x;
	};
}
forEach chairs;*/

if (side _unit == CIV_SIDE)then{
	_animPossible = ["Acts_CivilListening_1","Acts_CivilListening_2","acts_StandingSpeakingUnarmed"];
	/*if (count _chairFound > 0) then {
		[_unit, "SIT", "NONE"] call BIS_fnc_ambientAnim;
		sleep  (10 + random 350);
		_unit spawn BIS_fnc_ambientAnim__terminate;
	}else{*/
		_unit doWatch _newPos;
		_unit setDir ([_unit,_newPos] call BIS_fnc_dirTo);
		if (random 1 > .5)then{
			private _anim = (_animPossible call BIS_fnc_selectRandom);
			_unit switchMove _anim;
			friends = nearestObjects [position _unit,["Man"],5];
			if ({side _x == side _unit} count friends > 0) then {
				_friend = (friends call BIS_fnc_selectRandom);
				_unit doWatch _friend;
			};
			sleep  (10 + random 50);
			_unit switchMove "";
		} else {
			_unit stop true;
			sleep 3;
			_unit action ["sitdown",_unit];
			sleep  (10 + random 50);
			_unit stop false;
		};
	//};
}else{
	
	friends = nearestObjects [position _unit,["Man"],3];

	if ({side _x == side _unit} count friends > 0) then {
		_friend = (friends call BIS_fnc_selectRandom);
		_unit setDir ([_unit,_friend] call BIS_fnc_dirTo);
		_friend setDir ([_friend,_unit] call BIS_fnc_dirTo);
		_unit doWatch _friend;
		_unit stop true;
		_unit playAction "salute";
		sleep 2;	
		_unit playAction "saluteOff";
		sleep 2;	
		_unit stop false;	
	};

	_unit doWatch _newPos;
	_unit setDir ([_unit,_newPos] call BIS_fnc_dirTo);
	if (random 10 > 5)then{
		[_unit,_anims call BIS_fnc_selectRandom,"FULL"] call BIS_fnc_ambientAnimCombat;
		if ({side _x == side _unit} count friends > 0) then {
			_unit doWatch _friend;
		};
		sleep  (10 + random 50);
		_unit spawn BIS_fnc_ambientAnim__terminate;
	}else{
		_unit stop true;
		sleep 3;
		_unit action ["sitdown",_unit];
		sleep  (10 + random 50);
		_unit stop false;
	};

};
sleep 10 + random 50;
true;