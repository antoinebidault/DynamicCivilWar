 /*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Base server executed code
*/

if (!isServer) exitWith{};

// Keep only four units in singleplayer
if (!isMultiplayer)then{
	{ if (_foreachIndex > 3) then { deleteVehicle _x; } } forEach units GROUP_PLAYERS;
};

addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	//_unit = _this select 0;
    deleteVehicle _unit;
	if (count ([] call DCW_fnc_allPlayers) == 0) then {
	  // "EveryoneLost" call BIS_fnc_endMissionServer;
	};
	true;
}];

// Reload hud
addMissionEventHandler ["Loaded",{ 
    [] spawn {
		hint "mission loaded";
		sleep 4;
		[] call DCW_fnc_displayscore;
    };
}];


// Server scope public variable
MARKERS = []; 
PLAYER_MARKER_LIST = []; //Pass list of marker white list name
UNITS_SPAWNED_CLOSE = [];
SHEEP_POOL = [];
LAST_FLARE_TIME = time;
REFRESH_TIME = 10; // Refresh time
WEATHER = .5;
INITIAL_SPAWN_DISTANCE = SPAWN_DISTANCE;
GEAR_AND_STUFF = [];
OFFICERS = [];
IN_MARKERS_LOOP = false;

// Create a fake HQ unit
"B_RangeMaster_F" createUnit [[-1000,-1000], createGroup SIDE_FRIENDLY, "this allowDamage false; HQ = this; ", 0.6, "colonel"];
[]spawn{
	sleep 1;
	HQ setName "HQ";
};

STAT_POP_START = 0;
publicVariable "STAT_POP_START";
STAT_POP_CURRENT = 0;
publicVariable "STAT_POP_CURRENT";
STAT_SUPPORT_START = 0;
publicVariable "STAT_SUPPORT_START";
STAT_SUPPORT = 0;
publicVariable "STAT_SUPPORT";
STAT_COMPOUND_TOTAL = 0;
publicVariable "STAT_COMPOUND_TOTAL";
STAT_COMPOUND_SECURED = 0;
publicVariable "STAT_COMPOUND_SECURED";
STAT_COMPOUND_BASTION = 0;
publicVariable "STAT_COMPOUND_BASTION";
STAT_COMPOUND_MASSACRED = 0;
publicVariable "STAT_COMPOUND_MASSACRED";


_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
_gameZoneSize = [_worldSize/2,_worldSize/2];
_gameZoneX = 0;
_gameZoneY = 0;
if (getMarkerColor "GAME_ZONE" == "") then {
	GAME_ZONE = createMarker ["GAME_ZONE", _worldCenter];
	GAME_ZONE setMarkerShape "RECTANGLE";
	GAME_ZONE setMarkerAlpha 0.2;
	GAME_ZONE setMarkerColor "ColorGreen";
	GAME_ZONE setMarkerSize [_worldSize/2,_worldSize/2];
}else {
	GAME_ZONE = "GAME_ZONE";
	_gameZoneSize = getMarkerSize GAME_ZONE;
	_gameZonePosition = getMarkerPos GAME_ZONE;
	_gameZoneX = (_gameZonePosition select 0) - (_gameZoneSize select 0);
	_gameZoneY = (_gameZonePosition select 1) - (_gameZoneSize select 1);
};
publicVariable "GAME_ZONE";

// Black list all the sector around the main marker
{
	private _i = _x select 0;
	private _j = _x select 1;
	private _position = [_gameZoneX + (_i * (_gameZoneSize select 0)),_gameZoneY + (_j * (_gameZoneSize select 1)), 0];
	private _mp = createMarker [format["edge-map-%1-%2",str _i, str _j], _position];
	_mp setMarkerShape "RECTANGLE";
	_mp setMarkerAlpha 0.3;
	_mp setMarkerColor "ColorBlack";
	_mp setMarkerSize _gameZoneSize;
	MARKER_WHITE_LIST pushBack _mp;
} forEach [[-1,-1],[-1,1],[-1,3],[3,-1],[3,1],[3,3],[1,3],[1,-1]];
publicVariable "MARKER_WHITE_LIST";


//On civilian killed
CIVILIAN_KILLED = { 
	params["_unit","_killer"]; 
	hint format ["%1 %2 was killed by %3",name (_unit),side _unit,name (_killer)];
	[_unit,-4] remoteExec ["DCW_fnc_updateRep",2];
	[GROUP_PLAYERS,-50,false,_killer] remoteExec ["DCW_fnc_updateScore",2];
};

//On enemy killed => 2 points
ENEMY_KILLED = {
	params["_type","_unit"]; 
	[GROUP_PLAYERS, 10,true] remoteExec ["DCW_fnc_updateScore",2];
 };


//If civilian is healed by player
CIVIL_HEALED = { 
	[GROUP_PLAYERS,30,false,(leader GROUP_PLAYERS)]  remoteExec ["DCW_fnc_updateScore",2];
 };

