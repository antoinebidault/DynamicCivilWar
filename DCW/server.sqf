/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


if (!isServer) exitWith{};


// Create a fake HQ unit
"B_RangeMaster_F" createUnit [[-1000,-1000], createGroup SIDE_CURRENT_PLAYER, "this allowDamage false; HQ = this; ", 0.6, "colonel"];
[]spawn{
	sleep 1;
	HQ setName "HQ";
};

// Variable in Global scope
GAME_ZONE_SIZE=5000;
MARKER_WHITE_LIST = []; //Pass list of marker white list name
publicVariable "MARKER_WHITE_LIST";

PLAYER_MARKER_LIST = []; //Pass list of marker white list name
UNITS_SPAWNED = [];
INTELS = [];
UNITS_CACHED = [];
MARKERS = [];
SHEEP_POOL = [];
UNITS_CHASERS = [];
MESS_SHOWN = false;
LAST_FLARE_TIME = time;
REFRESH_TIME = 10; // Refresh time
WEATHER = .5;
CONVOY = []; // Current convoy
ESCORT = []; // List of escorts guys with the commandant

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
	_friends = nearestObjects [position _unit,["Man"],50];
	{  if (side _x == CIV_SIDE) then { [_x,-4] call fnc_UpdateRep}; }foreach _friends;
	[GROUP_PLAYERS,-50,false,_killer] call fnc_updateScore;
};

//On enemy killed => 2 points
ENEMY_KILLED = {
	params["_type","_unit"]; 
	[GROUP_PLAYERS, 10,true] call fnc_updateScore;
 };

//On compound secured
COMPOUND_SECURED = { 
	params["_marker","_radius","_units","_points"]; 

	//Misa à jour de l'amitié
	{  if (side _x == CIV_SIDE && _x getVariable["DCW_Friendliness",-1] != -1) then { [_x,6] call fnc_UpdateRep;}; }foreach _units;
	[GROUP_PLAYERS,_points,false,(leader GROUP_PLAYERS)] call fnc_updateScore;
};

