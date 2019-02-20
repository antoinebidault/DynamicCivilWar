/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


//Default white list marker;
titleCut ["Mission loading...", "BLACK FADED", 999];

SIZE_BLOCK = 300; // Size of blocks
GAME_ZONE_SIZE=5000;
MARKER_WHITE_LIST = []; //Pass list of marker white list name
{  if (_x find "blacklist_" == 0 || _x find "marker_base" == 0 ) then { MARKER_WHITE_LIST pushback _x }; }foreach allMapMarkers; 

private _mp = createMarker ["playerMarker",getPos player ];
_mp setMarkerShape "ELLIPSE";
_mp setMarkerAlpha 0;
_mp setMarkerSize [SIZE_BLOCK,SIZE_BLOCK];
MARKER_WHITE_LIST pushBack _mp;

_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];

private _gameZone = createMarker ["gameZone", _worldCenter ];
_gameZone setMarkerShape "ELLIPSE";
_gameZone setMarkerAlpha 0;
_gameZone setMarkerSize [_worldSize/2,_worldSize/2];


//Consuming work => getAllClusters
private _clusters = [_gameZone] call fnc_GetClusters;

//Briefing
player createDiaryRecord ["Diary",["Keep a good reputation",
"The civilian in the sector would be very sensitive to the way you talk to them. Some of them are definitly hostiles to our intervention. You are free to take them in custody, that's a good point to track the potential insurgents in the region. You must avoid any mistakes, because it could have heavy consequences on the reputation of our troops in the sector. More you hurt them, more they might join the insurgents. If you are facing some difficulties, it is possible to convince some of them to join your team (it would costs you some credits...). Keep in mind the rules of engagements and it would be alright."]];

//Briefing
player createDiaryRecord ["Diary",["How to gather supports ? Side operations",
"To accomplish these tasks, you would need resources from the HQ. They could provide you all the supports you need (Choppers, CAS, ammo drops, extractions...). But you must prove them the value of your action down there. You all know that what we're doing here is not very popular, even in the high command...<br/>That's why, as side objectives, you have to bring back peace in the region. There is a few sides missions you can accomplish :<br/><br/> Clear IEDs on road<br/>Liberate hostages<br/>Destroy mortars<br/>Destroy weapon caches<br/>Desmantle outposts<br/>Eliminate snipers team<br/><br/><br/>You can ask civilian to get some more intels about these sides operations.</br>Your insertion point is already secured and located <marker name='marker_base'>uphill Zaros</marker>. Good luck soldier !"]];

player createDiaryRecord ["Diary",["How to locate the commander ?",
"For this purpose, you have two options : Find and interrogate enemy officers located by our drones. They are oftenly running with mecanized infantry which is very easy to track with our sattelites and drones. The HQ will get you in touch if they've found one.<br/><br/>Interrogate the civilian chief located in large cities, talk to civilians, ask them informations about local chief. If you keep a good reputation, they would help us.<br/>Here is a photography of mecanized infantry with leutnant : <img image='images\leutnant.jpg' width='300' height='193'/>"]];

