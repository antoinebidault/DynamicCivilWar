/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private["_pos","_radius","_nb","_roads","_car","_cars","_ied"];

if (count _this == 0)exitWith{false};
private _pos = _this select 0;
private _radius = _this select 1;
private _nb = _this select 2;

//!!DO NOT EDIT BELOW!!
iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];
iedJunk=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];


private _ieds = [];
private _roads = _pos nearRoads (_radius + 200);
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

iedAct={
	_iedObj=_this select 0;
	if(mineActive _iedObj)then{
		_iedBlast=selectRandom iedBlast;
		createVehicle[_iedBlast,(getPosATL _iedObj),[],0,"NONE"];
		createVehicle["Crater",(getPosATL _iedObj),[],0,"NONE"];

		{
			deleteVehicle _x
		}forEach nearestObjects[getPosATL _iedObj,iedJunk,4];

		deleteVehicle _iedObj;
	};
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

	
	if(round(random 2)==1)then{
		_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,"NONE"];
		_iedJunk setPosATL(getPosATL _iedJunk select 2+1);
		_iedJunk enableSimulationGlobal false;
		_iedJunk setVariable ["DCW_type","ied"];
		_iedJunk setVariable ["DCW_isIntel",true];
		[_iedJunk,"ColorYellow"] call fnc_addMarker;

		/*IED task*/
		[_iedJunk,_ied] spawn{
			waitUntil{sleep 5;!alive (_this select 1)||!(mineActive (_this select 1))};
			sleep 2;
         	(_this select 0) call fnc_success;
		 };
		 
		_ieds pushBack _iedJunk;
	};

	_trig = createTrigger["EmptyDetector",getPosATL _ied];
	_trig setTriggerArea[3,3,0,FALSE,3];
	_trig setTriggerActivation["ANY","PRESENT",false];
	_trig setTriggerTimeout[1,1,1,true];
	
	if (isMultiplayer) then{
		_trig setTriggerStatements[
		"{vehicle _x in thisList && speed vehicle _x>4}count playableUnits>0",
		"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
		"deleteVehicle thisTrigger"];
	}else{
		_trig setTriggerStatements[
		"{vehicle _x in thisList && isPlayer vehicle _x && speed vehicle _x>4}count allUnits>0",
		"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
		"deleteVehicle thisTrigger"];
	};


	if (count _roads == 0)exitWith {};
	_jnkR=selectRandom _roads;
	_junk=createVehicle[_junk,getPosATL _jnkR,[],8,"NONE"];
	_junk setPosATL(getPosATL _junk select 2+1);
	_junk enableSimulationGlobal false;
	_ieds pushBack _junk;

} forEach _roadSelects;

{CIV_SIDE revealMine _x;ENEMY_SIDE revealMine _x;}forEach allMines;

_ieds;