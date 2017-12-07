/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//CONFIG
fnc_FactionClasses = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionClasses.sqf";

//Switch here the config you need.
[] call (compileFinal preprocessFileLineNumbers "DCW\config\config-rhs-malden.sqf"); 

//SYSTEM
fnc_isInMarker= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\isinMarker.sqf";
fnc_findBuildings= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findBuildings.sqf";
fnc_addMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\addMarker.sqf";
fnc_findNearestMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findNearestMarker.sqf";
fnc_CachePut = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\CachePut.sqf";
fnc_ShowIndicator = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\ShowIndicator.sqf"; 
fnc_Talk = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Talk.sqf";
BIS_fnc_FindSafePos = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\FindSafePos.sqf";


//SPAWN
fnc_SpawnUnits= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnUnits.sqf";
fnc_SpawnAsEnemy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnAsEnemy.sqf";
fnc_SpawnFriendlies = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendlies.sqf";
fnc_spawnchaser = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnchaser.sqf";
fnc_spawnoutpost = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnoutpost.sqf";
fnc_SpawnMeetingPoint = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMeetingPoint.sqf";
fnc_SpawnCivil =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCivil.sqf";
fnc_SpawnEnemy =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnEnemy.sqf";
fnc_SpawnMortar = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMortar.sqf";
fnc_SpawnCars = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCars.sqf";
fnc_SpawnMainObjective = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMainObjective.sqf";
fnc_SpawnConvoy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnConvoy.sqf";
fnc_SpawnPosition = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnPosition.sqf";

//PATROL
fnc_Patrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\CompoundPatrol.sqf";
fnc_SimplePatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\SimplePatrol.sqf";
fnc_LargePatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\LargePatrol.sqf";
fnc_chase = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\chase.sqf";
fnc_carPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\carPatrol.sqf";
fnc_civilianPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\civilianPatrol.sqf";
fnc_gotomeeting =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\gotomeeting.sqf";
fnc_chopperpatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\ChopperPatrol.sqf";

//OBJECTIVES
fnc_GetIntel = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\GetIntel.sqf";
fnc_ieds = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\ied.sqf";
fnc_cache = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\cache.sqf";
fnc_Hostage = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\hostage.sqf";
fnc_Success = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Success.sqf";
fnc_failed = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Failed.sqf";
fnc_createtask =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\createtask.sqf";
fnc_MainObjectiveIntel =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\MainObjectiveIntel.sqf";

//CUSTOM BEHAVIOR
fnc_MortarBombing = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\MortarBombing.sqf";
fnc_addtorch = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addtorch.sqf";
fnc_randomAnimation = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\randomAnimation.sqf";
fnc_UpdateRep =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\UpdateRep.sqf";
fnc_LocalChief = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\LocalChief.sqf";
fnc_PrepareAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\PrepareAction.sqf"; 
fnc_AddCivilianAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addCivilianAction.sqf";
fnc_shout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Shout.sqf";
fnc_BadBuyLoadout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\BadBuyLoadout.sqf";

//HANDLERS
fnc_HandleFiredNear = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleFiredNear.sqf";
fnc_HandleDamaged = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleDamaged.sqf";
fnc_handlekill = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleKill.sqf";

//composition
compo_camp1 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp1.sqf");
compo_camp2 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp2.sqf");
compo_camp3 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp3.sqf");
compo_camp4 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp4.sqf");
compo_camp5 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp5.sqf");
compo_commander1 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\commander1.sqf");
compo_commander2 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\commander2.sqf");
compos = [compo_camp1,compo_camp2,compo_camp3,compo_camp4,compo_camp5];
compo_rest =  call (compileFinal preprocessFileLineNumbers "DCW\composition\rest.sqf");

//Variable in Global scope
UNITS_SPAWNED = [];
INTELS = [];
UNITS_CACHED = [];
MARKERS = [];
SHEEP_POOL = [];
UNITS_CHASERS = [];
CHASER_TRIGGERED = false;
MESS_SHOWN = false;
LAST_FLARE_TIME = time;
REFRESH_TIME = 10;