//On success
OBJECTIVE_ACCOMPLISHED = { 
	params["_type","_unit","_bonus"]; 
	if (_bonus > 0) then{
		[GROUP_PLAYERS,_bonus,false,_unit] call fnc_updateScore;
	};
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

_ammobox = missionNamespace getVariable ["ammoBox",objNull];
if (!isNull _ammobox) then {
	_ammobox call fnc_spawncrate;
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



private _popbase = 0;
private _nbFriendlies = 0;
private _nbCars = 0;
private _nbFriendlies = 0;
private _nbCivilian = 0;
private _points = 0;
private _nbSnipers = 0;
private _nbMortars = 0;
private _typeObj = "";

{
	private _return = false;
	private _pos = _x select 0;
	private _radius = _x select 1;
	private _nbBuildings = _x select 2;
	private _isLocation = _x select 3;
	private _nameLocation = _x select 4;
	private _isMilitary = _x select 5;
	private _buildings = _x select 6;

	// If in white list exit loop
	{ 
		if(_pos inArea _x)exitWith{_return = true;};
	} foreach MARKER_WHITE_LIST;
	if (isNil{_return})then{_return = false;};
	if (!_return)then
	{

		//Création du marker
		_m = createMarker [format ["mrk%1",random 100000],_pos];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerSize [_radius,_radius];
		_m setMarkerColor "ColorRed";
		
		_secured = false;

		if (_isMilitary) then{
			_secured = true;
			_m setMarkerColor "ColorGreen";
		};

		if (!_isMilitary) then{
			_m setMarkerBrush "FDiagonal";
		};
		if (_isLocation && !_isMilitary) then{
			_m setMarkerBrush "BDiagonal";
		};

		if (SHOW_SECTOR || DEBUG) then{
			_m setMarkerAlpha .5;
		}else{
			_m setMarkerAlpha 0;
		};

		//Nb units to spawn per block
		_popbase = 1 MAX (MAX_POPULATION MIN (ceil( (POPULATION_INTENSITY * _nbBuildings* RATIO_POPULATION)  + (round random 1))));
		_nbEnemies = 0;
		_nbCivilian = 0;
		for "_x" from 1 to _popbase  do
		{
			_rnd = random 100;
			if (_rnd < PERCENTAGE_CIVILIAN && !_isMilitary) then{
				_nbCivilian = _nbCivilian + 1;
			}else{
				_nbEnemies = _nbEnemies + 1;
			}
		};
		_nbFriendlies =  ceil (_popbase * (PERCENTAGE_CIVILIAN/100));
		_nbCars = ([0,1] call BIS_fnc_selectRandom) MAX (6 MIN (floor((_nbBuildings)*(RATIO_CARS))));
		_nbIeds = (floor(_popbase * .25) + floor(random 2));

		_typeObj = ["hostage","sniper","cache","mortar","","",""] call BIS_fnc_selectRandom;
		_nbHostages = if (_typeObj == "hostage" || _popbase > 20) then{ 1 }else {0};
		_nbSnipers = if (_typeObj == "sniper") then{ 2 } else{ 0 };
		_nbCaches = if (_typeObj == "cache" || _popbase > 20) then{ 1 }else {0};
		_nbMortars = if (_typeObj == "mortar") then{ 1 }else {0};

		_nbOutpost = [0,0,1] call BIS_fnc_selectRandom; 
		_nbFriendlies = 0;
		_points = 1 + _nbEnemies * 10;
		_meetingPointPosition =  [_pos, 0, .5*_radius, 4, 0, 1, 0] call BIS_fnc_FindSafePos;
		while {isOnRoad _meetingPointPosition} do{
			_meetingPointPosition =  [_pos, 0, .67*_radius, 4, 0, 1, 0] call BIS_fnc_FindSafePos;
		};


		if (DEBUG) then {
			_marker = createMarker [format["body-%1", random 10000], _pos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerAlpha 0.3;
			_marker setMarkerColor "ColorRed";
			_marker setMarkerText  format["civ:%1/en:%2/Car:%3/bld:%4/ca:%5/mr:%6",_nbCivilian,_nbEnemies,_nbCars,_nbBuildings,_nbCaches,_nbMortars];
		};

		_peopleToSpawn = [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies];
		MARKERS pushBack  [_m,_pos,false,_secured,_radius,[],_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary,_buildings];
	};
	
} foreach _clusters;

[] call fnc_PrepareAction;
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
[390] spawn fnc_SpawnConvoy;

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
			} foreach UNITS_SPAWNED + ESCORT + CONVOY;

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
				   
while { true } do {

	// foreach players
	{
		_player = _x;

		_playerPos = position _player;
		
		if (!isNil '_playerPos' && alive _x) then{

			_nbUnitSpawned = count UNITS_SPAWNED;

			//Catch flying player
			_isInFlyingVehicle = false;
			if( (vehicle _player) != _player && ((vehicle _player) isKindOf "Air" && (_playerPos select 2) > 4))then{
				_isInFlyingVehicle = true;
			};

			_xC = floor((_playerPos select 0)/SIZE_BLOCK);
			_yC = floor((_playerPos select 1)/SIZE_BLOCK);
			_o = 4;

			// foreach markers
			{
				private _marker =_x select 0;
				private _pos =_x select 1;
				private _triggered =_x select 2;
				private _success =_x select 3;
				private _radius =_x select 4;
				private _units =_x select 5;
				private _peopleToSpawn =_x select 6;
				private _meetingPointPosition =_x select 7;
				private _points =_x select 8;
				private _isLocation = _x select 9;
				private _isMilitary = _x select 10;
				private _buildings = _x select 11;

				if (!_triggered && !_isInFlyingVehicle && _playerPos distance _pos < SPAWN_DISTANCE) then{
				
					if (_nbUnitSpawned < MAX_SPAWNED_UNITS)then{

						//Véhicles spawn
						_units = _units +  ([_pos,_radius,(_peopleToSpawn select 3)] call fnc_SpawnCars);
						//Units
						_units = _units + ([_pos,_radius,_success,_peopleToSpawn,_meetingPointPosition,_buildings] call fnc_SpawnUnits);
						//Units
						_units = _units + ([_pos,_radius,_peopleToSpawn select 9,_meetingPointPosition,_buildings] call fnc_SpawnFriendlyOutpost);
						//IEDs
						if (!_isMilitary)then{
							_units = _units +  ([_pos,_radius,(_peopleToSpawn select 4)] call fnc_spawnIED);
						};
						//Outposts
						_units = _units + ([_marker,(_peopleToSpawn select 8)] call fnc_SpawnOutpost);
						//Cache
						_units = _units + ([_pos,_radius,(_peopleToSpawn select 5),_buildings] call fnc_cache);
						//Hostages
						_units = _units + ([_pos,_radius,(_peopleToSpawn select 6),_buildings] call fnc_hostage);
						//Meeting points
						_units = _units + ([_meetingPointPosition] call fnc_SpawnMeetingPoint);
						//Mortars
						_units = _units + ([_pos,_radius,(_peopleToSpawn select 7)] call fnc_SpawnMortar);

						_triggered = true;

						//Add a little breath
						sleep 2;
					};


				}else{

					//Gestion du cache
					if(_playerPos distance _pos > (SPAWN_DISTANCE + 100) && _triggered)then {
						_cacheResult = [_units] call fnc_CachePut;
						_peopleToSpawn = _cacheResult select 0;
						_units = _units - [_cacheResult select 1];
						_triggered = false;
					} else {

						// Check if enemies remains in the area;
						if (_triggered && !_success) then{
							if ([_playerPos, _marker] call fnc_isInMarker) then{
								_nben = 0;
								_enemyInMarker = true;
								if ({side _x == ENEMY_SIDE && alive _x && [getPos _x, _marker] call fnc_isInMarker  } count allUnits <= round (0.1 * (_peopleToSpawn select 2))) then {
									_enemyInMarker = false;
								};
								//Cleared success
								if (!_enemyInMarker)then {
									_success = true;
									[_marker,_radius,_units,_points] remoteExec ["COMPOUND_SECURED"];
									[_player,"This compound is cleared ! Great job.", true] remoteExec ["fnc_talk"];
									_marker setMarkerColor "ColorGreen";
								};

							};
						};
					};
				}; 
				MARKERS set [_forEachIndex,[_marker,_pos,_triggered,_success,_radius,_units,_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary,_buildings]]; 
			}foreach MARKERS select { (_x select 3) || ((_x select 4) <= (_xC + _o) && (_x select 4) >= (_xC - _o) && (_x select 5) <= (_yC + _o) && (_x select 5) >= (_yC - _o)) };
		};
		sleep 1;
	} foreach allPlayers;

		_civilReputationSum = 0;
		_civilReputationNb = 0;

		// foreach UNITS_SPAWNED
		{
			_unit = _x;


			//Empty the killed units
			if (!alive _unit)then{
				_unit call fnc_deletemarker;
				UNITS_SPAWNED = UNITS_SPAWNED - [_unit];
			};
			
			// foreach players
			{
				if (CHASER_TRIGGERED) then {
				   _timerChaser = time;
				};

				//Detection
				if (!CHASER_TRIGGERED && !CHASER_VIEWED && side _unit == ENEMY_SIDE && _unit knowsAbout _x > 1 && !(_x getVariable["DCW_undercover",false]) ) then 
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
								UNITS_SPAWNED = UNITS_SPAWNED + ([_player] call fnc_SpawnChaser);
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

			// Garbage collection
			if (_unit getVariable["DCW_Type",""] == "patrol" || _unit getVariable["DCW_Type",""] == "chaser" || _unit getVariable["DCW_Type",""] == "civpatrol")then{
				if ({_unit distance _x > SPAWN_DISTANCE + 300} count allPlayers == count allPlayers)then {
					UNITS_SPAWNED = UNITS_SPAWNED - [_unit];
					_unit call fnc_deleteMarker;
					deleteVehicle _unit;
				};
			};


			//Calcul du score
			if (_unit getVariable["DCW_Friendliness",-1] != -1) then{
				_civilReputationSum = _civilReputationSum + (_unit getVariable["DCW_Friendliness",-1]);
				_civilReputationNb = _civilReputationNb + 1;
			};

		} foreach UNITS_SPAWNED;
		
		if (_civilReputationNb > 0) then  {
			_tmp = round(_civilReputationSum/_civilReputationNb);
			if (_tmp != CIVIL_REPUTATION) then{
				_diff = (_tmp-CIVIL_REPUTATION);
				[format["REPUTATION %1% <t color='%2'>%3%4pt</t>",_tmp,if(_diff > 0) then {"#29c46c"} else{"#ea4f4f"},if(_diff > 0) then{"+"}else{""},_diff]] remoteExec ["fnc_ShowIndicator",0,false];

				CIVIL_REPUTATION = _tmp;
				publicVariable "CIVIL_REPUTATION";
			};
			CIVIL_REPUTATION = _tmp;
		};




	sleep REFRESH_TIME;
};