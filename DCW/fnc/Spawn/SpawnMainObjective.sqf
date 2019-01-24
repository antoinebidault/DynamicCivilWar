/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_nbTrucks = 2;
_roadRadius = 40;
_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
private _compos = [compo_commander1,compo_commander2];
private _situation = "+trees +forest*10 -meadow";
private _newPos = [];

ENEMY_COMMANDER = objNull;
_grp = createGroup ENEMY_SIDE;
ESCORT = [];

_mkrToAvoid = createMarker ["mkrToAvoid",getPos player];
_mkrToAvoid setMarkerShape "ELLIPSE";
_mkrToAvoid setMarkerAlpha 0;
_mkrToAvoid setMarkerSize [1000,1000];
_tempList = MARKER_WHITE_LIST + [_mkrToAvoid];


private _initPos = [_worldCenter, 300, 1000, 4, 0, 20, 0, _tempList] call BIS_fnc_FindSafePos;
_initPos = ((selectBestPlaces[_initPos, 500, _situation, 5, 1]) select 0 )select 0;


//Spawn the commander
ENEMY_COMMANDER = _grp createUnit [ENEMY_COMMANDER_CLASS, _initPos,[],ENEMY_SKILLS,"NONE"];
ENEMY_COMMANDER execVM "DCW\loadout\loadout-commander.sqf";

COMMANDER_LAST_POS = [];

//Custom variable
if (DEBUG) then {
    _marker = createMarker ["commanderMarker",getPos ENEMY_COMMANDER];
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
    _civ=_this select 0;	
    _distance = _this select 2;	
    _gunner = _this select 7;	

    if (group _gunner == group player && _distance < 50)then{
        [player,"Shit ! this asshole is fleeing."] spawn fnc_talk;
        _civ removeAllEventHandlers "FiredNear";
        [_civ] joinSilent (createGroup ENEMY_SIDE);
        _civ setBehaviour "CARELESS";
        _civ forceWalk false;
        _civ forceSpeed 10;
        _dir = [player,_civ] call BIS_fnc_dirTo; 
        _newPos = [(getPos _civ), 2000,_dir] call BIS_fnc_relPos;
        [_newPos, 0, 2000, 4, 0, 20, 0, MARKER_WHITE_LIST] call BIS_fnc_FindSafePos;
        _civ move _newPos;
        [] spawn{
            waitUntil{sleep 1;(player distance ENEMY_COMMANDER) > 500 || !(alive ENEMY_COMMANDER) };
            if (!alive ENEMY_COMMANDER)exitWith{false};
            deleteMarker ENEMY_COMMANDER getVariable["marker",""];
            deleteVehicle ENEMY_COMMANDER;
            [player,"He has definitely left the area... Mission compromised. Maybe we would catch him later..."] call fnc_talk;
            //{ESCORT = ESCORT - [_x];deleteVehicle _x; } forEach ESCORT;
            [] call fnc_SpawnMainObjective;
        };
    };
}];

ENEMY_COMMANDER addEventHandler ["Killed",{
    params["_unit","_killer"];

    if (group _killer == group player)then{
        []spawn{
            [player,"HQ ! This is charlie team, the enemy commander is KIA ! Out."] call fnc_talk;
            sleep 14;
            ["END1",true,2] call BIS_fnc_endMission;
        };
    }else{
        //Start over
        { ESCORT = ESCORT - [_x]; deleteMarker (_x getVariable["marker",""]);deleteVehicle _x;} forEach CONVOY;
        [] spawn fnc_SpawnMainObjective;
    };
}];

//Civilian team spawn.
//If we killed them, it's over.


for "_yc" from 1 to 4  do {
    _unit =[_grp,_initPos,true] call fnc_spawnEnemy;
    ESCORT pushback _unit;
};

_newPos = getPos ENEMY_COMMANDER;
COMMANDER_LAST_POS = [];
while {leader _grp == ENEMY_COMMANDER}do{

    //Push indication
    _newObjs = [_newPos,random 360, _compos call bis_fnc_selectrandom] call BIS_fnc_ObjectsMapper;
    _mainObj = _newObjs select 0;

    _trig = createTrigger["EmptyDetector",getPosATL _mainObj];
	_trig setTriggerArea[7,7,0,FALSE,3];
	_trig setTriggerActivation[str SIDE_CURRENT_PLAYER,"PRESENT",false];
	_trig setTriggerTimeout[1,1,1,true];
    _trig setTriggerStatements[
        "this",
        "playMUsic ""BackgroundTrack02_F"";[player,""HQ, this is bravo team, we've found the presumed camp where the commander went. We are at the last known position. We'll investigate the compound around""] spawn fnc_talk;",
        "deleteVehicle thisTrigger"
    ];

    //Push to the global variable
    COMMANDER_LAST_POS pushback _newPos;  

    //Blacklist du joueur
    _mkrToAvoid = createMarker ["mkrToAvoid",getPos player];
    _mkrToAvoid setMarkerAlpha 0;
    _mkrToAvoid setMarkerSize [1500,1500];
    _tempList = MARKER_WHITE_LIST + [_mkrToAvoid];

    _initPos = _newPos;
    _newPos = [_newPos, 600, 1600, 1, 0, 20, 0,_tempList] call BIS_fnc_FindSafePos;
    _newPos = ((selectBestPlaces [_newPos, 200, _situation, 5, 1]) SELECT 0)SELECT 0;

    _grp setBehaviour "SAFE";
    _grp move _newPos;
    _grp setSpeedMode "FULL";

    //trace a line
    if (DEBUG)then{
        (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",format["(_this select 0) drawLine [%1,%2,[244, 93, 93,1]];",_initPos,_newPos]];
    };

    waitUntil {sleep 30; ENEMY_COMMANDER distance _newPos < 5};

    _grp setBehaviour "SAFE";
    _grp setSpeedMode "LIMITED";

    sleep (15*60);
    
};


/*
{ESCORT = ESCORT - [_x];deleteVehicle _x; } forEach ESCORT;
*/
false;