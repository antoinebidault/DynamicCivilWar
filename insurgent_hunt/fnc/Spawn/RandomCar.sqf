private["_unitName","_car","_pos","_unit","_roadConnectedTo","_roads","_road","_connectedRoad","_roadDirection"];
private _minRange = 300;
private _carPool = [];
private _firstTrigger = true;
CAR = objNull;
while{true}do {
	if (count _carPool < MAX_RANDOM_CAR)then{
		//Get random pos
		// get the next connected roadsegements to determine the direction of the road
		_pos = [position player, 500, 580, 0, 0, 20, 0] call BIS_fnc_findSafePos;
		_road = [_pos,1000] call BIS_fnc_nearestRoad;
		if (isOnRoad(getPos _road) && (getPos _road) distance player > 400 )then{
			_roadConnectedTo = roadsConnectedTo _road;
			_connectedRoad = _roadConnectedTo select 0;
			_roadDirection = [_road, _connectedRoad] call BIS_fnc_DirTo;

			if(random 100 > PERCENTAGE_CIVILIAN )then{
				_unitName = ENEMY_LIST_CARS call BIS_fnc_selectRandom;
				_car = ([getPos _road, _roadDirection,_unitName, ENEMY_SIDE] call bis_fnc_spawnvehicle)  select 0;
				
			}else{
				_unitName = CIV_LIST_CARS call BIS_fnc_selectRandom;
				_car = ([getPos _road, _roadDirection,_unitName, CIV_SIDE] call bis_fnc_spawnvehicle)  select 0;
			
			};
			_carPool pushBack _car ;
			CAR = _car;

			{
				_unit = _x;
				[_unit] call fnc_handlekill;
				[_unit] call fnc_addTorch;
				[_unit,if(side _unit == CIV_SIDE)then {"ColorBlue"}else{"ColorRed"}] call fnc_addMarker;
				UNITS_SPAWNED pushBack _unit;
			} foreach (crew _car);
			[driver _car, 1500] spawn fnc_carPatrol;
			
		};
	};	

	{
		if (!alive _x || { alive _x } count crew  _x == 0 ) then{
			_carPool = _carPool - [_x];
		};
		if(_x distance player > 1500)then{
			_carPool = _carPool - [_x];
			if (DEBUG)then{
				deleteMarker (_x getVariable["marker",""]);
			};
			deleteVehicle _x;
		};
	}foreach _carPool;

	sleep 50 + random 100;
};
