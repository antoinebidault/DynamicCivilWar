/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

TANKS  = [];

if (NUMBER_TANKS == 0)exitWith{TANKS};

_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
private _tempMarkers = MARKER_WHITE_LIST;
while {count TANKS < NUMBER_TANKS} do{
    

     _spawnPos = [_worldCenter, 0, (_worldSize/2), 5, 0, .3, 0, _tempMarkers] call BIS_fnc_findSafePos;
    
    // Temp marker with previously spawned tank
    _tmpmarker = createMarker [format["tk-bl-%1",random 10000], _spawnPos];
    _tmpmarker setMarkerSize [1000,1000];
    _tmpmarker setMarkerShape "ELLIPSE";
    _tmpmarker setMarkerAlpha 0;
    _tempMarkers = _tempMarkers + [_tmpmarker];

    _className = (ENEMY_LIST_TANKS call bis_fnc_selectrandom);
    _tank = [[_spawnPos select 0, _spawnPos select 1, 0], 180, _className, SIDE_ENEMY] call BIS_fnc_spawnVehicle select 0;
    _tank enableDynamicSimulation true;
    
    _tank setPilotLight true;
    _tank setCollisionLight true;
    group _tank setBehaviour "SAFE";
    driver _tank setBehaviour "SAFE";

    if (DEBUG) then {
        private _marker = createMarker [format["tk-%1",random 10000],_spawnPos];
        _marker setMarkerShape "ICON";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerType "o_armor";
        _tank setVariable["marker",_marker];
    };

    _tank setVariable ["DCW_Type","tank"];
    _tank setVariable ["DCW_IsIntel",true];

    _tank addMPEventHandler ["MPKilled",{
         params["_tank","_killer"];
         if (isPlayer _killer || _killer in units GROUP_PLAYERS) then {
            //Task success
            _tank remoteExec ["DCW_fnc_success",2,false];
         };
    }];
    
    TANKS pushback _tank;
    
};

TANKS;