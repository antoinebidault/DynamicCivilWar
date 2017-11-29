private["_unit","_radius","_houses","_pos","_wp","_posBuilding","_gunner"];

_unit = _this select 0;
_gunner = _this select 1;
_radius = 100;
_pos = position _unit;
_unit setVariable ["civ_insurgent",true]; 

//Add a bonus wether the shooter is from the enemy side or not
private _bonus = if (side _gunner == ENEMY_SIDE)then{25}else{-25};
private _side = if (random 100 > (PERCENTAGE_FRIENDLY_INSURGENTS + _bonus)) then {ENEMY_SIDE}else{SIDE_CURRENT_PLAYER};


if (DEBUG)then{
	private _marker = _unit getVariable["marker",""];
	_marker setMarkerColor "ColorWhite";
};

_houses  = [getPosWorld _unit, _radius] call fnc_findbuildings; 

sleep 3;
_unit forceWalk false;
_unit setspeedmode "FULL";
_unit setbehaviour "CARELESS"; 
//_marker setMarkerColor "ColorRed";
if (count _houses > 0 ) then{
	_house = _houses select 0;
	_posBuilding = ([_house] call BIS_fnc_buildingPositions) call bis_fnc_selectrandom;
	if (_unit distance _posBuilding < 70) then{
		_unit doMove _posBuilding ;
		waitUntil {_unit distance _posBuilding < 2};
		[_unit,_side] call fnc_BadBuyLoadout;
	}else{
		[_unit,_side] call fnc_BadBuyLoadout;
	};
}else{
	[_unit,_side] call fnc_BadBuyLoadout;
};

//Move to a new position
sleep 3;
_dir = random 360;
 _newPos = [_pos ,40,50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
_unit doMove _newPos;