player createDiaryRecord ["Diary",["Main objective : kill the commander",
"Dynamic Civil War<br/><br/>
In this singleplayer scenario, you have one major objective : assassinate the enemy general. We kow that it would considerably change the situation in this region which is ravaged by war. At this point, we have no intel on his exact location. He is probably hidden in mountains or forests, wandering from place to place very often far from the conflicts areas. Firstly, you must get intel about his approximate position.<br/><img image='images\target.jpg' width='302' height='190'/><br/><br/>"]];

//Var starting
DCW_START = false;

//Starting params and dialogs
[] execVM "DCW\config\config-parameters.sqf"; //Parameters

//Switch here the config you need.
[] call (compileFinal preprocessFileLineNumbers "DCW\config\config-rhs-stratis.sqf"); 

//[] execVM "DCW\config\config-dialog.sqf"; //Open dialog
sleep 1;
DCW_START = true;

//WAiting starting
waitUntil {DCW_START};

titleCut ["", "BLACK IN", 2];

//TIME
setDate [2018, 6, 25, TIME_OF_DAYS, 0]; 

//OVERCAST
0 setOvercast WEATHER;
0 setRain (if (WEATHER > .7) then {random 1}else{0});
setWind [10*WEATHER, 10*WEATHER, true];
0 setFog [if (WEATHER > .8) then {.15}else{0},if (WEATHER > .8) then {.04}else{0}, 60];
0 setGusts (WEATHER - .3);
0 setWaves WEATHER;
forceWeatherChange;
//[] execVM "intro.sqf"; 



//Variable in Global scope
UNITS_SPAWNED = [];
INTELS = [];
UNITS_CACHED = [];
MARKERS = [];
SHEEP_POOL = [];
UNITS_CHASERS = [];
CHASER_TRIGGERED = false;
CHASER_VIEWED = false;
MESS_SHOWN = false;
LAST_FLARE_TIME = time;
REFRESH_TIME = 10; // Refresh time
CONVOY = []; // Current convoy
ESCORT = []; // List of escorts guys with the commandant

//On civilian killed
CIVILIAN_KILLED = { 
	params["_unit","_killer"]; 
	hint format ["%1 %2 was killed by %3",name (_unit),side _unit,name (_killer)];
	_friends = nearestObjects [position _unit,["Man"],50];
	{  if (side _x == CIV_SIDE) then { [_x,-4] call fnc_UpdateRep}; }foreach _friends;
	[player,-20] call fnc_updateScore;
};

//On enemy killed => 2 points
ENEMY_KILLED = {
	params["_type","_unit"]; 
	[player,2,true] call fnc_updateScore;
 };

//On compound secured
COMPOUND_SECURED = { 
	params["_marker","_radius","_units","_points"]; 

	//Misa à jour de l'amitié
	{  if (side _x == CIV_SIDE && _x getVariable["DCW_Friendliness",-1] != -1) then { [_x,6] call fnc_UpdateRep;}; }foreach _units;
	[player,_points] call fnc_updateScore;
};

//On success
OBJECTIVE_ACCOMPLISHED = { 
	params["_type","_unit","_bonus"]; 
	if (_bonus > 0) then{
		[player,_bonus] call fnc_updateScore;
	};
};

//If civilian is healed by player
CIVIL_HEALED = { 
	[player,20] call fnc_updateScore;
 };

//If civil is captured
 CIVIL_CAPTURED = { 
	[player,-5] call fnc_updateScore;
 };

// If player is killed
 PLAYER_KIA = { 
	[player,-20] call fnc_updateScore;
 };

//If player did not respect a civilian
CIVIL_DISRESPECT = { 
	[player,-5] call fnc_updateScore;
};

//On enemy search.
ENEMY_SEARCHED = {
	[player,ceil (random 5)] call fnc_updateScore;
};

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
	private _nameLocation = _x select 3;
	private _isMilitary = _x select 5;

	// If in white list exit loop
	{ 
		if(_pos inArea _x)exitWith{_return = true;};
	} foreach MARKER_WHITE_LIST;

	// If not in game zone => exit loop
	//if(!(_pos inArea _gameZone))exitWith{_return = true;};

	if (isNil{_return})then{_return = false;};
	if (!_return)then
	{

		//Création du marker
		_m = createMarker [format ["mrk%1",random 100000],_pos];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerSize [_radius,_radius];

		if (!_isMilitary) then{
			_m setMarkerBrush "FDiagonal";
		};
		if (_isLocation && !_isMilitary) then{
			_m setMarkerBrush "BDiagonal";
		};

		_m setMarkerColor "ColorRed";
		if (SHOW_SECTOR || DEBUG) then{
			_m setMarkerAlpha .5;
		}else{
			_m setMarkerAlpha 0;
		};

		//Nb units to spawn per block
		_popbase = 1 MAX (30 MIN (ceil((_nbBuildings)*(RATIO_POPULATION)  + (round random 1))));
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
		_nbIeds = (1 + floor(random 4));

		_typeObj = ["hostage","sniper","cache","mortar","","",""] call BIS_fnc_selectRandom;
		_nbHostages = if (_typeObj == "hostage" || _popbase > 20) then{ 1 }else {0};
		_nbSnipers = if (_typeObj == "sniper") then{ 2 } else{ 0 };
		_nbCaches = if (_typeObj == "cache" || _popbase > 20) then{ 1 }else {0};
		_nbMortars = if (_typeObj == "mortar") then{ 1 }else {0};

		_nbOutpost = [0,0,1] call BIS_fnc_selectRandom; 
		_nbFriendlies = 0;
		_points = _nbEnemies * 10;
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
			_marker setMarkerText  format["bld:%1/pop:%2/Car:%3",_nbCivilian,_nbEnemies,_nbCars];
		};

		_peopleToSpawn = [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies];
		MARKERS pushBack  [_m,_pos,false,false,_radius,[],_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary];
	};
	
} foreach _clusters;

