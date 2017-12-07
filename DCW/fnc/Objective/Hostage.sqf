/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_pos","_radius","_nb","_unit","_building","_buildings","_unitName","_posToSpawn","_posBuildings","_enemy","_hostage"];

_pos = _this select 0;
_radius = _this select 1;
_nb = _this select 2;

private _units = [];
private _boxeClasses = ["Box_Syndicate_Wps_F","Box_Syndicate_Ammo_F","Box_Syndicate_WpsLaunch_F"];

if (_nb == 0)exitWith{_units;};


private	_buildings = [_pos, _radius] call fnc_findBuildings;


for "_j" from 1 to _nb do {
    _building = _buildings call BIS_fnc_selectRandom;
    _buildings = _buildings - [_building];
    _posBuildings = [_building] call BIS_fnc_buildingPositions;
    if (count _posBuildings == 0) exitWith{_units;};
    _posToSpawn = _posBuildings call BIS_fnc_selectRandom;
    _posBuildings = _posBuildings -[_posToSpawn];
    _grp = createGroup CIV_SIDE;
    _unitName = CIV_LIST_UNITS call BIS_fnc_selectRandom;
    _hostage = _grp  createUnit [_unitName, _posToSpawn,[],0,"NONE"];
    _hostage setCaptive true;
	removeAllWeapons _hostage;
	removeAllAssignedItems _hostage;
	removeBackpack _hostage;
	removeVest _hostage;

	_hostage playMove "Acts_ExecutionVictim_Loop";
	_hostage disableAI "autoTarget";
	_hostage setBehaviour "Careless";
    _hostage setDamage .7;
    _hostage setHit ["legs", 1]; 
    _largeSplash = createSimpleObject ["a3\characters_f\blood_splash.p3d", getPos _hostage]; 
    _largeSplash setDir random 360;
	_hostage allowFleeing 0;
	_hostage disableAI "Move";

    _hostage setDir (random 359);
    [_hostage,"ColorBlue"] call fnc_addMarker;
    _hostage setVariable["DCW_Type","hostage"];

    _hostage addEventHandler ["Killed",{
        [_this select 0, (_this select 0) getVariable["DCW_Act",0]]call BIS_fnc_holdActionRemove;
        [player,"Hostage down... Mission failed"] spawn fnc_talk;
        (_this select 0) spawn fnc_failed;
    }];

    _actionId = [ _hostage,"Secure Prisoner","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa","_this distance _target < 2","true",{
        (_this select 1) playActionNow "medic";
    },{},{
        _hostage = _this select 0;
        if (!alive(_hostage)) exitWith{hint "He is dead";};
        removeallactions _hostage;
        _hostage stop false;
        _hostage playMove "Acts_ExecutionVictim_Unbow";
        _hostage setUnitPos "UP";	
        _hostage setBehaviour "CARELESS";
        _hostage enableAI "Move";
        _hostage allowFleeing 1;
        _hostage setCaptive false;
        _hostage setVariable["DCW_IsIntel",true];
        _pos = [getPosASL _hostage, 1000, 1200, 3, 0, 20, 0] call BIS_fnc_FindSafePos;
        _hostage move _pos;
        
        [_hostage,"Thank you !"] call fnc_talk;
        [(_this select 1),"HQ, this is bravo team, we've liberated a hostage held down in a compound."] call fnc_talk;

        //Task success
        _hostage call fnc_success;
        
    },{},[],4,nil,true,false] call BIS_fnc_holdActionAdd;
    _hostage setVariable["DCW_Act",_actionId];

    _units pushBack _hostage;

    _nbGuards = 1 + round(random 2);
    _grp = createGroup ENEMY_SIDE;
    for "_i" from 1 to _nbGuards do {
        if (count _posBuildings == 0) exitWith{_units};
         _posToSpawn = _posBuildings call BIS_fnc_selectRandom;
         _posBuildings = _posBuildings -[_posToSpawn];
        _unitName = ENEMY_LIST_UNITS call BIS_fnc_selectRandom;
        _enemy = _grp createUnit [_unitName, _posToSpawn , [], ENEMY_SKILLS, "NONE"];
        _enemy setDir random 360;

        [_enemy,"ColorRed"] call fnc_addMarker;

        [_enemy] call fnc_addTorch;

        //Handle killed unit
        [_enemy] call fnc_handlekill;
        _units pushBack _enemy;
    };

};

_units;


