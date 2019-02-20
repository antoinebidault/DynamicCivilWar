/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Stand by during a long period

//SLEEP (200+(RANDOM 500)) + (_this select 0);

private _nbVeh = 3;
private _nbTrucks = _nbVeh - 1;
private _roadRadius = 40;

private _mkrToAvoid = createMarker ["mkr-to-avoid",getPos player];
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerSize [500,500];
private _tempList = MARKER_WHITE_LIST + [_mkrToAvoid];
private _initPos = [getPos player,2500,3000, 5, 0, 20, 0, _tempList] call BIS_fnc_FindSafePos;

private _road = [_initPos,1000] call BIS_fnc_nearestRoad;
private _roadPos = getPos _road;


private _grp = createGroup ENEMY_SIDE;
private _car = objNull;
CONVOY = [];
CAR_DESTROYED = 0;

if (isOnRoad(_roadPos) && _roadPos distance player > 300 )then{
    [HQ,"There is an enemy convoy moving not far from your position. You can destroy them to earn some points."] call fnc_talk;
    private _roadConnectedTo = roadsConnectedTo _road;
    private _connectedRoad = _roadConnectedTo select 0;
    private _roadDirection = [_road, _connectedRoad] call BIS_fnc_DirTo;
    _car = [_roadPos, _roadDirection, ENEMY_CONVOY_CAR_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;

    _car addEventHandler["Killed",{
        [player,30] spawn fnc_updatescore;
        CAR_DESTROYED = CAR_DESTROYED + 1;
    }];

    CONVOY pushback _car;
    CONVOY = CONVOY + (crew _car);
   
    _nbUnit = (count (fullCrew [_car,"cargo",true]));
    
    //Civilian team spawn.
    //If we killed them, it's over.
    for "_xc" from 1 to _nbUnit  do {
        _unit =[_grp,_initPos,true] call fnc_spawnEnemy;
        _unit moveInCargo _car;
        CONVOY pushback _unit;
    };

    //Trucks
    for "_xc" from 1 to _nbTrucks  do {
        _grpTruck = createGroup ENEMY_SIDE;
        _truck = [_car modelToWorld [0,-(_xc*15),0], _roadDirection, ENEMY_CONVOY_TRUCK_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;
        _nbUnit = (count (fullCrew [_truck,"cargo",true]));
        for "_yc" from 1 to _nbUnit  do {
            _unit =[_grpTruck,_initPos,true] call fnc_spawnEnemy;
            _unit moveInCargo _truck;
            CONVOY pushback _unit;
        };
         CONVOY pushback _truck;
         CONVOY = CONVOY + (crew _truck);

         if (isNil '_truck') then{
             CAR_DESTROYED = CAR_DESTROYED + 1;
         };

         _truck addEventHandler["Killed",{
             [player,50] spawn fnc_updatescore;
            CAR_DESTROYED = CAR_DESTROYED + 1;
         }];
    };

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "NORMAL";
    _grp setFormation "COLUMN";

}else{
 hint "Error ! Not enough road to spawn objective... Restarting...";
 sleep 10;
 [30] call fnc_SpawnConvoy;
};

deleteMarker "convoyStartMarker";
private _wpt = createMarker ["convoyStartMarker",_roadPos];
_wpt setMarkerShape "ICON";
_wpt setMarkerColor "ColorRed";
_wpt setMarkerType "mil_start";
_wpt setMarkerText "Convoy start";

deleteMarker "convoyEndMarker";
_wpt = createMarker ["convoyEndMarker",[0,0,0]];
_wpt setMarkerShape "ICON";
_wpt setMarkerColor "ColorRed";
_wpt setMarkerType "hd_ambush";
_wpt setMarkerText "Convoy destination";

//FIRST STEP => Moving to a random compound
private _nextPos = getMarkerPos (([getPos player] call fnc_findNearestMarker) select 0);
_nextPos = getPosASL([_nextPos,1000] call BIS_fnc_nearestRoad);
(leader _grp) move _nextPos;
_wpt setMarkerPos _nextPos;

waitUntil {sleep 5; CAR_DESTROYED == _nbVeh || (leader _grp) distance _nextPos < 10 };
sleep 100 + random 400;

//SECOND STEP Move back to the position
_nextPos = _initPos;
(leader _grp)  move _nextPos;

waitUntil {sleep 5; CAR_DESTROYED == _nbVeh || (leader _grp)  distance _nextPos < 10 };

if (CAR_DESTROYED == _nbVeh) exitWith {
    [HQ,"You successfully ambushed the convoy ! Well done !"] call fnc_talk;
    [600] spawn fnc_SpawnMainObjective;
};

sleep 100;

//Unspawn unit
waitUntil {sleep 5;CAR_DESTROYED == _nbVeh || player distance (leader _grp) > 700};
{deleteVehicle _x; CONVOY = CONVOY - [_x];} forEach CONVOY;

[HQ,"You missed the convoy ! Out !"] call fnc_talk;
[0] spawn fnc_SpawnMainObjective;
false;