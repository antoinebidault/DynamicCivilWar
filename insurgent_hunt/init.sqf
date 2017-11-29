

//SYSTEM
fnc_FactionClasses = compileFinal preprocessFileLineNumbers "insurgent_hunt\fnc\System\FactionClasses.sqf";
fnc_isInMarker= compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\System\isinMarker.sqf";
fnc_findBuildings= compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\System\findBuildings.sqf";
fnc_addMarker = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\System\addMarker.sqf";
fnc_findNearestMarker = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\System\findNearestMarker.sqf";
fnc_CachePut = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\System\CachePut.sqf";
fnc_ShowIndicator = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\System\ShowIndicator.sqf"; 

//SPAWN
fnc_SpawnUnits= compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnUnits.sqf";
fnc_SpawnAsEnemy = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnAsEnemy.sqf";
fnc_spawnchaser = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\spawnchaser.sqf";
fnc_spawnoutpost = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\spawnoutpost.sqf";
fnc_SpawnMeetingPoint = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnMeetingPoint.sqf";
fnc_SpawnCivil =  compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnCivil.sqf";
fnc_SpawnEnemy =  compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnEnemy.sqf";
fnc_SpawnMortar = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnMortar.sqf";
fnc_SpawnCars = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnCars.sqf";
fnc_SpawnMainObjective = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnMainObjective.sqf";
fnc_SpawnPosition = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Spawn\SpawnPosition.sqf";

//PATROL
fnc_Patrol= compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\CompoundPatrol.sqf";
fnc_SimplePatrol= compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\SimplePatrol.sqf";
fnc_LargePatrol = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\LargePatrol.sqf";
fnc_chase = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\chase.sqf";
fnc_carPatrol = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\carPatrol.sqf";
fnc_civilianPatrol = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\civilianPatrol.sqf";
fnc_gotomeeting =  compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Patrol\gotomeeting.sqf";

//OBJECTIVES
fnc_GetIntel = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\GetIntel.sqf";
fnc_ieds = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\ied.sqf";
fnc_cache = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\cache.sqf";
fnc_Hostage = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\hostage.sqf";
fnc_Success = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\Success.sqf";
fnc_failed = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\Failed.sqf";
fnc_createtask =  compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\objective\createtask.sqf";

//CUSTOM BEHAVIOR
fnc_MortarBombing = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\MortarBombing.sqf";
fnc_addtorch = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\addtorch.sqf";
fnc_randomAnimation = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\randomAnimation.sqf";
fnc_UpdateRep =  compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\UpdateRep.sqf";
fnc_LocalChief = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\LocalChief.sqf";
fnc_PrepareAction = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\PrepareAction.sqf"; 
fnc_AddCivilianAction = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\addCivilianAction.sqf";
fnc_shout = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\Shout.sqf";
fnc_BadBuyLoadout = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\BadBuyLoadout.sqf";
fnc_Talk = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Behavior\Talk.sqf";

//HANDLERS
fnc_HandleFiredNear = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Handler\HandleFiredNear.sqf";
fnc_HandleDamaged = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Handler\HandleDamaged.sqf";
fnc_handlekill = compileFinal preprocessFileLineNumbers  "insurgent_hunt\fnc\Handler\HandleKill.sqf";

//composition
compo_camp1 =  call (compileFinal preprocessFileLineNumbers "insurgent_hunt\composition\camp1.sqf");
compo_camp2 =  call (compileFinal preprocessFileLineNumbers "insurgent_hunt\composition\camp2.sqf");
compo_camp3 =  call (compileFinal preprocessFileLineNumbers "insurgent_hunt\composition\camp3.sqf");
compo_camp4 =  call (compileFinal preprocessFileLineNumbers "insurgent_hunt\composition\camp4.sqf");
compo_camp5 =  call (compileFinal preprocessFileLineNumbers "insurgent_hunt\composition\camp5.sqf");
compos = [compo_camp1,compo_camp2,compo_camp3,compo_camp4,compo_camp5];
compo_rest =  call (compileFinal preprocessFileLineNumbers "insurgent_hunt\composition\rest.sqf");


