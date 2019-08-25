/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

//Stand by during a long period
if (!isServer) exitWith{false};

_units = [];

//SLEEP (_this select 0);

_nbVeh = 3;
_nbTrucks = _nbVeh - 1;
_roadRadius = 40;

 _worldSize = (getMarkerSize GAME_ZONE) select 0;
_worldCenter = getMarkerPos GAME_ZONE;

_initPos = [_worldCenter,0,_worldSize, 4, 0, 20, 0, MARKER_WHITE_LIST,[]] call BIS_fnc_findSafePos;
if (_initPos isEqualTo []) exitWith{ hint "unable to spawn the convoy"; };
_road = [_initPos,500,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad;
_roadPos = getPos _road;

_grp = createGroup SIDE_ENEMY;
_car = objNull;
CAR_DESTROYED = 0;

if (isOnRoad(_roadPos) && _roadPos distance (leader GROUP_PLAYERS) > 300 )then{
    [HQ,"There is an enemy convoy moving not far from your position. You can destroy them to earn some points.",true] call DCW_fnc_talk;
    _roadConnectedTo = roadsConnectedTo _road;
    _connectedRoad = _roadConnectedTo select 0;
    _roadDirection = [_road, _connectedRoad] call BIS_fnc_dirTo;
    _car = [_roadPos, _roadDirection, ENEMY__units_CAR_CLASS, _grp] call BIS_fnc_spawnVehicle select 0;
    (driver _car) enableSimulationGlobal false;
    
    _car addMPEventHandler ["MPKilled",{
        [GROUP_PLAYERS,100] remoteExec ["DCW_fnc_updateScore",2];   
        CAR_DESTROYED = CAR_DESTROYED + 1;
    }];

    _units pushback _car;
    _units = _units + (crew _car);
   
    _nbUnit = (count (fullCrew [_car,"cargo",true])) min 10;
    
    //Civilian team spawn.
    //If we killed them, it's over.
    for "_xc" from 1 to _nbUnit  do {
        _unit =[_grp,_initPos,true] call DCW_fnc_spawnEnemy;
        _unit enableSimulationGlobal false;
        _unit moveInCargo _car;
        _units pushback _unit;
    };

    //Trucks
    for "_xc" from 1 to _nbTrucks  do {
        _grpTruck = createGroup SIDE_ENEMY;
        _truck = [_car modelToWorld [0,-(_xc*15),0], _roadDirection, ENEMY__units_TRUCK_CLASS call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle select 0;
        _nbUnit = (count (fullCrew [_truck,"cargo",true]));
        for "_yc" from 1 to _nbUnit  do {
            _unit = [_grpTruck,_initPos,true] call DCW_fnc_spawnEnemy;
            _unit enableSimulationGlobal false;
            _unit moveInCargo _truck;
            _units pushback _unit;
        };
         _units pushback _truck;
         _units = _units + (crew _truck);

         if (isNil '_truck') then{
             CAR_DESTROYED = CAR_DESTROYED + 1;
         };

         _truck addMPEventHandler ["MPKilled",{
            [GROUP_PLAYERS,100] remoteExec ["DCW_fnc_updateScore",2];   
            CAR_DESTROYED = CAR_DESTROYED + 1;
         }];
    };

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "NORMAL";
    _grp setFormation "COLUMN";

}else{
 hint "Error ! Not enough road to spawn objective... Restarting...";
 sleep 10;
 [30] call DCW_fnc_spawnConvoy;
};

deleteMarker "convoy-start-marker";
private _wpt = createMarker ["convoy-start-marker",_roadPos];
_wpt setMarkerShape "ICON";
_wpt setMarkerColor "ColorRed";
_wpt setMarkerType "mil_start";
_wpt setMarkerText "convoy start";

deleteMarker "convoy-end-marker";
_wpt = createMarker ["convoy-end-marker",[0,0,0]];
_wpt setMarkerShape "ICON";
_wpt setMarkerColor "ColorRed";
_wpt setMarkerType "hd_ambush";
_wpt setMarkerText "convoy destination";



//FIRST STEP => Moving to a random compound enemy
_nextPos = getMarkerPos (([getPos ((units GROUP_PLAYERS) call BIS_fnc_selectRandom), true, "bastion"] call DCW_fnc_findNearestMarker) select 0);
_nextPos = getPosASL([_nextPos,1000,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad);
(leader _grp) move _nextPos;
_wpt setMarkerPos _nextPos;

waitUntil {sleep 5;  CAR_DESTROYED == _nbVeh || (leader _grp) distance _nextPos < 10 };
sleep 100 + random 400;

//SECOND STEP Move back to the position
_nextPos = _initPos;
(leader _grp)  move _nextPos;

waitUntil {sleep 5; CAR_DESTROYED == _nbVeh || (leader _grp)  distance _nextPos < 10 };

if (CAR_DESTROYED == _nbVeh) exitWith {
    [HQ,"You successfully ambushed the convoy ! Well done !",true] remoteExec ["DCW_fnc_talk"];
    [300] spawn DCW_fnc_spawnConvoy;
};

sleep 100;

//Unspawn unit
waitUntil {sleep 12; CAR_DESTROYED == _nbVeh || {_x distance (leader _grp) > 700} count ([] call DCW_fnc_allPlayers) == count ([] call DCW_fnc_allPlayers)};
{_units = _units - [_x]; _x call DCW_fnc_deleteMarker; deleteVehicle _x; } forEach _units;

[HQ,"You missed the convoy ! Out !",true] remoteExec ["DCW_fnc_talk"];
[300] spawn DCW_fnc_spawnConvoy;
false;