[] call fnc_PrepareAction;
[getMarkerPos "marker_base"] execVM "DCW\fnc\Spawn\Respawn.sqf"; //Respawn loop
[] execVM "DCW\fnc\spawn\SpawnSheep.sqf"; //Sheep herds spawn
[] execVM "DCW\fnc\spawn\SpawnRandomEnemies.sqf"; //Enemy patrols
[] execVM "DCW\fnc\spawn\SpawnRandomCar.sqf"; //Civil & enemy cars
[] execVM "DCW\fnc\spawn\SpawnRandomCivilian.sqf"; //Civilians walking around
[] execVM "DCW\fnc\spawn\SpawnChopper.sqf"; //Chopper spawn
[] execVM "DCW\fnc\spawn\SpawnTank.sqf"; //Tanks
[] spawn fnc_SpawnSecondaryObjective;
[] spawn fnc_SpawnMainObjective;
[-150] spawn fnc_SpawnConvoy;

private ["_mkr","_cacheResult","_ieds"];
private _timerChaser = time - 360;

[] spawn {
	if (DEBUG)then{
		while {true} do{
			{
				//Update marker position
				_mkr = _x getVariable["marker",""];
				if (_mkr!="")then{
					_mkr setMarkerPos (getPos _x);
					if (!alive _x) then{
						deleteMarker (_x getVariable["marker",""]);
					}
				};
			} foreach UNITS_SPAWNED + ESCORT + CONVOY;
			sleep 1;
		};
	};
};

while {true} do{
	_playerPos = position player;
	_nbUnitSpawned = count UNITS_SPAWNED;

	//Catch flying player
	_isInFlyingVehicle = false;
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
		private _radius =_x select 4;
		private _units =_x select 5;
		private _peopleToSpawn =_x select 6;
		private _meetingPointPosition =_x select 7;
		private _points =_x select 8;
		private _isLocation = _x select 9;
		private _isMilitary = _x select 10;

		if (!_triggered && !_isInFlyingVehicle && _playerPos distance _pos < SPAWN_DISTANCE) then{
		
			if (_nbUnitSpawned < MAX_SPAWNED_UNITS)then{

				//Véhicles spawn
				_units = _units +  ([_pos,_radius,(_peopleToSpawn select 3)] call fnc_SpawnCars);
				//Units
				_units = _units + ([_pos,_radius,_success,_peopleToSpawn,_meetingPointPosition] call fnc_SpawnUnits);
				//Units
				_units = _units + ([_pos,_radius,_peopleToSpawn select 9,_meetingPointPosition] call fnc_SpawnFriendlies);
				//IEDs
				if (!_isMilitary)then{
					_units = _units +  ([_pos,_radius,(_peopleToSpawn select 4)] call fnc_Ieds);
				};
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
							[_marker,_radius,_units,_points] call COMPOUND_SECURED;
							[player,"This compound is cleared ! Great job."] call fnc_talk;
							_marker setMarkerColor "ColorGreen";
						};

					};
				};
			};
		}; 

		
		MARKERS set [_forEachIndex,[_marker,_pos,_triggered,_success,_radius,_units,_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary]]; 

	}foreach MARKERS select { (_x select 3) || ((_x select 4) <= (_xC + _o) && (_x select 4) >= (_xC - _o) && (_x select 5) <= (_yC + _o) && (_x select 5) >= (_yC - _o)) };

		_civilReputationSum = 0;
		_civilReputationNb = 0;
		{

			//Empty the killed units
			if (!alive _x)then{
				UNITS_SPAWNED = UNITS_SPAWNED - [_x];
			};

			//Detection
			if (!CHASER_TRIGGERED && !CHASER_VIEWED && !(player getVariable["DCW_undercover",false]) && side _x == ENEMY_SIDE && _x knowsAbout player > 1) then{
				
					[_x] spawn {
						params["_unit"];
						CHASER_VIEWED = true;
						sleep (15 + random 5);
						CHASER_VIEWED = false;
						player call fnc_DisplayScore;
						// || _unit knowsAbout player > 2
						if ( alive _unit && !CHASER_TRIGGERED &&  ([_unit,player] call fnc_GetVisibility > 20))then{
							if (DEBUG) then  {
								hint "Alarm !";
							};
							playMusic (["LeadTrack04a_F","LeadTrack04_F"] call BIS_fnc_selectRandom);
							CHASER_TRIGGERED = true;
							player call fnc_DisplayScore;
							[] spawn {
								sleep 250;
								if (DEBUG) then  {
									hint "Alarm off!";
								};
								sleep 200;
								CHASER_TRIGGERED = false;
								player call fnc_DisplayScore;
							};
						};
					};
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



		} foreach UNITS_SPAWNED;
		
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