//Global configuration

//GLOBAL
DEBUG = true; //Make all units visible on the map
SHOW_SECTOR = true; //Make every sector colored on the map
SIDE_CURRENT_PLAYER = side player; //Side player
NUMBER_RESPAWN = 3;
CIVIL_REPUTATION = 50;
HQ = [SIDE_CURRENT_PLAYER,"HQ"];  

//SPAWNING CONFIG
SIZE_BLOCK = 350; // Size of blocks
MARKER_WHITE_LIST = ["marker_base"]; //Pass list of marker white list name
SPAWN_DISTANCE = 500 MIN (viewdistance - 350); //Distance uniuts are spawned
MIN_SPAWN_DISTANCE =  150; //Units can't spawn before this distance

//CIVILIAN
CIV_SIDE = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["civ_ref"] call fnc_FactionClasses;
CIV_LIST_CARS = ["civ_ref","Car"] call fnc_FactionClasses;
HUMANITAR_LIST_CARS = ["LOP_UN_Ural","LOP_UN_Offroad","LOP_UN_UAZ"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN = 7;
MAX_SHEEP_HERD = 3; //Number of sheep herd
RATIO_POPULATION = .2; //Number of unit per building. 0.4 default
RATIO_CARS = .02; //Number of empty cars spawned in a city by buidling
PERCENTAGE_CIVILIAN = 65; //Percentage civilian in a block
PERCENTAGE_ENEMIES = 35; //Percentage enemies
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.


//ENEMIES
ENEMY_SIDE = EAST; //Enemy side 
ENEMY_SKILLS = 1; //Skills units
PATROL_SIZE = [1,2]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = 60; //Max units to spawn
MAX_CHASERS = 7; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = 10; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = 2; //Max car spawned.
NUMBER_CHOPPERS = 0; // Number of choppers
ENEMY_LIST_UNITS = ["enemy_ref","Man"] call fnc_FactionClasses;
ENEMY_SNIPER_UNITS = ["sniper_ref","Man",["Sniper","Marksman"]] call fnc_FactionClasses;
ENEMY_LIST_CARS = ["enemy_ref","Car"] call fnc_FactionClasses;
ENEMY_CHOPPERS = ["enemy_chopper_ref","Helicopter"] call fnc_FactionClasses;
ENEMY_ATTACHEDLIGHT_CLASS =  "rhs_acc_2dpZenit"; //default : "acc_flashlight"
ENEMY_MORTAR_CLASS = "B_Mortar_01_F"; //Mortar class
NUMBER_TANKS = 5;
ENEMY_LIST_TANKS = ["LOP_TKA_T55","LOP_TKA_T72BA"]; //Tanks
ENEMY_COMMANDER_CLASS = "LOP_TKA_Infantry_Officer"; //commander
ENEMY_COMMANDER_CAR_CLASS = "LOP_AM_OPF_Nissan_PKM"; //commander
ENEMY_COMMANDER_TRUCK_CLASS = "LOP_TKA_Ural"; //commander


//Variable in Global scope
UNITS_SPAWNED = [];
INTELS = [];
UNITS_CACHED = [];
MARKERS = [];
SHEEP_POOL = [];
UNITS_CHASERS = [];
CHASER_TRIGGERED = false;

//EVENT LIST

CIVILIAN_KILLED = { 
	params["_unit","_killer"]; 
	hint format ["%1 %2 was killed by %3",name (_unit),side _unit,name (_killer)];
	_friends = nearestObjects [position _unit,["Man"],50];
	{  if (side _x == CIV_SIDE) then { [_x,-10] call fnc_UpdateRep}; }foreach _friends;
	[player,-20] call fnc_updateScore;
};

ENEMY_KILLED = {
	params["_type","_unit"]; 
	[player,2,true] call fnc_updateScore;
 };

COMPOUND_SECURED = { 
	params["_marker","_radius","_units","_points"]; 

	//Misa à jour de l'amitié
	{  if (side _x == CIV_SIDE && _x getVariable["IH_friendliness",-1] != -1) then { _x setVariable["IH_friendliness",100];}; }foreach _units;
	[player,_points] call fnc_updateScore;
};

OBJECTIVE_ACCOMPLISHED = { 
	params["_type","_unit"]; 
	_score = _unit getVariable["IH_Bonus",0];
	if (_score != 0) then{
		[player,_score] call fnc_updateScore;
	};
};

CIVIL_HEALED = { 
	params["_civ","_unit"];
	[player,20] call fnc_updateScore;
 };

 CIVIL_CAPTURED = { 
	[player,-5] call fnc_updateScore;
 };

 PLAYER_KIA = { 
	[player,-20] call fnc_updateScore;
 };

 CIVIL_DISRESPECT = { 
	[player,-5] call fnc_updateScore;
 };

ENEMY_SEARCHED = {
	[player,round (random 5)] call fnc_updateScore;
};


private _unitsSpawned = [];
private _worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
private _worldCenter = [_worldSize/2,_worldSize/2,0];
private _worldNbBlocks = floor(_worldSize/SIZE_BLOCK);

//Default white list marker;
private _mp = createMarker ["playerMarker",getPosWorld player ];
_mp setMarkerShape "ELLIPSE";
_mp setMarkerAlpha 0;
_mp setMarkerSize [SIZE_BLOCK,SIZE_BLOCK];
LAST_FLARE_TIME = time;
MARKER_WHITE_LIST pushBack "playerMarker";

[] call fnc_PrepareAction;
[getPosATL(missionNamespace getVariable ["IH_Respawn_Mat", objNull])] execVM "insurgent_hunt\fnc\Spawn\Respawn.sqf"; //Respawn loop
[] execVM "insurgent_hunt\fnc\spawn\SpawnSheep.sqf"; //Sheep herds spawn
[] execVM "insurgent_hunt\fnc\spawn\RandomPatrol.sqf"; //Enemy patrols
[] execVM "insurgent_hunt\fnc\spawn\RandomCar.sqf"; //Civil & enemy cars
[] execVM "insurgent_hunt\fnc\spawn\RandomCivilian.sqf"; //Civilians walking around
[] execVM "insurgent_hunt\fnc\spawn\SpawnChopper.sqf"; //Chopper spawn
[] execVM "insurgent_hunt\fnc\spawn\SpawnTank.sqf"; //Tanks
[] spawn fnc_SpawnMainObjective;

private _ret = false;
for "_xc" from 0 to _worldNbBlocks do {
	for "_yc" from 0 to _worldNbBlocks do {
		_markerPos = [(_xc*SIZE_BLOCK),(_yc*SIZE_BLOCK),0];
		_buildings = [_markerPos, (SIZE_BLOCK/2)] call fnc_findBuildings;
		_return = false;
	    { 
			if([_markerPos,_x] call fnc_isInMarker)exitWith{_return = true;};
		} foreach MARKER_WHITE_LIST;

		if (isNil{_return})then{_return = false;};

		if (count _buildings > 0 && !_return)then{
			private _radius = (SIZE_BLOCK/2) MIN ((count _buildings + 3)*12);
			private _posCenteredOnBuilding = position (_buildings call BIS_fnc_selectrandom);

			//Création du marker
			_m = createMarker [format ["mrk%1",random 100000],_posCenteredOnBuilding];
			_m setMarkerShape "ELLIPSE";
			_m setMarkerSize [_radius,_radius];
			_m setMarkerBrush "FDiagonal";
			_m setMarkerColor "ColorRed";
			_m setMarkerAlpha 0;
			if (SHOW_SECTOR || DEBUG) then{
				_m setMarkerAlpha .5;
			};
		
			//Nb units to spawn per block
			_popbase = 30 MIN (ceil((count _buildings)*(RATIO_POPULATION)  + (floor random 3)));
			_nbCivilian =  ceil (_popbase * (PERCENTAGE_CIVILIAN/100));
			_nbSnipers = if (random 100 > 66) then{ 2 } else{ 0 };
			_nbEnemies = 1 max (round (_popbase * (PERCENTAGE_ENEMIES/100)));
			_nbCars = ([0,1] call BIS_fnc_selectRandom) MAX (6 MIN (floor((count _buildings)*(RATIO_CARS))));
			_nbIeds = (1 + floor(random 10));
			_nbCaches = [0,1] call BIS_fnc_selectRandom;
			_nbHostages = [0,1] call BIS_fnc_selectRandom;
			_nbMortars = if (_nbSnipers > 1) then{ 0 }else{ [0,1] call BIS_fnc_selectRandom };
			_nbOutpost = [0,0,1] call BIS_fnc_selectRandom; 
			_points = _nbEnemies * 5;

			_meetingPointPosition =  [_posCenteredOnBuilding, 0, .5*_radius, 4, 0, 20, 0] call BIS_fnc_findSafePos;
			while {isOnRoad _meetingPointPosition} do{
				_meetingPointPosition =  [_posCenteredOnBuilding, 0, .67*_radius, 4, 0, 20, 0] call BIS_fnc_findSafePos;
			};

			_peopleToSpawn = [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost];
			MARKERS pushBack  [_m,_posCenteredOnBuilding,false,false,_xc,_yc,_radius,[],_peopleToSpawn,_meetingPointPosition,_points];
		};
	};
};


_timerChaser = time - 360;
private ["_cars","_mkr","_cacheResult","_ieds"];
//Main Loop
while {true} do{

	_playerPos = position player;
	_isInFlyingVehicle = false;

		if( (vehicle player) != player && ((vehicle player) isKindOf "Air" && (_playerPos select 2) > 4))then{
			_isInFlyingVehicle = true;
		};

	{
		private _marker =_x select 0;
		private _pos =_x select 1;
		private _triggered =_x select 2;
		private _success =_x select 3;
		private _xc =_x select 4;
		private _yc =_x select 5;
		private _radius =_x select 6;
		private _units =_x select 7;
		private _peopleToSpawn =_x select 8;
		private _meetingPointPosition =_x select 9;
		private _points =_x select 10;

		//if (_playerPos distance _pos < SPAWN_DISTANCE && _playerPos distance _pos > MIN_SPAWN_DISTANCE && !_triggered && !_isInFlyingVehicle ) then{
		if (_playerPos distance _pos < SPAWN_DISTANCE && !_triggered && !_isInFlyingVehicle ) then{
		
			if (count UNITS_SPAWNED < MAX_SPAWNED_UNITS)then{

				//Véhicles spawn
				_cars = ([_pos,_radius,(_peopleToSpawn select 3)] call fnc_SpawnCars);
				_units = _units + _cars;

				//Units
				_units = _units + ([_pos,_radius,_success,_peopleToSpawn,_meetingPointPosition] call fnc_SpawnUnits);
				UNITS_SPAWNED = UNITS_SPAWNED + _units;

				//IEDs
				_units = _units +  ([_pos,_radius,(_peopleToSpawn select 4)] call fnc_Ieds);
				
				_outpost = [_marker,(_peopleToSpawn select 8)] call fnc_SpawnOutpost;
				_units = _units + _outpost;
				
				_units = _units + ([_pos,_radius,(_peopleToSpawn select 5)] call fnc_cache);

				_units = _units + ([_pos,_radius,(_peopleToSpawn select 6)] call fnc_hostage);

				_mortars = [_pos,_radius,(_peopleToSpawn select 7)] call fnc_SpawnMortar;

				_units = _units + ([_meetingPointPosition] call fnc_SpawnMeetingPoint);

				_units = _units + _mortars;
				_triggered = true;
			}

		}else{

			//Gestion du cache
			if(_playerPos distance _pos > (SPAWN_DISTANCE + 150) && _triggered)then {
				_cacheResult = [_units] call fnc_CachePut;
				_peopleToSpawn = _cacheResult select 0;
				_units = _units - [_cacheResult select 1];
				_triggered = false;
			} else {

				// Check if enemies remains in the area;
				if (_triggered && !_success) then{
					if ([_playerPos, _marker] call fnc_isInMarker) then{
						_nben = 0;
						_enemyInMarker = false;
						_res  = {
							if (side _x == ENEMY_SIDE && !_enemyInMarker && alive _x)then {
								if ([_x,_marker] call fnc_isInMarker) exitWith {_enemyInMarker = true; true; };
							};
						} foreach allUnits;

						//Cleared success
						if (!_enemyInMarker)then {
							_success = true;
							[_marker,_radius,_units,_points] call COMPOUND_SECURED;
							player globalChat "This compound is cleared !";
							_marker setMarkerColor "ColorGreen";
						};

					};
				};
			};
		}; 


	
		MARKERS set [_forEachIndex,[_marker,_pos,_triggered,_success,_xc,_yc,_radius,_units,_peopleToSpawn,_meetingPointPosition,_points]]; 

	}foreach MARKERS;

		_civilReputationSum = 0;
		_civilReputationNb = 0;
		{

			//Empty the killed units
			if (!alive _x)then{
				UNITS_SPAWNED = UNITS_SPAWNED - [_x];
				UNITS_CHASERS = UNITS_CHASERS - [_x];
			};

			//Detection
			if (!CHASER_TRIGGERED && side _x == ENEMY_SIDE && _x knowsAbout player > .2 ) then{
				[_x] spawn {
					params["_unit"];
					if (DEBUG) then  {
						hint format["You've been watched by %1",name _unit];
					};
					sleep 10;
					if (alive _unit && !CHASER_TRIGGERED && _unit knowsAbout player > .2)then{
						if (DEBUG) then  {
							hint "Alarm !";
						};
						CHASER_TRIGGERED = true;
						[] spawn {
							sleep 250;
							if (DEBUG) then  {
								hint "Alarm off!";
							};
							CHASER_TRIGGERED = false;
						};
					};
				}
			};

			//Calcul du score
			if (_x getVariable["IH_friendliness",-1] != -1) then{
				_civilReputationSum = _civilReputationSum + (_x getVariable["IH_friendliness",-1]);
				_civilReputationNb = _civilReputationNb + 1;
			};

			//Update marker position
			if (DEBUG)then{
				_mkr = _x getVariable["marker",""];
				if (_mkr!="")then{
					_mkr setMarkerPos (getPosWorld _x);
				};
			};
		} foreach UNITS_SPAWNED + UNITS_CHASERS;
		
		if (_civilReputationNb > 0) then  {
			_tmp = round(_civilReputationSum/_civilReputationNb);
			if (_tmp != CIVIL_REPUTATION) then{
				_diff = (_tmp-CIVIL_REPUTATION);
				[format["REPUTATION %1% <t color='%2'>%3%4pt</t>",_tmp,if(_diff > 0) then {"#29c46c"} else{"#ea4f4f"},if(_diff > 0) then{"+"}else{""},_diff]] spawn fnc_ShowIndicator;
			};
			CIVIL_REPUTATION = _tmp;
		};

	//Chasers
	if (CHASER_TRIGGERED && count UNITS_CHASERS < MAX_CHASERS && time > (_timerChaser + 20))then{
		_timerChaser = time;
		UNITS_CHASERS = UNITS_CHASERS + ([] call fnc_SpawnChaser);
	};


	//Remove chasers too far
	{
		if (_x distance _playerPos > SPAWN_DISTANCE + 500)then {
			deleteMarker (_x getVariable["marker",""]);
			deleteVehicle _x;
		};
	} foreach UNITS_CHASERS;

	sleep 5;
};
