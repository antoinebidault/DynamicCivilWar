/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

CRASHSITES  = [];

if (NUMBER_CRASHSITES == 0)exitWith{CRASHSITES};

_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
private _tempMarkers = MARKER_WHITE_LIST;

while {count CRASHSITES < NUMBER_CRASHSITES} do{

     _spawnPos = [_worldCenter, 0, (_worldSize/2)*.8, 5, 0, .3, 0, _tempMarkers] call BIS_fnc_FindSafePos;
    
    // Temp marker with previously spawned tank
    _tmpmarker = createMarker [format["ch-bl-%1",random 10000], _spawnPos];
    _tmpmarker setMarkerSize [1000,1000];
    _tmpmarker setMarkerShape "ELLIPSE";
    _tmpmarker setMarkerAlpha 0;
    _tempMarkers = _tempMarkers + [_tmpmarker];
    
    _className = (FRIENDLY_CHOPPER_CLASS call bis_fnc_selectrandom);
    _chopper = createVehicle [_className, _spawnPos, [], round random 360, "NONE"];
    _elementToDestroy = "IEDLandBig_F" createVehicle _spawnPos;
    _elementToDestroy setPos (getPos _chopper);
    _crater = createVehicle ["Crater", _spawnPos, [], round random 360, "NONE"];
    _chopper setDamage 1;
    _chopper setVehicleLock "LOCKED";

    private _marker = createMarker [format["tk-%1",random 10000],getPos _chopper];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "b_air";
    _elementToDestroy setVariable["marker",_marker];

    _elementToDestroy setVariable ["DCW_Type","wreck"];
    _elementToDestroy setVariable ["DCW_IsIntel",true];
    
    _taskData = [_elementToDestroy, LEADER_PLAYERS,true] call fnc_createtask;
    _elementToDestroy setVariable["DCW_Task",_taskData select 0];

    _elementToDestroy addMPEventHandler ["MPKilled",{
         params["_unit","_killer"];
         if (isPlayer _killer || _killer in units GROUP_PLAYERS) then {
            //Task success
            _elementToDestroy call fnc_success;
         };
    }];
    // Add to markers

    _enemyArea = createMarker [format["ch-bl-%1",random 10000], getPos _chopper];
    _enemyArea setMarkerSize [144,144];
    _enemyArea setMarkerShape "ELLIPSE";
    _enemyArea setMarkerAlpha 0;
    MARKERS pushback [_enemyArea,getPos _elementToDestroy,false,false,40,[],[0,0,4,0,0,0,0,0,0,0],[], 0,true,false,[]];
    CRASHSITES pushback _elementToDestroy;
};

CRASHSITES;