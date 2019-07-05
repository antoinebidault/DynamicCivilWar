/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

private["_pos","_radius","_nb","_roads","_car","_cars","_ied"];

if (count _this == 0)exitWith{false};
private _pos = _this select 0;
private _radius = _this select 1;
private _nb = _this select 2;

iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
iedJunk=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];
iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];

private _localIeds = [];
private _ieds = [];
private _roads = _pos nearRoads (_radius + 300);
private _roadSelects = [];
private _i = _nb;
if (count _roads == 0) exitWith {_ieds};
while {_i > 0} do {
	if (_i > count _roads) exitWith{};
    _rnd = _roads call BIS_fnc_selectRandom;
    _roadSelects pushBack _rnd;
    _roads = _roads - [_rnd];
    _i = _i-1;
};


{
	_x;
	_ied=selectRandom iedList;
	_junk=selectRandom iedJunk;
	_ied = createMine[_ied,getPosATL _x,[],8];
	_ied setPosATL(getPosATL _ied select 2+1);
	_ied setDir(random 359);
	_ied allowDamage true;
	_ieds pushBack _ied;
	
	_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,"NONE"];
	_iedJunk setPosATL(getPosATL _iedJunk select 2+1);
	_iedJunk enableSimulationGlobal false;
	_iedJunk setVariable ["DCW_Type","ied"];
	_iedJunk setVariable ["DCW_IsIntel",true];
	_iedJunk allowDamage false;
	[_iedJunk,"ColorBlue"] call DCW_fnc_addMarker;

	_ieds pushBack _iedJunk;

	if (count _roads == 0)exitWith {};
	_jnkR=selectRandom _roads;
	_junk=createVehicle[_junk,getPosATL _jnkR,[],8,"NONE"];
	_junk setPosATL(getPosATL _junk select 2+1);
	_junk enableSimulationGlobal false;
	_ieds pushBack _junk;

	IEDS pushback [_ied,_iedJunk];

	SIDE_CIV revealMine _ied;
	SIDE_ENEMY revealMine _iedJunk;

} forEach _roadSelects;

// Give the IEDS back
publicVariable "IEDS";

_ieds;
