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

if (!isServer) exitWith{false};

_nbTrucks = 2;
_roadRadius = 40;
 _worldSize = (getMarkerSize GAME_ZONE) select 0;
_worldCenter = getMarkerPos GAME_ZONE;
private _compos = [compo_commander1, compo_commander2];
private _situation = "+trees +forest*10 -meadow";
private _commanderPos = [];
private _tempList = [];

ENEMY_COMMANDER = objNull;
_grp = createGroup SIDE_ENEMY;
_units = [];

private _initPos = [_worldCenter, 0, (_worldSize/2), 1, 0, 4, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST,[]] call BIS_fnc_findSafePos;
if (_initPos isEqualTo []) exitWith{hint "unable to spawn the commander"};
_initPos = ((selectBestPlaces[_initPos, 100, _situation, 5, 1]) select 0 )select 0;

//Spawn the commander
ENEMY_COMMANDER = _grp createUnit [ENEMY_COMMANDER_CLASS, _initPos,[],AI_SKILLS,"NONE"];
[ENEMY_COMMANDER] joinSilent _grp;
ENEMY_COMMANDER enableDynamicSimulation false;
ENEMY_COMMANDER execVM "DCW\loadout\loadout-commander.sqf";

COMMANDER_LAST_POS = [];

//Custom variable
if (DEBUG) then {
    _marker = createMarker ["commander-marker", position ENEMY_COMMANDER];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "o_motor_inf";
    ENEMY_COMMANDER setVariable["marker",_marker];
};

//Push to units-spawned to update the marker pos
_units pushBack ENEMY_COMMANDER;

//When the commander is attacked by the player group, he would try to flee. If he is far from the player, he would disappear and got respawned in another sector
ENEMY_COMMANDER addEventHandler ["FiredNear",{
    _commander= _this select 0;	
    _distance = _this select 2;	
    _gunner = _this select 7;	

    if (group _gunner == GROUP_PLAYERS && _distance < 50)then{
        [_gunner,"Shit ! this asshole is fleeing.",false]  remoteExec ["DCW_fnc_talk"];
        _commander removeAllEventHandlers "FiredNear";
        [_commander] joinSilent (createGroup SIDE_ENEMY);
        _commander setBehaviour "CARELESS";
        _commander forceWalk false;
        _commander forceSpeed 10;
        _dir = [_gunner,_commander] call BIS_fnc_dirTo; 
        _commanderPos = [(getPos _commander), 2000,_dir] call BIS_fnc_relPos;
        [_commanderPos, 200, 2000, 1, 0, 20, 0, MARKER_WHITE_LIST] call BIS_fnc_findSafePos;

        _commander move _commanderPos;
        [_gunner,_commander] spawn {
            params["_gunner","_commander"];
            waitUntil{sleep 1;(_gunner distance _commander) > 500 || !(alive _commander) };
            if (!alive _commander)exitWith{false};
            _commander call DCW_fnc_deleteMarker;
            deleteVehicle _commander;
            [_gunner ,"He has definitely left the area... Mission compromised. Maybe we would catch him later..." ,true ] remoteExec ["DCW_fnc_talk"];
            [] spawn DCW_fnc_spawnMainObjective;
        };
    };
}];

ENEMY_COMMANDER addMPEventHandler ["MPKilled",{
    params["_unit","_killer"];

    if (group _killer == GROUP_PLAYERS)then{
        [_killer,{
            "seal" remoteExec ["playMusic"];
            [_this, format["HQ ! This is %1, the enemy commander is KIA ! Out.",name _this],true] remoteExec ["DCW_fnc_talk"];
            [HQ, "Good job everyone ! We're sending you a chopper to the extraction point !",true] remoteExec ["DCW_fnc_talk"];
            hint "mission successful ! Good job soldier !";
            sleep 60;
            activateKey "key1";
            "EveryoneWon" call BIS_fnc_endMissionServer;
        }] remoteExec["spawn",0];
    }else{
        //Start over
        hint "restart...";
        [] spawn DCW_fnc_spawnMainObjective;
    };
}];

//Civilian team spawn.
//If we killed them, it's over.

for "_yc" from 1 to 4  do {
    _unit =[_grp,_initPos,true] call DCW_fnc_spawnEnemy;
    _unit enableDynamicSimulation false;
    _units pushback _unit;
};

sleep 1;

_commanderPos = getPos ENEMY_COMMANDER;
COMMANDER_LAST_POS = [];

while {alive (leader _grp) && leader _grp == ENEMY_COMMANDER}do{

    //Push indication
    _newObjs = [_commanderPos, random 360, _compos call bis_fnc_selectrandom] call BIS_fnc_ObjectsMapper;
    _mainObj = _newObjs select 0;

    _trig = createTrigger["EmptyDetector",getPosATL _mainObj];
	_trig setTriggerArea[7,7,0,FALSE,3];
	_trig setTriggerActivation[str SIDE_FRIENDLY,"PRESENT",false];
	_trig setTriggerTimeout[1,1,1,true];
    _trig setTriggerStatements[
        "this",
        " [thisList select 0] spawn DCW_fnc_foundCommander;",
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
    _commanderPos = [_commanderPos, 400, 600, 1, 0, 5, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST] call BIS_fnc_findSafePos;
    _commanderPos = ((selectBestPlaces[_commanderPos, 350, _situation, 5, 1]) select 0 )select 0;

    _grp setBehaviour "SAFE";
    _grp move _commanderPos;
    _grp setSpeedMode "FULL";

    //trace a line
    if (DEBUG)then{
        (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",format["(_this select 0) drawLine [%1,%2,[244, 93, 93,1]];",_initPos, _commanderPos]];
    };

    waitUntil {sleep 30;!alive (leader _grp) || leader _grp != ENEMY_COMMANDER || ENEMY_COMMANDER distance _commanderPos < 5};

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "LIMITED";

    sleep (12*60);
    
};

{_units = _units - [_x]; _x call DCW_fnc_deleteMarker; deleteVehicle _x; } forEach _units;

false;