//EVENT LIST
CIVILIAN_KILLED = { 
	params["_unit","_killer"]; 
	hint format ["%1 %2 was killed by %3",name (_unit),side _unit,name (_killer)];
	_friends = nearestObjects [position _unit,["Man"],50];
	{  if (side _x == CIV_SIDE) then { [_x,-4] call fnc_UpdateRep}; }foreach _friends;
	[player,-20] call fnc_updateScore;
};

ENEMY_KILLED = {
	params["_type","_unit"]; 
	[player,2,true] call fnc_updateScore;
 };

COMPOUND_SECURED = { 
	params["_marker","_radius","_units","_points"]; 

	//Misa à jour de l'amitié
	{  if (side _x == CIV_SIDE && _x getVariable["DCW_Friendliness",-1] != -1) then { [_x,6] call fnc_UpdateRep;}; }foreach _units;
	[player,_points] call fnc_updateScore;
};

OBJECTIVE_ACCOMPLISHED = { 
	params["_type","_unit","_bonus"]; 
	if (_bonus > 0) then{
		[player,_bonus] call fnc_updateScore;
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
MARKER_WHITE_LIST pushBack _mp;


[] call fnc_PrepareAction;
[getPos player] execVM "DCW\fnc\Spawn\Respawn.sqf"; //Respawn loop
[] execVM "DCW\fnc\spawn\SpawnSheep.sqf"; //Sheep herds spawn
[] execVM "DCW\fnc\spawn\SpawnRandomEnemies.sqf"; //Enemy patrols
[] execVM "DCW\fnc\spawn\SpawnRandomCar.sqf"; //Civil & enemy cars
[] execVM "DCW\fnc\spawn\SpawnRandomCivilian.sqf"; //Civilians walking around
[] execVM "DCW\fnc\spawn\SpawnChopper.sqf"; //Chopper spawn
[] execVM "DCW\fnc\spawn\SpawnTank.sqf"; //Tanks
[] spawn fnc_SpawnMainObjective;
[-150] spawn fnc_SpawnConvoy;

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
			_nbFriendlies =  ceil (_popbase * (PERCENTAGE_CIVILIAN/100));
			_nbSnipers = if (random 100 > 75) then{ 2 } else{ 0 };
			_nbEnemies = 1 max (round (_popbase * (PERCENTAGE_ENEMIES/100)));
			_nbCars = ([0,1] call BIS_fnc_selectRandom) MAX (6 MIN (floor((count _buildings)*(RATIO_CARS))));
			_nbIeds = (1 + floor(random 7));
			_nbHostages = [0,1] call BIS_fnc_selectRandom;
			_nbCaches = if (_nbHostages == 0) then {[0,1] call BIS_fnc_selectRandom}else{0};
			_nbMortars = if (_nbSnipers >= 1) then{[0,1] call BIS_fnc_selectRandom }else{0};
			_nbOutpost = [0,0,1] call BIS_fnc_selectRandom; 
			_nbFriendlies = 0;
			_points = _nbEnemies * 5;

			_meetingPointPosition =  [_posCenteredOnBuilding, 0, .5*_radius, 4, 0, 20, 0] call BIS_fnc_FindSafePos;
			while {isOnRoad _meetingPointPosition} do{
				_meetingPointPosition =  [_posCenteredOnBuilding, 0, .67*_radius, 4, 0, 20, 0] call BIS_fnc_FindSafePos;
			};

			_peopleToSpawn = [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies];
			MARKERS pushBack  [_m,_posCenteredOnBuilding,false,false,_xc,_yc,_radius,[],_peopleToSpawn,_meetingPointPosition,_points];
		};
	};
};



private ["_cars","_mkr","_cacheResult","_ieds"];


_timerChaser = time - 360;

