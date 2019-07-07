/*
  Author: 
    Bidass

  Description:
    Spawn a hostage task with a civilian tied up and terrorists arround him

  Parameters:
    0: ARRAY - position
    1: NUMBER - Radius
    2: NUMNER - Number of units
    3: ARRAY - Building's list

  Returns:
    ARRAY - unit's list spawned 
*/

private ["_pos","_radius","_nb","_unit","_building","_buildings","_unitName","_posToSpawn","_posBuildings","_enemy","_hostage"];

_pos = _this select 0;
_radius = _this select 1;
_nb = _this select 2;
_buildings =_this select 3;

private _units = [];
private _boxeClasses = ["Box_Syndicate_Wps_F","Box_Syndicate_Ammo_F","Box_Syndicate_WpsLaunch_F"];

if (_nb == 0)exitWith{_units;};


for "_j" from 1 to _nb do {
    
    if (count _buildings == 0)exitWith {_units;};
    _building = _buildings call BIS_fnc_selectRandom;
    _buildings = _buildings - [_building];
    _posBuildings = [_building] call BIS_fnc_buildingPositions;
    if (count _posBuildings == 0) exitWith{_units;};
    _posToSpawn = _posBuildings call BIS_fnc_selectRandom;
    _posBuildings = _posBuildings -[_posToSpawn];
    _grp = createGroup SIDE_CIV;
    _unitName = CIV_LIST_UNITS call BIS_fnc_selectRandom;
    _hostage = _grp  createUnit [_unitName, _posToSpawn,[],0,"CAN_COLLIDE"];
    _hostage setCaptive true;
	removeAllWeapons _hostage;
	removeAllAssignedItems _hostage;
	removeBackpack _hostage;
	removeVest _hostage;

	//_hostage playMove "Acts_ExecutionVictim_Loop";
    _anim = selectRandom ["Acts_AidlPsitMstpSsurWnonDnon01","Acts_AidlPsitMstpSsurWnonDnon02","Acts_AidlPsitMstpSsurWnonDnon03","Acts_AidlPsitMstpSsurWnonDnon04","Acts_AidlPsitMstpSsurWnonDnon05"];
    _hostage switchMove _anim;
	_hostage disableAI "autoTarget";
	_hostage setBehaviour "Careless";
    _hostage setDamage .7;
    _hostage setHit ["legs", 1]; 
    _largeSplash = createSimpleObject ["a3\characters_f\blood_splash.p3d", getPos _hostage]; 
    _largeSplash setDir random 360;
	_hostage allowFleeing 0;
	_hostage disableAI "Move";


    _hostage setDir (random 359);
    [_hostage,"ColorBlue"] call DCW_fnc_addMarker;
    _hostage setVariable["DCW_Type","hostage"];

    _hostage addMPEventHandler ["MPKilled", {
        [_this select 0, (_this select 0) getVariable["DCW_Act",0]]call BIS_fnc_holdActionRemove;
        [_this select 1,"HQ, we have an hostage down here...", true] spawn DCW_fnc_talk;
        (_this select 0)  remoteExec ["DCW_fnc_failed", 2, false];
    }];

    [ _hostage,"Secure Prisoner","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa","_this distance _target < 2","true",{
       [(_this select 1), "medic"] remoteExec ["playActionNow"];
    },{},{
        _hostage = _this select 0;
        if (!alive(_hostage)) exitWith{hint "He is dead";};
        _hostage remoteExec ["removeAllActions"];
        _hostage stop false;
        //_hostage playMove "Acts_ExecutionVictim_Unbow";
        [_hostage,"Acts_AidlPsitMstpSsurWnonDnon_out"] remoteExec ["switchMove"] ;
        _hostage setUnitPos "UP";	
        _hostage setBehaviour "CARELESS";
        _hostage enableAI "Move";
        _hostage allowFleeing 1;
        _hostage setCaptive false;
        _hostage setVariable["DCW_IsIntel",true];
        _pos = [getPosASL _hostage, 1000, 1200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        _hostage move _pos;
        
        [_hostage,"Thank you !", false] call DCW_fnc_talk;
        [(_this select 1),"HQ, this is bravo team, we've liberated a hostage held down in a compound.", true] remoteExec ["DCW_fnc_talk",0,false];

        //Task success
        _hostage remoteExec ["DCW_fnc_success",2, false];
        
    },{},[],4,nil,true,false] remoteExecCall ["BIS_fnc_holdActionAdd",0];

    _units pushBack _hostage;

    _nbGuards = 1 + round(random 2);
    _grp = createGroup SIDE_ENEMY;
    for "_i" from 1 to _nbGuards do {
        if (count _posBuildings == 0) exitWith{_units};
         _posToSpawn = _posBuildings call BIS_fnc_selectRandom;
         _posBuildings = _posBuildings -[_posToSpawn];
        _enemy = [_grp,_posToSpawn,false] call DCW_fnc_spawnEnemy;
        _units pushBack _enemy;
    };

};

_units;


