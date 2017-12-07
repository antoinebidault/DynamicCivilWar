/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Stand by during a long period

SLEEP (200+(RANDOM 500)) + (_this select 0);

_nbTrucks = 2;
_roadRadius = 40;
_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];

[HQ,"There is an enemy convoy moving not far from your position. You can destroy them to earn some points."] call fnc_talk;


private _mkrToAvoid = createMarker ["mkrToAvoid",getPos player];
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerSize [500,500];
_tempList = MARKER_WHITE_LIST + [_mkrToAvoid];
_initPos = [_worldCenter, (_worldSize/2)*0.8, (_worldSize/2)*1.2, 5, 0, 20, 0, _tempList] call BIS_fnc_FindSafePos;

_road = [_initPos,_worldSize] call BIS_fnc_nearestRoad;
_roadPos = getPos _road;


_grp = createGroup ENEMY_SIDE;
_car = objNull;
CONVOY = [];
_escort = [];

if (isOnRoad(_roadPos) && _roadPos distance player > 300 )then{
    _roadConnectedTo = roadsConnectedTo _road;
    _connectedRoad = _roadConnectedTo select 0;
    _roadDirection = [_road, _connectedRoad] call BIS_fnc_DirTo;
    _car = [_roadPos, _roadDirection, ENEMY_CONVOY_CAR_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;

    _car addEventHandler["Killed",{
        [player,10] spawn fnc_updatescore;
    }];

    CONVOY pushback _car;
    CONVOY = CONVOY + (crew _car);
   
    _nbUnit = (count (fullCrew [_car,"cargo",true]));
    
    //Civilian team spawn.
    //If we killed them, it's over.
    for "_xc" from 1 to _nbUnit  do {
        _unit =[_grp,_initPos] call fnc_spawnEnemy;
        _unit moveInCargo _car;
        CONVOY pushback _unit;
    };

    //Trucks
    for "_xc" from 1 to _nbTrucks  do {
        _truck = [_car modelToWorld [0,-(_xc*20),0], _roadDirection, ENEMY_CONVOY_TRUCK_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;
        _nbUnit = (count (fullCrew [_truck,"cargo",true]));
        for "_yc" from 1 to _nbUnit  do {
            _unit =[_grp,_initPos] call fnc_spawnEnemy;
            _unit moveInCargo _truck;
            CONVOY pushback _unit;
        };
         CONVOY pushback _truck;
         CONVOY = CONVOY + (crew _truck);
         _truck addEventHandler["Killed",{
             [player,40] spawn fnc_updatescore;
         }];
    };

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "NORMAL";
    _grp setFormation "COLUMN";

}else{
 hint "Error ! Not enough road to spawn objective... Restarting...";
 sleep 10;
 [] call fnc_SpawnMainObjective;
};


_wpt = createMarker ["initMarker",[0,0,0]];
_wpt setMarkerShape "ICON";
_wpt setMarkerColor "ColorRed";
_wpt setMarkerType "hd_pickup";
_wpt setMarkerText "Convoy destination";

/*
private _mkrToAvoid = createMarker ["mkrToAvoid",getPos player];
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerSize [500,500];
_tempList = MARKER_WHITE_LIST + [_mkrToAvoid];
*/

//FIRST STEP => Moving to a random compound
_nextPos = getMarkerPos (([getPos player] call fnc_findNearestMarker) select 0);
_nextPos = getPosASL([_nextPos,1000] call BIS_fnc_nearestRoad);
(leader _grp) move _nextPos;
NEXT_WAYPOINT = _nextPos;
_wpt setMarkerPos _nextPos;
waitUntil {sleep 5; !alive(leader _grp) || (leader _grp) distance _nextPos < 10 };
sleep 100 + random 400;

//SECOND STEP Move back to the position
_nextPos = _initPos;
(leader _grp)  move _nextPos;
NEXT_WAYPOINT = _nextPos;
waitUntil {sleep 5; !alive(leader _grp) || (leader _grp)  distance _nextPos < 10 };

if (!alive(leader _grp))exitWith {
    [HQ,"You successfully ambushed the convoy ! Well done !"] call fnc_talk;
    [600] spawn fnc_SpawnMainObjective;
};


sleep 100;

//Unspawn unit
{deleteVehicle _x; CONVOY = CONVOY - [_x];} forEach CONVOY;

[HQ,"You missed the convoy ! Out !"] call fnc_talk;
[0] spawn fnc_SpawnMainObjective;
false;