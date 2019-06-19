/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Base server executed code
 */


if (!isServer) exitWith{};


MARKERS = [];
publicVariableServer "MARKERS";

// Server scope public variable
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
STAT_POP_CURRENT = 0;
STAT_SUPPORT_START = 0;
STAT_SUPPORT = 0;
STAT_COMPOUND_TOTAL = 0;
STAT_COMPOUND_SECURED = 0;
STAT_COMPOUND_BASTION = 0;
STAT_COMPOUND_MASSACRED = 0;

{  if (_x find "blacklist_" == 0 || _x find "marker_base" == 0 ) then { MARKER_WHITE_LIST pushback _x }; }foreach allMapMarkers; 
publicVariable "MARKER_WHITE_LIST";


_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
_gameZoneSize = [_worldSize/2,_worldSize/2];


GAME_ZONE = createMarker ["gamezone", _worldCenter];
GAME_ZONE setMarkerShape "RECTANGLE";
GAME_ZONE setMarkerAlpha 0.2;
GAME_ZONE setMarkerColor "ColorGreen";
GAME_ZONE setMarkerSize [_worldSize/2,_worldSize/2];

{  if (_x find "game_zone" == 0  ) then { GAME_ZONE = _x; _gameZoneSize = getMarkerSize _x; }; }foreach allMapMarkers; 


// Create a marker all around the terrain if it's a ground
{
	_i = _x select 0;
	_j = _x select 1;

	private _mp = createMarker [format["edge-map-%1-%2",str _i, str _j],[ (_i  * (_gameZoneSize select 0))   ,(_j * (_gameZoneSize select 1)) ,0] ];
	_mp setMarkerShape "RECTANGLE";
	_mp setMarkerAlpha 0.1;
	_mp setMarkerColor "ColorRed";
	_mp setMarkerSize _gameZoneSize;
	MARKER_WHITE_LIST pushBack _mp;
} forEach [[-1,-1],[-1,1],[-1,3],[3,-1],[3,1],[3,3],[1,3],[1,-1]];
publicVariable "MARKER_WHITE_LIST";

//Consuming work => getAllClusters
private _clusters = [GAME_ZONE] call fnc_GetClusters;

//On civilian killed
CIVILIAN_KILLED = { 
	params["_unit","_killer"]; 
	hint format ["%1 %2 was killed by %3",name (_unit),side _unit,name (_killer)];
	[_unit,-4] remoteExec ["fnc_UpdateRep",2];
	[GROUP_PLAYERS,-50,false,_killer] call fnc_updateScore;
};

//On enemy killed => 2 points
ENEMY_KILLED = {
	params["_type","_unit"]; 
	[GROUP_PLAYERS, 10,true] call fnc_updateScore;
 };


//If civilian is healed by player
CIVIL_HEALED = { 
	[GROUP_PLAYERS,30,false,(leader GROUP_PLAYERS)] call fnc_updateScore;
 };

//If civil is captured
 CIVIL_CAPTURED = { 
	//[GROUP_PLAYERS,-5] call fnc_updateScore;
 };

// If player is killed
 PLAYER_KIA = { 
	[GROUP_PLAYERS,-20,false,(leader GROUP_PLAYERS)] call fnc_updateScore;
 };

//On enemy search.
ENEMY_SEARCHED = {
	params["_unit","_player"];
	[GROUP_PLAYERS, 2 + ceil (random 10),false,_player] call fnc_updateScore;
};


WAITUNTIL {DCW_STARTED;};

