/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

_nbTrucks = 2;
_roadRadius = 40;
_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];

hint "Convoy init";
_initPos = [_worldCenter, (_worldSize/2)*0.8, (_worldSize/2)*1.2, 5, 0, 20, 0, MARKER_WHITE_LIST] call BIS_fnc_findSafePos;

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
    _car = [_roadPos, _roadDirection, ENEMY_COMMANDER_CAR_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;
    CONVOY pushback _car;
    CONVOY = CONVOY + (crew _car);
   
    _nbUnit = (count (fullCrew [_car,"cargo",true]));
    ENEMY_COMMANDER = _grp createUnit [ENEMY_COMMANDER_CLASS, _initPos,[],ENEMY_SKILLS,"NONE"];
    removeAllWeapons ENEMY_COMMANDER;
    ENEMY_COMMANDER moveInCargo _car;
    _marker = createMarker ["commanderMarker",getPos ENEMY_COMMANDER];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "o_motor_inf";
    ENEMY_COMMANDER setVariable["marker",_marker];
    UNITS_SPAWNED pushback ENEMY_COMMANDER;
    CONVOY pushback ENEMY_COMMANDER;
    _escort pushBack ENEMY_COMMANDER;

    ENEMY_COMMANDER addEventHandler ["Killed",{
        params["_unit","_killer"];

        if (group _killer == group player)then{
            player globalChat "HQ ! This is charlie team, the enemy commander is KIA ! Out.";
            sleep 4;
            HQ globalChat "Copy that ! Good job Charlie";
            []spawn{
                sleep 10;
                ["END1",true,2] call BIS_fnc_endMission;
            };
        }else{
            { CONVOY = CONVOY - [_x]; deleteMarker (_x getVariable["marker",""]);deleteVehicle _x;} forEach CONVOY;
            [] call fnc_SpawnMainObjective;
        };
    }];

    //Civilian team spawn.
    //If we killed them, it's over.
    for "_xc" from 1 to (_nbUnit-1)  do {
        _unit = _grp createUnit [CIV_LIST_UNITS call BIS_fnc_selectRandom, _initPos,[],ENEMY_SKILLS,"NONE"];
        _unit moveInCargo _car;
        _unit addEventHandler ["Killed",{
            params["_unit","_killer"];
            if (group _killer == group player)then{
               []spawn{
                player globalChat "Shit ! We killed his civilian escort. The operation is compromised.";
                sleep 10;
                ["epicFail",false,2] call BIS_fnc_endMission;
               };
            };
            
        }];
        CONVOY pushback _unit;
        _escort pushback _unit;
    };

    //Trucks
    for "_xc" from 1 to _nbTrucks  do {
        _truck = [_car modelToWorld [0,-(_xc*20),0], _roadDirection, ENEMY_COMMANDER_TRUCK_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;
        _nbUnit = (count (fullCrew [_truck,"cargo",true]));
        for "_yc" from 1 to _nbUnit  do {
            _unit =[_grp,_initPos] call fnc_spawnEnemy;
            _unit moveInCargo _truck;
            CONVOY pushback _unit;
        };
         CONVOY pushback _truck;
         CONVOY = CONVOY + (crew _truck);
    };

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "NORMAL";
    _grp setFormation "COLUMN";

}else{
 hint "Error ! Not enough road to spawn objective";
 sleep 10;
 [] call fnc_SpawnMainObjective;
};

_wpt = createMarker ["initMarker",getPos ENEMY_COMMANDER];
_wpt setMarkerShape "ICON";
_wpt setMarkerColor "ColorRed";
_wpt setMarkerType "hd_pickup";

private _mkrToAvoid = createMarker ["mkrToAvoid",getPos player];
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerSize [500,500];
_tempList = MARKER_WHITE_LIST + [_mkrToAvoid];


//FIRST STEP => Moving to a random compound
_nextPos = [_worldCenter, 0, (_worldSize/2)*0.8, 5, 0, 20, 0, _tempList] call BIS_fnc_findSafePos;
_nextPos = getMarkerPos (([_nextPos] call fnc_findNearestMarker) select 0);
_nextPos = getPosASL([_nextPos,1000] call BIS_fnc_nearestRoad);
ENEMY_COMMANDER move _nextPos;
NEXT_WAYPOINT = _nextPos;
_wpt setMarkerPos _nextPos;
waitUntil {sleep 5; unitReady _car || ENEMY_COMMANDER distance _nextPos < 10 };


//SECOND STEP => Moving to a building position in this compound and ave a sit
sleep 10;
_buildings = [_nextPos,300] call fnc_findBuildings;
_pos = ([_buildings select 0] call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
_crew =  _car;
{unassignVehicle _x;} forEach _escort;
_escort orderGetIn false;
ENEMY_COMMANDER doMove _pos;
_wpt setMarkerPos _pos;
waitUntil {sleep 5; unitReady ENEMY_COMMANDER || ENEMY_COMMANDER distance _nextPos < 2 };


//THIRD STEP => Have a sit and get back in vehicle
sleep 5;
ENEMY_COMMANDER action["sitdown",ENEMY_COMMANDER];
hint "First Stop";
sleep 100 + random 350;
{_x assignAsCargo _car;} forEach _escort;
_escort orderGetIn true;
waitUntil { sleep 5; ({_x in _car} count _escort) == count _escort};


//FOURTH STEP Move back to the position
_nextPos = _initPos;
ENEMY_COMMANDER move _nextPos;
NEXT_WAYPOINT = _nextPos;
_wpt setMarkerPos _nextPos;
waitUntil {sleep 5; unitReady _car || ENEMY_COMMANDER distance _nextPos < 10 };
sleep 100;
hint "Finish";

//Unspawn unit
deleteMarker _wpt;
{deleteVehicle _x; CONVOY = CONVOY - [_x];} forEach CONVOY;

SLEEP (200+(RANDOM 500));
[] spawn fnc_SpawnMainObjective;
false;