while {true} do{
	
	_playerPos = position player;
	_isInFlyingVehicle = false;
	_nbUnitSpawned = count UNITS_SPAWNED;

	if( (vehicle player) != player && ((vehicle player) isKindOf "Air" && (_playerPos select 2) > 4))then{
		_isInFlyingVehicle = true;
	};

	_xC = floor((_playerPos select 0)/SIZE_BLOCK);
	_yC = floor((_playerPos select 1)/SIZE_BLOCK);
	_o = 4;


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

		if (!_triggered && !_isInFlyingVehicle && _playerPos distance _pos < SPAWN_DISTANCE) then{
		
			if (_nbUnitSpawned < MAX_SPAWNED_UNITS)then{

				//Véhicles spawn
				_units = _units +  ([_pos,_radius,(_peopleToSpawn select 3)] call fnc_SpawnCars);

				//Units
				_units = _units + ([_pos,_radius,_success,_peopleToSpawn,_meetingPointPosition] call fnc_SpawnUnits);

				//Units
				_units = _units + ([_pos,_radius,_peopleToSpawn select 9,_meetingPointPosition] call fnc_SpawnFriendlies);
				
				//IEDs
				_units = _units +  ([_pos,_radius,(_peopleToSpawn select 4)] call fnc_Ieds);
				
				//Outposts
				_units = _units + ([_marker,(_peopleToSpawn select 8)] call fnc_SpawnOutpost);
				
				//Cache
				_units = _units + ([_pos,_radius,(_peopleToSpawn select 5)] call fnc_cache);

				//Hostages
				_units = _units + ([_pos,_radius,(_peopleToSpawn select 6)] call fnc_hostage);

				//Meeting points
				_units = _units + ([_meetingPointPosition] call fnc_SpawnMeetingPoint);
				
				//Mortars
				_units = _units + ([_pos,_radius,(_peopleToSpawn select 7)] call fnc_SpawnMortar);

				_triggered = true;
			}

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
							[player,"This compound is cleared ! Great job."] call fnc_talk;
							_marker setMarkerColor "ColorGreen";
						};

					};
				};
			};
		}; 

		
	
		MARKERS set [_forEachIndex,[_marker,_pos,_triggered,_success,_xc,_yc,_radius,_units,_peopleToSpawn,_meetingPointPosition,_points]]; 

	}foreach MARKERS select { (_x select 3) || ((_x select 4) <= (_xC + _o) && (_x select 4) >= (_xC - _o) && (_x select 5) <= (_yC + _o) && (_x select 5) >= (_yC - _o)) };

		_civilReputationSum = 0;
		_civilReputationNb = 0;
		{

			//Empty the killed units
			if (!alive _x)then{
				UNITS_SPAWNED = UNITS_SPAWNED - [_x];
			};

			//Detection
			if (!CHASER_TRIGGERED && side _x == ENEMY_SIDE && _x knowsAbout player > .2 ) then{
				[_x] spawn {
					params["_unit"];
					if (DEBUG) then  {
						//hint format["You've been watched by %1",name _unit];
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
			if (_x getVariable["DCW_Friendliness",-1] != -1) then{
				_civilReputationSum = _civilReputationSum + (_x getVariable["DCW_Friendliness",-1]);
				_civilReputationNb = _civilReputationNb + 1;
			};

			if (_x getVariable["DCW_Type",""] == "chaser")then{
				if (_x distance _playerPos > SPAWN_DISTANCE + 300)then {
					deleteMarker (_x getVariable["marker",""]);
					deleteVehicle _x;
				};
			};

			//Update marker position
			if (DEBUG)then{
				_mkr = _x getVariable["marker",""];
				if (_mkr!="")then{
					_mkr setMarkerPos (getPosWorld _x);
				};
			};



		} foreach UNITS_SPAWNED ;
		
		if (_civilReputationNb > 0) then  {
			_tmp = round(_civilReputationSum/_civilReputationNb);
			if (_tmp != CIVIL_REPUTATION) then{
				_diff = (_tmp-CIVIL_REPUTATION);
				[format["REPUTATION %1% <t color='%2'>%3%4pt</t>",_tmp,if(_diff > 0) then {"#29c46c"} else{"#ea4f4f"},if(_diff > 0) then{"+"}else{""},_diff]] spawn fnc_ShowIndicator;
			};
			CIVIL_REPUTATION = _tmp;
		};

	//Chasers
	if (CHASER_TRIGGERED && time > (_timerChaser + 20))then{
		_timerChaser = time;
		UNITS_SPAWNED = UNITS_SPAWNED + ([] call fnc_SpawnChaser);
	};

	sleep REFRESH_TIME;
};