// Start spawning troops
_dest = START_POSITION;
_grp = createGroup SIDE_FRIENDLY;
_anims = ["WATCH","WATCH2"] ;
_spawnpos = [_dest, 18, 30, 10, 0, .77, 0] call BIS_fnc_findSafePos;
_compoObjs = [_spawnpos,90, compo_startup ] call BIS_fnc_objectsMapper;
_officerPos = _spawnpos;
{
	if (_x isKindOf "ReammoBox_F") then {
		_x call fnc_spawncrate;
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
		_unit call addActionInstructor;
		[_unit, "GUARD", "LIGHT"] remoteExec ["BIS_fnc_ambientAnim"];
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
	_ammobox call fnc_spawncrate;
};
for "_i" from 1 to 10  do {
	_ammobox = missionNamespace getVariable [format["ammoBox_%1",str _i],objNull];
	if (!isNull _ammobox) then {
		_ammobox call fnc_spawncrate;
	};
};

//TIME
setDate [2018, 6, 25, TIME_OF_DAYS, 0]; 

//OVERCAST
0 setOvercast WEATHER;
0 setRain (if (WEATHER > .7) then {random 1}else{0});
//setWind [10*WEATHER, 10*WEATHER, true];
0 setFog [if (WEATHER > .8) then {.15}else{0},if (WEATHER > .8) then {.04}else{0}, 60];
0 setGusts (WEATHER - .3);
0 setWaves WEATHER;
forceWeatherChange;


_popbase = 0;
_nbFriendlies = 0;
_nbCars = 0;
_nbFriendlies = 0;
_nbCivilian = 0;
_points = 0;
_nbSnipers = 0;
_nbMortars = 0;
_typeObj = "";
_compoundState = "neutral";
_supportScore = 0;

{
	_return = false;
	_pos = _x select 0;
	_radius = _x select 1;
	_nbBuildings = _x select 2;
	_isLocation = _x select 3;
	_nameLocation = _x select 4;
	_isMilitary = _x select 5;
	_buildings = _x select 6;

	// If in white list exit loop
	{ 
		if(_pos inArea _x)exitWith{_return = true;};
	} foreach MARKER_WHITE_LIST;
	if (isNil{_return})then{_return = false;};
	if (!_return)then
	{

		//Création du marker
		_m = createMarker [format ["dcw-cluster-%1",random 100000],_pos];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerSize [_radius,_radius];
		_m setMarkerColor "ColorRed";
		
		_secured = false;

		if (_isMilitary) then{
			_secured = true;
			MARKER_WHITE_LIST pushback _m;
			_m setMarkerColor "ColorGreen";
		};

		/*if (!_isMilitary) then{
			_m setMarkerBrush "FDiagonal";
		};
		if (_isLocation && !_isMilitary) then{
			_m setMarkerBrush "BDiagonal";
		};*/
		
		_m setMarkerBrush "Solid";

		if (SHOW_SECTOR || DEBUG) then{
			_m setMarkerAlpha .5;
		}else{
			_m setMarkerAlpha 0;
		};
			
		_icon = createMarker [format["%1-icon", _m], _pos];
		_icon setMarkerShape "ICON";
		_icon setMarkerColor "ColorBlack";
		_icon setMarkerSize [1,1];
		_icon setMarkerType "loc_Cross";
							

		// default = startup state / corrupted / secured / succeeded / massacred = destroyed compound / helped = called the humanitary
		_compoundState = "neutral";
		_supportScore = 50;
		_respawnId = [];

		if (_secured) then{
			_supportScore = 100;
			_compoundState = "secured";
			_m setMarkerColor "ColorGreen";
			_icon setMarkerColor "ColorGreen";
			_icon setMarkerType "loc_Ruin";
			_respawnId = [SIDE_FRIENDLY, _pos, _nameLocation] call BIS_fnc_addRespawnPosition
		}else{
			if (_forEachIndex >= (100-PERCENTAGE_OF_ENEMY_COMPOUND)/100*count _clusters) then {
				_supportScore = floor (random 25);
				_compoundState = "bastion";
				_m setMarkerColor "ColorRed";
				_icon setMarkerColor "ColorRed";
				_icon setMarkerType "loc_Ruin";
			}else {
				if (_forEachIndex > 5/100*count _clusters) then {
					_supportScore = 50 + ([1,-1] call BIS_fnc_selectRandom) * (floor (random 25));
					_compoundState = "neutral";
					_m setMarkerColor "ColorWhite";
					_icon setMarkerColor "ColorBlack";
					_icon setMarkerType "loc_tourism";
				}else {
					if (_forEachIndex > 2/100*count _clusters) then {
						_supportScore = 50 + ([1,-1] call BIS_fnc_selectRandom) * (floor (random 25));
						_compoundState = "humanitary";
						_m setMarkerColor "ColorBlue";
						_icon setMarkerColor "ColorBlue";
						_icon setMarkerType "loc_Hospital";
					} else {
						if (_forEachIndex <= 2/100*count _clusters) then {
							_supportScore = 70 + (floor (random 25));
							_compoundState = "supporting";
							_m setMarkerColor "ColorGreen";
							_m setMarkerBrush "FDiagonal";
							_icon setMarkerColor "ColorGreen";
							_icon setMarkerType "loc_tourism";
						};
					};
				};
			};
		};

		_defendTaskState = "none";
		if (_foreachIndex <  30/100*count _clusters && _nbBuildings >= 2) then {
			_defendTaskState = "planned";
			if (DEBUG) then {
				_m setMarkerBrush "FDiagonal";
			};
		};

		_primaryIntel = "none";
		if (_foreachIndex >  75/100*count _clusters && _foreachIndex <=  90/100*count _clusters) then {
			_primaryIntel = "torture";
			if (DEBUG) then {
				_m setMarkerBrush "BDiagonal";
			};
		};
		
		if (_foreachIndex >  90/100*count _clusters) then {
			_primaryIntel = "hasintel";
			if (DEBUG) then {
				_m setMarkerBrush "BDiagonal";
			};
		};
		

		//Nb units to spawn per block
		_popbase = 1 MAX (MAX_POPULATION MIN (ceil( (POPULATION_INTENSITY * _nbBuildings * RATIO_POPULATION)  + (round random 1))));
		_nbEnemies = 0;
		_nbCivilian = 0;

		for "_x" from 1 to _popbase  do
		{
			_rnd = random 100;
			if ((_rnd < PERCENTAGE_CIVILIAN && !_isMilitary) || _compoundState != "bastion") then {
				_nbCivilian = _nbCivilian + 1;
			}else{
				_nbEnemies = _nbEnemies + 1;
			}
		};

		_nbEnemies = if (_compoundState == "bastion") then { (1 max _nbEnemies) } else { 0 };
		_nbCivilian = 1 max _nbCivilian; // At least one civilian per compound at start
		_nbFriendlies = if (_compoundState == "secured") then { ceil (1.3*_popbase) } else { 0 };

		_nbCars = ([0,1] call BIS_fnc_selectRandom) MAX (6 MIN (floor((_nbBuildings)*(RATIO_CARS))));
		_nbIeds = (floor(_popbase * .25) + floor(random 2));

		_typeObj = ["hostage","sniper","cache","mortar","",""] call BIS_fnc_selectRandom;
		_nbHostages = if (_typeObj == "hostage" || _popbase > 14) then{ 1 }else {0};
		_nbSnipers = if (_typeObj == "sniper") then{ 2 } else{ 0 };
		_nbCaches = if (_typeObj == "cache" || _popbase > 14) then{ 1 }else {0};
		_nbMortars = if (_typeObj == "mortar") then{ 1 }else {0};

		_nbOutpost = [0,0,1] call BIS_fnc_selectRandom; 
		_points = 1 + _nbEnemies * 10;
		_meetingPointPosition =  [getPos (_buildings call BIS_fnc_selectRandom), 0, 15, 4, 0, 1, 0] call BIS_fnc_findSafePos;
		while {isOnRoad _meetingPointPosition} do{
			_meetingPointPosition =  [_pos, 0, .67*_radius, 4, 0, 1, 0] call BIS_fnc_findSafePos;
		};

		STAT_COMPOUND_TOTAL = STAT_COMPOUND_TOTAL + 1;

		if (DEBUG) then {
			/*_marker = createMarker [format["%1-debug", _m], _pos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerAlpha 0.3;
			_marker setMarkerColor "ColorBlack";
			_icon setMarkerText  format["support:%1|%2", _supportScore,_nameLocation];*/
			//_marker setMarkerText  format["civ:%1/en:%2/Car:%3/bld:%4/ca:%5/mr:%6",_nbCivilian,_nbEnemies,_nbCars,_nbBuildings,_nbCaches,_nbMortars];
		};

		_peopleToSpawn = [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies];

		MARKERS pushBack  [_m,_pos,false,_secured,_radius,[],_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary,_buildings,_compoundState,_supportScore,_nameLocation,_respawnId,_defendTaskState,_primaryIntel, [0,0,0,0,0,0,0,0,0,0]];
	};
	
} foreach (_clusters call BIS_fnc_arrayShuffle);


[] call fnc_camp;

[] execVM "DCW\fnc\spawn\SpawnSheep.sqf"; //Sheep herds spawn
[] execVM "DCW\fnc\spawn\SpawnRandomEnemies.sqf"; //Enemy patrols
[] execVM "DCW\fnc\spawn\SpawnRandomCar.sqf"; //Civil & enemy cars
[] execVM "DCW\fnc\spawn\SpawnRandomCivilian.sqf"; //Civilians walking around
[] execVM "DCW\fnc\spawn\SpawnChopper.sqf"; //Chopper spawn
[] execVM "DCW\fnc\spawn\SpawnTank.sqf"; //Tanks
[] spawn fnc_SpawnCrashSite; //Chopper spawn
[] spawn fnc_SpawnSecondaryObjective;
[] spawn fnc_SpawnMainObjective;
[] call fnc_refreshMarkerStats;

// Revive friendlies with chopper pick up
if (MEDEVAC_ENABLED) then{
	[GROUP_PLAYERS] execVM "DCW\medevac\init.sqf";
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
						_x call fnc_deleteMarker;
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
		} foreach allPlayers;
		PLAYER_MARKER_LIST = _tmp;
		sleep 1;
	};
};

