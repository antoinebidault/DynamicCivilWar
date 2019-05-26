/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Spawn a officer to assassine
 */


if (!isServer) exitWith{false};

fnc_spawnOfficer = {
    
    _newPos = [];
    _radiusSpawnRange = [1000,5400];

    _worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
    _worldCenter = [_worldSize/2,_worldSize/2,0];
    _initPos = [_worldCenter,0, _worldSize, 4, 0, 20, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST] call BIS_fnc_FindSafePos;

    //Trucks
    _road = [_initPos,3000, MARKER_WHITE_LIST] call BIS_fnc_nearestRoad;
    _roadPos = getPos _road;
    _roadConnectedTo = roadsConnectedTo _road;
    if (count _roadConnectedTo == 0) exitWith { hint "restart"; [] call fnc_spawnOfficer;  };
    _connectedRoad = _roadConnectedTo select 0;
    _roadDirection = [_road, _connectedRoad] call BIS_fnc_DirTo;

    _grp = createGroup SIDE_ENEMY;
    _officer = _grp createUnit [ENEMY_COMMANDER_CLASS, _initPos,[],AI_SKILLS,"NONE"];
    [_officer] joinSilent _grp;

    removeAllWeapons _officer;
    _officer setBehaviour "SAFE";
    _officer execVM "DCW\loadout\loadout-officer.sqf";
    _unit enableDynamicSimulation false;
    //_officer enableDynamicSimulation true;

    _truckGrp = createGroup SIDE_ENEMY;
    _truck = [_roadPos, _roadDirection, ENEMY_OFFICER_LIST_CARS call bis_fnc_selectrandom,_truckGrp ] call BIS_fnc_spawnVehicle select 0;
    _truck enableDynamicSimulation false;

    _officer moveInAny _truck;

    _nbUnit = (count (fullCrew [_truck,"cargo",true])) - 1 min 8;
    _unit = objNull;
    for "_yc" from 1 to _nbUnit  do {
        _unit = [_grp, _initPos, true] call fnc_spawnEnemy;
        _unit enableDynamicSimulation false;
        ESCORT_UNITS pushback _unit;
        _unit moveInAny _truck;    
    };

    _grp selectLeader _officer;

    [_truck,_officer] spawn fnc_officerPatrol;

    _officer addMPEventHandler ["MPKilled",{
        params["_unit","_killer"];
        [format["DCW_secondary_%1", name _unit],"SUCCEEDED",true] remoteExec ["BIS_fnc_taskSetState",_x,true];
        OFFICERS = OFFICERS - [_unit];
    }];

    _officer removeAllEventHandlers "HandleDamage";
    _officer addEventHandler ["HandleDamage",{
        
        params [
            "_unit",			// Object the event handler is assigned to.
            "_hitSelection",	// Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
            "_damage",			// Resulting level of damage for the selection.
            "_source",			// The source unit (shooter) that caused the damage.
            "_projectile",		// Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.) (String)
            "_hitPartIndex",	// Hit part index of the hit point, -1 otherwise.
            "_instigator",		// Person who pulled the trigger. (Object)
            "_hitPoint"			// hit point Cfg name (String)
        ];
        
        if (_damage == 0) exitWith {false};
        
        if (_damage > .9 && !(_unit getVariable["DCW_isUnconscious",false])) then {
            _unit setVariable["DCW_isUnconscious",true];
            [_unit] remoteExec ["fnc_shout", 0];	
            _unit remoteExec ["removeAllActions",0];
            _unit setDamage .9;
            _unit setHit ["legs", 1];

            if (vehicle _unit != _unit)then{
                moveOut _unit;
            };

            [leader GROUP_PLAYERS,"The officer is down ! Let's go talk to him !", true] remoteExec ["fnc_talk",_x,false];
    
            
            //Spasm and unconscious state
            _unit spawn {
                sleep .2;
                _this setUnconscious true;
                waitUntil { vehicle _this != _this || animationState _this == "ainjppnemstpsnonwrfldnon"  }; 
                _this playAction "GestureSpasm" + str floor random 7; 
            };	

            _damage = .9;


            [ _unit,"Interrogate","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","true","true",{
                (_this select 1) playActionNow "medicStart";
            },{
                (_this select 1) playActionNow "medicStart";
            },{
                params["_unit","_player"];
                _player playActionNow "medicStop";
                {
                    [format["DCW_secondary_%1", name _unit],"SUCCEEDED",true] remoteExec ["BIS_fnc_taskSetState",_x,true];
                } foreach allPlayers;
                OFFICERS = OFFICERS - [_unit];
                _unit setVariable["DCW_interrogated",true];
                _unit removeAllMPEventHandlers "MPKilled";
                
                [_unit]spawn{
                    params["_unit"];
                    sleep 100;
                    _unit setDamage 1;
                };
                
                _unit call fnc_MainObjectiveIntel;
            },{
            (_this select 1) playActionNow "medicStop";
            },[],3,nil,true,false] remoteExec ["BIS_fnc_holdActionAdd"];

        } else {
            if (!(_unit getVariable["DCW_interrogated",false]) && _unit getVariable["DCW_isUnconscious",false]) then {
                _damage = .9;
                _unit setDamage .9;
            };
        };
        
        _damage;
    }];


    //Custom variable
    _marker = createMarker [format["officerlmarker-%1",str random 100],getPos _officer];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "mil_warning";
    _marker setMarkerAlpha 0;
    _officer setVariable["marker",_marker];
    _officer;
};

// Spawning officers
for "_i" from 1 to NUMBER_OFFICERS  do {
     OFFICERS pushback([] call fnc_spawnOfficer);
     sleep 5;
};


sleep 10;

while {sleep 20; count OFFICERS  > 0 } do {

    // Find the closest officer
    _officer = objNull;
    _dist = 0;
    {
      if (_dist < (_x distance2D (leader GROUP_PLAYERS))) then {
          _officer = _x;
          _dist = (_x distance2D (leader GROUP_PLAYERS));
      };
    } count OFFICERS;

    _marker = _officer getVariable["marker",""];
    _loc =  nearestLocations [getPosWorld _officer, ["NameVillage","NameCity","NameCityCapital"],10000] select 0;
    {
        // Task creation
        [format["DCW_secondary_%1", name _officer],_x, [format["Our drones give us some informations about an insurgent's officer location. Move to his location and try to gather infomration. His name is %1",name _officer],"Interrogate the officer","Interrogate the officer"],getPos _officer,"CREATED",1, true] remoteExec ["BIS_fnc_setTask",_x, true];
        
        // HQ message
        [HQ,format["We have some new intels on the enemy officer : %1, maybe he is located %2km from %3",name _officer,round(((getPos _loc) distance2D (_x))/100)/100,text _loc], true] remoteExec ["fnc_talk",_x,false];
    } foreach allPlayers;

    _marker setMarkerAlpha 1;
    _marker setMarkerPos (getPos _officer);
    sleep 600 + random 200;
};

[HQ,format["Good job team, it seems you stopped the propagation of the insurgency... The %1 officers have been neutralized.", NUMBER_OFFICERS], true] remoteExec ["fnc_talk"];
[HQ,format["Next step is to consolidate our position and catch the main commander of the movement %1...", name ENEMY_COMMANDER], true] remoteExec ["fnc_talk"];
  
[100] call fnc_spawnConvoy;
false;