//If civil is captured
 CIVIL_CAPTURED = { 
	//[GROUP_PLAYERS,-5] call DCW_fnc_updateScore;
 };

// If player is killed
 PLAYER_KIA = { 
	[GROUP_PLAYERS,-20,false,(leader GROUP_PLAYERS)] remoteExec ["DCW_fnc_updateScore",2];
 };

//On enemy search.
ENEMY_SEARCHED = {
	params["_unit","_player"];
	[GROUP_PLAYERS, 2 + ceil (random 10),false,_player] remoteExec ["DCW_fnc_updateScore",2];
};

// Consuming work => getAllClusters executed in background
CLUSTERS = [];
[] spawn {
	CLUSTERS = [GAME_ZONE] call DCW_fnc_getClusters;
};

// Set default side
RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 0];

CIVILIAN setFriend [EAST, 1];
CIVILIAN setFriend [WEST, 1];
CIVILIAN setFriend [RESISTANCE, 1];

// Wait untill everything is started
WAITUNTIL { DCW_STARTED };

// Add in whitelist the basemarker
{  if (_x find "blacklist_" == 0 || _x find "marker_base" == 0 ) then { MARKER_WHITE_LIST pushback _x }; }foreach allMapMarkers; 
publicVariable "MARKER_WHITE_LIST";

// This spawn is very important... Because it breaks the singleplayer savegames
[] spawn {

	// TIME
	setDate [2018, 6, 25, TIME_OF_DAYS, 0]; 

	// OVERCAST
	0 setOvercast WEATHER;
	0 setRain (if (WEATHER > .7) then {random 1}else{0});
	// setWind [10*WEATHER, 10*WEATHER, true];
	0 setFog [if (WEATHER > .8) then {.15}else{0},if (WEATHER > .8) then {.04}else{0}, 60];
	0 setGusts (WEATHER - .3);
	0 setWaves WEATHER;
	forceWeatherChange;
	sleep 1;
	// Chopper introduction
	_dest = START_POSITION;
	_spawnpos = [_dest, 1000, 2000, 0, 1, 20, 0] call BIS_fnc_findSafePos;
	_spawnpos set [2,70]; 
	_heli_spawn = [_spawnpos, 0, SUPPORT_MEDEVAC_CHOPPER_CLASS call BIS_fnc_selectRandom, SIDE_FRIENDLY] call BIS_fnc_spawnVehicle;
	_chopper = _heli_spawn select 0;
	_chopper setPos _spawnpos;
	createVehicleCrew (_chopper);
	_pilot = driver _chopper;
	if (!DEBUG) then {
		{
			_x moveInAny _chopper;
		} foreach units GROUP_PLAYERS;
	};
	_chopper setCollisionLight true;
	_chopper setPilotLight true;
	_chopper flyInHeight 70;
	_chopper setCaptive true;
	_pilot setSkill 1;
	_chopper flyInHeight 70;
	{ _pilot disableAI _x; } forEach ["TARGET", "AUTOTARGET", "AUTOCOMBAT"];
	group _pilot setBehaviour "CARELESS";
	(group _pilot) allowFleeing 0;

	_helipad_obj = "Land_HelipadEmpty_F" createVehicle _dest;

	_waypoint = (group (_pilot)) addWaypoint [_dest, 0];
	_waypoint setWaypointType "TR UNLOAD";
	_waypoint setWaypointBehaviour "CARELESS";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointStatements ["{vehicle _x == this} count units GROUP_PLAYERS == 0", "(vehicle this) land ""GET IN""; GROUP_PLAYERS  leaveVehicle (vehicle this);"];
	_waypoint setWaypointCompletionRadius 4;

	_waypoint2 = (group (_pilot)) addWaypoint [_spawnpos, 1];
	_waypoint2 setWaypointType "MOVE";
	_waypoint2 setWaypointSpeed "FULL";
	_waypoint2 setWaypointCompletionRadius 40;
	_waypoint2 setWaypointStatements ["true", "{deleteVehicle _x} foreach crew (vehicle this); deleteVehicle (vehicle this);"];

	CHOPPER_INTRO = _chopper;
	publicVariable "CHOPPER_INTRO";

	// Make the chopper throw some flare when arriving to destination
	[CHOPPER_INTRO,_dest] spawn{
		params["_chopper","_dest"];
		sleep 30;
		_chopper action ["useWeapon",_chopper,driver _chopper,1];
		sleep 5;
		_chopper action ["useWeapon",_chopper,driver _chopper,1];
		sleep 3;
		_chopper action ["useWeapon",_chopper,driver _chopper,1];
		sleep 13;
		_chopper action ["useWeapon",_chopper,driver _chopper,1];
		sleep 5;
		_chopper action ["useWeapon",_chopper,driver _chopper,1];
		sleep 3;
		"SmokeShellYellow" createVehicle  _dest; 
		_chopper action ["useWeapon",_chopper,driver _chopper,1];
	};

	// Start spawning troops
	_grp = createGroup SIDE_FRIENDLY;
	_anims = ["WATCH","WATCH2"] ;
	_spawnpos = [_dest, 18, 30, 10, 0, .77, 0] call BIS_fnc_findSafePos;
	_compoObjs = [_spawnpos,90, compo_startup ] call BIS_fnc_objectsMapper;
	_officerPos = _spawnpos;
	{
		if (_x isKindOf "ReammoBox_F") then {
			_x remoteExec ["DCW_fnc_spawncrate",0,true];
		};
	} foreach _compoObjs; 

	for "_j" from 1 to 6 do {
		_pos = [_dest, 18, 30, 0.5, 0, .77, 0] call BIS_fnc_findSafePos;
		_unitName = FRIENDLY_LIST_UNITS call BIS_fnc_selectRandom;
		_unit = _grp createUnit [_unitName, _pos,[],AI_SKILLS,"NONE"];
		_unit setDir (180 - ([_unit,_compoObjs select 0 ] call BIS_fnc_dirTo));
		[_unit] joinsilent _grp;
		_unit allowDamage false;
		
		if (_j == 1) then {
			_unit remoteExec ["DCW_fnc_addActionInstructor",0, true];
			[_unit, "BRIEFING_POINT_LEFT", "MEDIUM"] remoteExec ["BIS_fnc_ambientAnim"];
			_unit enableDynamicSimulation false;
			_officerPos set [0,(_officerPos select 0) + 2];
			_officerPos set [1,(_officerPos select 1) + 2];
			_unit setPos _officerPos;
			_unit setDir 240;
		} else{
			_unit enableDynamicSimulation false;
			if (count _anims > 0) then {
				_anim = _anims call BIS_fnc_selectrandom;
				[_unit, _anim, "FULL"] remoteExec ["BIS_fnc_ambientAnim"];
				_anims = _anims -  [_anim];
			} else{
				[_unit,["Acts_SupportTeam_Back_KneelLoop","Acts_SupportTeam_Front_KneelLoop","Acts_SupportTeam_Right_KneelLoop"] call BIS_fnc_selectrandom] remoteExec ["switchMove"];
			};
		};
	};


	// Fill up all game crate
	_ammobox = missionNamespace getVariable ["ammoBox",objNull];
	if (!isNull _ammobox) then {
		_ammobox remoteExec ["DCW_fnc_spawncrate",0,true];
	};

	for "_i" from 1 to 10  do {
		_ammobox = missionNamespace getVariable [format["ammoBox_%1",str _i],objNull];
		if (!isNull _ammobox) then {
			_ammobox remoteExec ["DCW_fnc_spawncrate",0,true];
		};
	};
};

