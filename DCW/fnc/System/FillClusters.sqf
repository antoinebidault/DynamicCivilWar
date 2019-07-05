/*
  Author: 
    Bidass

  Description:
    Fill up the cluster (An array of marker) with population pool data, states...etc...
	This function must be executed on startup

  Parameters:
	1: ARRAY [] - Clusters

  Returns:
    BOOL - true 
*/


params ["_clusters"];

diag_log "[FillClusters] Start process";

_markers = [];
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
		if(_pos inArea _x) exitWith {_return = true;};
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

		_m setMarkerBrush "Solid";

		if (SHOW_SECTOR || DEBUG) then{
			_m setMarkerAlpha .3;
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

		_nbCars = floor (6 MIN (floor((_nbBuildings)*(RATIO_CARS))));
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

		
			/*if (DEBUG) then {
				_marker = createMarker [format["%1-debug", _m], _pos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerAlpha 0.3;
			_marker setMarkerColor "ColorBlack";
			_icon setMarkerText  format["support:%1|%2", _supportScore,_nameLocation];
			//_marker setMarkerText  format["civ:%1/en:%2/Car:%3/bld:%4/ca:%5/mr:%6",_nbCivilian,_nbEnemies,_nbCars,_nbBuildings,_nbCaches,_nbMortars];
			};*/

		_peopleToSpawn = [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies];

		_markers pushBack  [_m,_pos,false,_secured,_radius,[],_peopleToSpawn,_meetingPointPosition,_points,_isLocation,_isMilitary,_buildings,_compoundState,_supportScore,_nameLocation,_respawnId,_defendTaskState,_primaryIntel, [0,0,0,0,0,0,0,0,0,0]];
	};
	
} foreach (_clusters call BIS_fnc_arrayShuffle);

_markers;