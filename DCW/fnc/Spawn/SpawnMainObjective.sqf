/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

if (!isServer) exitWith{false};

_nbTrucks = 2;
_roadRadius = 40;
_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
private _compos = [compo_commander1, compo_commander2];
private _situation = "+trees +forest*10 -meadow";
private _commanderPos = [];
private _tempList = [];

ENEMY_COMMANDER = objNull;
_grp = createGroup SIDE_ENEMY;
ESCORT = [];

private _initPos = [_worldCenter, 0, (_worldSize/2), 1, 0, 4, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST,[]] call BIS_fnc_FindSafePos;
if (_initPos isEqualTo []) exitWith{hint "unable to spawn the commander"};
_initPos = ((selectBestPlaces[_initPos, 100, _situation, 5, 1]) select 0 )select 0;

//Spawn the commander
ENEMY_COMMANDER = _grp createUnit [ENEMY_COMMANDER_CLASS, _initPos,[],ENEMY_SKILLS,"NONE"];
ENEMY_COMMANDER execVM "DCW\loadout\loadout-commander.sqf";

COMMANDER_LAST_POS = [];

//Custom variable
if (DEBUG) then {
    _marker = createMarker ["commander-marker",position ENEMY_COMMANDER];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "o_motor_inf";
    ENEMY_COMMANDER setVariable["marker",_marker];
};

//Push to units-spawned to update the marker pos
UNITS_SPAWNED pushback ENEMY_COMMANDER;
ESCORT pushBack ENEMY_COMMANDER;

//When the commander is attacked by the player group, he would try to flee. If he is far from the player, he would disappear and got respawned in another sector
ENEMY_COMMANDER addEventHandler ["FiredNear",{
    _commander= _this select 0;	
    _distance = _this select 2;	
    _gunner = _this select 7;	

    if (group _gunner == GROUP_PLAYERS && _distance < 50)then{
        [_gunner,"Shit ! this asshole is fleeing.",false]  remoteExec ["fnc_talk"];
        _commander removeAllEventHandlers "FiredNear";
        [_commander] joinSilent (createGroup SIDE_ENEMY);
        _commander setBehaviour "CARELESS";
        _commander forceWalk false;
        _commander forceSpeed 10;
        _dir = [_gunner,_commander] call BIS_fnc_dirTo; 
        _commanderPos = [(getPos _commander), 2000,_dir] call BIS_fnc_relPos;
        [_commanderPos, 200, 2000, 1, 0, 20, 0, MARKER_WHITE_LIST] call BIS_fnc_FindSafePos;

        _commander move _commanderPos;
        [_gunner] spawn{
            params["_gunner"];
            waitUntil{sleep 1;(_gunner distance ENEMY_COMMANDER) > 500 || !(alive ENEMY_COMMANDER) };
            if (!alive ENEMY_COMMANDER)exitWith{false};
            ENEMY_COMMANDER call fnc_deleteMarker;
            deleteVehicle ENEMY_COMMANDER;
            [_gunner ,"He has definitely left the area... Mission compromised. Maybe we would catch him later..." ,true ] remoteExec ["fnc_talk"];
            [] call fnc_SpawnMainObjective;
        };
    };
}];

ENEMY_COMMANDER addMPEventHandler ["MPKilled",{
    params["_unit","_killer"];

    if (group _killer == GROUP_PLAYERS)then{
        [_killer,{
            [_this,format["HQ ! This is %1, the enemy commander is KIA ! Out.",name _this],true] call fnc_talk;
            sleep 60;
            ["END1" ,true ,2 ] call BIS_fnc_endMission;
        }] remoteExec["spawn",0];
    }else{
        //Start over
        hint "restart...";
        { ESCORT = ESCORT - [_x]; _x call fnc_deleteMarker; deleteVehicle _x;} forEach ESCORT;
        [] spawn fnc_SpawnMainObjective;
    };
}];

//Civilian team spawn.
//If we killed them, it's over.

for "_yc" from 1 to 4  do {
    _unit =[_grp,_initPos,true] call fnc_spawnEnemy;
    ESCORT pushback _unit;
};

sleep 1;

_commanderPos = getPos ENEMY_COMMANDER;
COMMANDER_LAST_POS = [];

while {leader _grp == ENEMY_COMMANDER}do{

    //Push indication
    _newObjs = [_commanderPos, random 360, _compos call bis_fnc_selectrandom] call BIS_fnc_ObjectsMapper;
    _mainObj = _newObjs select 0;

    _trig = createTrigger["EmptyDetector",getPosATL _mainObj];
	_trig setTriggerArea[7,7,0,FALSE,3];
	_trig setTriggerActivation[str SIDE_PLAYER,"PRESENT",false];
	_trig setTriggerTimeout[1,1,1,true];
    _trig setTriggerStatements[
        "this",
        " [this] call fnc_foundCommander;",
        "deleteVehicle thisTrigger;"
    ];

    //Push to the global variable
    COMMANDER_LAST_POS pushback _commanderPos;  

    //Blacklist du joueur
    deleteMarker "mkr-cmdr-remove";
    _mkrToAvoid = createMarker ["mkr-cmdr-remove", position (leader GROUP_PLAYERS)];
    _mkrToAvoid setMarkerAlpha 0;
    _mkrToAvoid setMarkerSize [500,500];
    _tempList = MARKER_WHITE_LIST + [_mkrToAvoid];

    _initPos = _commanderPos;
    _commanderPos = [_commanderPos, 400, 3000, 1, 0, 5, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST] call BIS_fnc_FindSafePos;
    _commanderPos = ((selectBestPlaces[_commanderPos, 500, _situation, 5, 1]) select 0 )select 0;

    _grp setBehaviour "SAFE";
    _grp move _commanderPos;
    _grp setSpeedMode "FULL";

    //trace a line
    if (DEBUG)then{
        (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",format["(_this select 0) drawLine [%1,%2,[244, 93, 93,1]];",_initPos, _commanderPos]];
    };

    waitUntil {sleep 30; ENEMY_COMMANDER distance _commanderPos < 5};

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "LIMITED";

    sleep (15*60);
    
};


/*
{ESCORT = ESCORT - [_x];deleteVehicle _x; } forEach ESCORT;
*/
false;