// Wait the process executed async is markAsFinished
waitUntil {count CLUSTERS > 0};

MARKERS = [CLUSTERS] call DCW_fnc_fillClusters;


[] call DCW_fnc_camp;
[] call DCW_fnc_supportInit; // Support ui init

// Random spawning function decoupled from the compounds
[] spawn DCW_fnc_spawnCrashSite; 
[] spawn DCW_fnc_spawnSecondaryObjective; 
[] spawn DCW_fnc_spawnMainObjective;
[] call DCW_fnc_refreshMarkerStats; // Refresh marker stats
[] spawn DCW_fnc_spawnSheep;
[] spawn DCW_fnc_spawnRandomEnemies;
[] spawn DCW_fnc_spawnRandomCar;
[] spawn DCW_fnc_spawnRandomCivilian;
[] spawn DCW_fnc_spawnChopper;
[] spawn DCW_fnc_spawnTank;


// Revive friendlies with chopper pick up
if (MEDEVAC_ENABLED) then{
	[GROUP_PLAYERS] spawn DCW_fnc_medicalInit;
};

private ["_mkr","_cacheResult","_ieds"];

[] spawn {
	while {true} do {
		if (DEBUG) then {
			{
				//Update marker position
				_mkr = _x getVariable["marker",""];
				if (_mkr!="")then{
					_mkr setMarkerPos (getPos _x);
					if (!alive _x) then{
						_x call DCW_fnc_deleteMarker;
					}
				};
			} foreach allUnits ; //UNITS_SPAWNED_CLOSE + ESCORT + CONVOY + UNITS_SPAWNED_DISTANT;
		};

		_tmp = [];
		{
			//Update marker position
			_mkr = _x getVariable["marker",""];
			if (_mkr != "" && getMarkerColor _mkr  != "") then {
				_tmp pushBackUnique _mkr;
				_mkr setMarkerPos (getPos _x);
			};
			sleep .2;
		} foreach ([] call DCW_fnc_allPlayers);
		PLAYER_MARKER_LIST = _tmp;
		sleep 1;
	};
};

[] call DCW_fnc_spawnLoop;