// Wait until this var is on
waitUntil {count allPlayers > 0};

// Initial timer for the hunters
_timerChaser = time - 360;
_tmpRep = 50;
_currentMarker = [];

while { true } do {

	// foreach players
	{
		_player = _x;

		_playerPos = position _player;
		_playerInMarker = false;
		
		if (!isNil '_playerPos' && alive _x) then{

			_nbUnitSpawned = count UNITS_SPAWNED_CLOSE;

			//Catch flying player
			_isInFlyingVehicle = false;
			if( (vehicle _player) != _player && ((vehicle _player) isKindOf "Air" && (_playerPos select 2) > 4))then{
				_isInFlyingVehicle = true;
			};

			_xC = floor((_playerPos select 0)/SIZE_BLOCK);
			_yC = floor((_playerPos select 1)/SIZE_BLOCK);
			_o = 4;

			// foreach markers
			IN_MARKERS_LOOP = true;
			{
				_currentCompound = _x;
				_marker =_x select 0;
				_pos =_x select 1;
				_triggered =_x select 2;
				_success =_x select 3;
				_radius =_x select 4;
				_units =_x select 5;
				_peopleToSpawn =_x select 6;
				_meetingPointPosition = _x select 7;
				_points =_x select 8;
				_isLocation = _x select 9;
				_isMilitary = _x select 10;
				_buildings = _x select 11;
				_compoundState = _x select 12;
				_supportScore = _x select 13;
				_nameLocation = _x select 14;
				_respawnId = _x select 15;
				_defendTaskState = _x select 16;
				_primaryIntel = _x select 17;
				_notSpawnedArray = _x select 18;

				if (_triggered && _playerPos distance _pos < _radius ) then {
					_currentMarker = _x;
					_playerInMarker = true;
					[format["<t color='#cd8700'  >%1</t><br/>Inhabitants: %2<br/>State: %3<br/>Population support: <t >%4%/100</t><br/>",_nameLocation,(_peopleToSpawn select 0) + (_peopleToSpawn select 2),_compoundState,_supportScore], 40] remoteExec ["fnc_ShowIndicator",_player,false];
			
					if (_defendTaskState == "planned" && (_compoundState == "neutral" || _compoundState == "supporting")  ) then {
						[_currentCompound,_player] spawn {
							params["_compound"];
							sleep 30;
							[_compound] call fnc_spawnDefendTask;
						};
						_defendTaskState = "done";
					};
				};

				if (!_triggered && !_isInFlyingVehicle && _playerPos distance _pos < SPAWN_DISTANCE && (!_isInFlyingVehicle && _playerPos distance _pos >= _radius)) then{
					
					if (_nbUnitSpawned < MAX_SPAWNED_UNITS)then{

						//Véhicles spawn
						_units = _units + ([_pos,_radius,(_peopleToSpawn select 3),_compoundState] call fnc_SpawnCars);
						
						//Units
						_units = _units + ([_pos,_radius,_success,_peopleToSpawn,_meetingPointPosition,_buildings,_compoundState,_supportScore] call fnc_SpawnUnits);
						
						//Meeting points
						_units = _units + ([_meetingPointPosition] call fnc_SpawnMeetingPoint);
						
						//Spawn random composition
						_units = _units + ([_pos,_buildings,_success,_compoundState] call fnc_spawnobjects);

						if (_compoundState == "secured")  then {	
							//Units
							_units = _units + ([_pos,_radius,_peopleToSpawn select 9,_meetingPointPosition,_buildings] call fnc_SpawnFriendlyOutpost);
						} else {
							_notSpawnedArray set [9,_peopleToSpawn select 9] ;
						};

						if (_compoundState == "humanitary") then {
							//Units
							_units = _units + ([_pos,_radius,_peopleToSpawn select 0,_meetingPointPosition,_buildings] call fnc_SpawnHumanitaryOutpost);
						};

						if (_compoundState != "secured" && _compoundState != "humanitary") then {
							//IEDs
							_units = _units +  ([_pos,_radius,(_peopleToSpawn select 4)] call fnc_spawnIED);
						} else {
							_notSpawnedArray set [4,_peopleToSpawn select 4] ;
						};
						
						if (_compoundState == "bastion" || (_compoundState == "neutral" && _supportScore < 45)) then {
							//Snipers spawn
							_units = _units + ([_pos,_radius,(_peopleToSpawn select 2)] call fnc_spawnsnipers);
							//Cache
							_units = _units + ([_pos,_radius,(_peopleToSpawn select 5),_buildings] call fnc_cache);
							//Hostages
							_units = _units + ([_pos,_radius,(_peopleToSpawn select 6),_buildings] call fnc_hostage);
							//Mortars
							_units = _units + ([_pos,_radius,(_peopleToSpawn select 7)] call fnc_SpawnMortar);
						} else {
							_notSpawnedArray set [2,_peopleToSpawn select 2] ;
							_notSpawnedArray set [5,_peopleToSpawn select 5] ;
							_notSpawnedArray set [6,_peopleToSpawn select 6] ;
							_notSpawnedArray set [7,_peopleToSpawn select 7] ;
						};

						if (_compoundState == "bastion" ) then {
							//Outposts
							_units = _units + ([_marker,(_peopleToSpawn select 8)] call fnc_SpawnOutpost);
						} else {
							_notSpawnedArray set [8,_peopleToSpawn select 8] ;
						};

						_triggered = true;

						//Add a little breath
						sleep 1;
					};


				}else{
					//Gestion du cache
					if(_playerPos distance _pos > (SPAWN_DISTANCE + 150) && _triggered)then {
						_cacheResult = [_units,_notSpawnedArray] call fnc_CachePut;
						_peopleToSpawn = _cacheResult select 0;
						_units = _units - [_cacheResult select 1];
						_triggered = false;
					} else {

						// Check if enemies remains in the area;
						if (_triggered && !_success && _compoundState == "bastion") then{
							if ([_playerPos, _marker] call fnc_isInMarker) then{
								_enemyInMarker = true;
								if ({side _x == SIDE_ENEMY && !(captive _x) && alive _x && [getPos _x, _marker] call fnc_isInMarker  } count allUnits <= floor (0.2 * (_peopleToSpawn select 2))) then {
									_enemyInMarker = false;
								};
								//Cleared success
								if (!_enemyInMarker)then {
									_success = true;
									[_currentCompound,"neutral"] spawn fnc_setCompoundState;
									[_currentCompound,35 + (ceil random 20),0] spawn fnc_setCompoundSupport;				

									//Misa à jour de l'amitié
									[GROUP_PLAYERS,_points,false,(leader GROUP_PLAYERS)] call fnc_updateScore;

									[_player,"The compound is clear ! Great job team.", true] remoteExec ["fnc_talk"];
								};

							};
						};
					};
				}; 
				MARKERS set [_forEachIndex,[_marker,_pos,_triggered,_success,_radius,_units,_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary,_buildings,_compoundState,_supportScore,_nameLocation,_respawnId,_defendTaskState,_primaryIntel,_notSpawnedArray]]; 
			} foreach MARKERS select { (_x select 3) || ((_x select 4) <= (_xC + _o) && (_x select 4) >= (_xC - _o) && (_x select 5) <= (_yC + _o) && (_x select 5) >= (_yC - _o)) };
			IN_MARKERS_LOOP = false;
		};
		sleep 1;

		if (!_playerInMarker) then {
			_currentMarker = [];
			["",0] remoteExec ["fnc_ShowIndicator",_player,false];
		};

	} foreach allPlayers;

		/*_civilReputationSum = 0;
		_civilReputationNb = 0;*/

		// foreach UNITS_SPAWNED_CLOSE
		{
			_unit = _x;


			//Empty the killed units
			if (!alive _unit)then{
				_unit call fnc_deletemarker;
				UNITS_SPAWNED_CLOSE = UNITS_SPAWNED_CLOSE - [_unit];
			};
			
			// foreach players
			{
				if (CHASER_TRIGGERED) then {
				   _timerChaser = time;
				};

				

				//Detection
				if (!CHASER_TRIGGERED && !CHASER_VIEWED && side _unit == SIDE_ENEMY && _unit knowsAbout _x > 1 && !(_x getVariable["DCW_undercover",false]) ) then 
				{
					[_unit,_x,_timerChaser] spawn {
						params["_unit","_player","_timerChaser"];
						CHASER_VIEWED = true;
						sleep (15 + random 5);
						CHASER_VIEWED = false;
						[] remoteExec ["fnc_DisplayScore",_player, false];
						// || _unit knowsAbout player > 2
						if ( alive _unit && !CHASER_TRIGGERED &&  ([_unit,_player] call fnc_GetVisibility > 20))then{
							if (DEBUG) then  {
								hint "Alarm !";
							};
							
							// playMusic (["LeadTrack04a_F","LeadTrack04_F"] call BIS_fnc_selectRandom);
							
							CHASER_TRIGGERED = true;
							publicVariable "CHASER_TRIGGERED";
							
							//Chasers
							if (CHASER_TRIGGERED && time > (_timerChaser + 20))then{
								_timerChaser = time - 1;
								UNITS_SPAWNED_CLOSE = UNITS_SPAWNED_CLOSE + ([_player] call fnc_SpawnChaser);
							};
							
							[] remoteExec ["fnc_DisplayScore",_player, false];
							[_player] spawn {
								params["_player"];
								sleep 250;
								if (DEBUG) then  {
									hint "Alarm off!";
								};
								sleep 200;
								CHASER_TRIGGERED = false;
								publicVariable "CHASER_TRIGGERED";
								[] remoteExec ["fnc_DisplayScore",_player, false];
							};
						};
					};
				};


				
				

			} foreach allPlayers;

			// Regulate the spawn distance
			if (count UNITS_SPAWNED_CLOSE > MAX_SPAWNED_UNITS) then {
				SPAWN_DISTANCE = 0.75 * INITIAL_SPAWN_DISTANCE max (SPAWN_DISTANCE - 10);
			} else {
				SPAWN_DISTANCE = INITIAL_SPAWN_DISTANCE min (SPAWN_DISTANCE + 10);
			};

			// Garbage collection
			if (_unit getVariable["DCW_Type",""] == "patrol" || _unit getVariable["DCW_Type",""] == "chaser" || _unit getVariable["DCW_Type",""] == "civpatrol")then{
				if ({_unit distance _x > SPAWN_DISTANCE + 230} count allPlayers == count allPlayers)then {
					UNITS_SPAWNED_CLOSE = UNITS_SPAWNED_CLOSE - [_unit];
					 // If it's a vehicle
					if (vehicle _unit != _unit) then {
						{ _x call fnc_deletemarker; deletevehicle _x; } foreach crew _unit;
					};
					_unit call fnc_deleteMarker;
					deleteVehicle _unit;
				};
			};


		} foreach UNITS_SPAWNED_CLOSE;
	




	sleep REFRESH_TIME;
};