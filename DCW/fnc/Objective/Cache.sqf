/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_unit","_building","_buildings","_unitName","_posToSpawn","_posBuildings","_enemy"];

private _pos = _this select 0;
private _radius = _this select 1;
private _nb = _this select 2;

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
    _unitName = _boxeClasses call BIS_fnc_selectRandom;
    _unit =  createVehicle [_unitName,_posToSpawn,[],0,"NONE"]; 
    _unit setDir (random 359);
    [_unit,"ColorBrown"] call fnc_addMarker;
    _units pushBack _unit;
    _unit setVariable["DCW_Type","cache"];
    _unit setVariable["DCW_IsIntel",true];

    
    _unit addEventHandler["Killed",{ 
        params["_cache","_killer"];
        if (group(_killer) == group player) then {
            _cache call fnc_success; 
         }else{
            _cache call fnc_failed;
        }; 
    }];

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