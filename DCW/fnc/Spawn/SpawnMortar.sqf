/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_pos","_radius","_nb","_unit","_unitName","_enemy","_mortar"];

_pos = _this select 0;
_radius = _this select 1;
_nb = _this select 2;

private _units = [];

if (_nb == 0)exitWith{_units;};

_mkrToAvoid = createMarker ["mkrToAvoid",getPos player];
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerSize [150,150];
_tempList = MARKER_WHITE_LIST + [_mkrToAvoid];

_posToSpawn = [_pos, 350 max (1.5*_radius) , 500 max (2*_radius), 3, 0, 20, 0,_tempList] call BIS_fnc_findSafePos;

for "_j" from 1 to _nb do {
    _mortar = ENEMY_MORTAR_CLASS createVehicle _posToSpawn ; 

    _mortar setVariable["DCW_IsIntel",true];
    _mortar setVariable["DCW_Type","mortar"];

    _mortar addEventHandler["Killed",{ 
        params["_mortar","_killer"];
        if (group(_killer) == group player) then {
            hint "Mortar destroyed";
            _mortar call fnc_success; 
         }else{
            _mortar call fnc_failed;
        }; 
    }];


    _mortar setDir ([_posToSpawn,_pos] call BIS_fnc_dirTo);
    [_mortar,"ColorPink"] call fnc_addMarker;
    _nbGuards = 2 + round(random 1);
    _grp = createGroup ENEMY_SIDE;

    //Déclenchement du bombardement
    [_pos,_radius,_mortar] spawn {
        params["_pos","_radius","_mortar"];
        waitUntil{sleep 15; getPosATL player distance _pos < _radius };
        [_mortar,player,_pos,_radius] call fnc_mortarbombing;
    };
                    
    for "_i" from 1 to _nbGuards do {
        _enemy = [_grp,_posToSpawn] call fnc_spawnEnemy;
        _enemy setDir ([_posToSpawn,_pos] call BIS_fnc_dirTo);

        _units pushBack _enemy;
        if (_i == 1)then{
            _enemy disableAI "AUTOCOMBAT"; 
            _enemy moveInGunner _mortar;
        }else{
            if (_i == 2)then{
                _enemy setUnitPos "MIDDLE";
                _enemy addWeapon "Binocular";
                _enemy selectWeapon "Binocular";
            }else{
                _enemy setUnitPos "MIDDLE";
            };
        };
    };
};

_units;


