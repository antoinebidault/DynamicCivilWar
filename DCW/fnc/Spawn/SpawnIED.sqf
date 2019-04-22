/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private["_pos","_radius","_nb","_roads","_car","_cars","_ied"];

if (count _this == 0)exitWith{false};
private _pos = _this select 0;
private _radius = _this select 1;
private _nb = _this select 2;

iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];
iedJunk=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];

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

//hint format["%1",count _roadSelects];

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
	[_iedJunk,"ColorBlue"] call fnc_addMarker;

	_ieds pushBack _iedJunk;

	if (count _roads == 0)exitWith {};
	_jnkR=selectRandom _roads;
	_junk=createVehicle[_junk,getPosATL _jnkR,[],8,"NONE"];
	_junk setPosATL(getPosATL _junk select 2+1);
	_junk enableSimulationGlobal false;
	_ieds pushBack _junk;
	_localIeds pushBack [_ied,_iedJunk];

} forEach _roadSelects;

{SIDE_CIV revealMine (_x select 0);SIDE_ENEMY revealMine (_x select 0);}forEach _localIeds;


//Loop to check status
[[_localIeds],{
	params["_localIeds"];

	iedAct={
		_iedObj=_this;
		if(mineActive _iedObj)then{
			_iedBlast=selectRandom iedBlast;
			createVehicle[_iedBlast,(getPosATL _iedObj),[],0,"NONE"];
			createVehicle["Crater",(getPosATL _iedObj),[],0,"NONE"];

			{
				hideObject _x
			}forEach nearestObjects[getPosATL _iedObj,iedJunk,4];

			deleteVehicle _iedObj;
		};
	};

	while {count _localIeds > 0}do
	{
		{
			_mine = _x select 0;
			if (!(mineActive _mine) || !(alive _mine))then{
				_junk = _x select 1;
				//It's in cache, that's okay !
				if (player distance _junk < 250) then{
					//The mine is defused by the player
					_junk remoteExec ["fnc_success",2,false];
				};
				
				//Anyway;
				_localIeds - [_x];
			}else{
				if (_mine distance player < 3  && (speed player > 4 || (stance player) != "PRONE")) then{
					_mine call iedAct;
				};
			};
			sleep .3;
		}
		foreach _localIeds;
		sleep .2;
	}
}] remoteExec ["spawn", GROUP_PLAYERS, true];

_ieds;