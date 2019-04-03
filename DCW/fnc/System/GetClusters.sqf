/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Create a complete map cluster
 */

private _worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
private _worldCenter = [_worldSize/2,_worldSize/2,0];
private _worldNbBlocks = floor(_worldSize/SIZE_BLOCK);
private _return = false;
private _isMilitary = false;
private _clusters = [];
private _markerWhiteList = _this select 0;

fnc_isMilitary = {
	params["_buildings"];
	_isMilitary = false;
	//Check military houses
	_nbMilitaryBuilding = {
		_class = (getText (configfile >> "CfgVehicles" >>  (typeOf _x) >> "vehicleClass")) ;
		_class == "Structures_Military" || _class == "Structures_Airport" || _class == "Fortifications" 
	} count _buildings;
	if(_nbMilitaryBuilding > (count _buildings)/6) exitWith {true};
	false;
};

fnc_getRadiusLocation = {
	params ["_locpos"];
	_locpos set [2,0];
	private _houseCount = 0;
	private _oldHouseCount = 0;
	private _prevHouseCount = 0;
	private _rad = 50;
	private _count = 0;
	private _houses = []; 
	private _totalHouses  = [];
	for "_radius" from 50 to MAX_CLUSTER_SIZE step 50 do
	{
		_houses = []; 
		//_houses = nearestObjects [_locPos, ["house"], _radius];
		_houses = [_locPos,_radius] call fnc_findBuildings;
		_count = (count _houses);
		_totalHouses = _totalHouses + _houses;
		if (_count == _prevHouseCount) exitWith { _rad = _radius-50; };
		_prevHouseCount = _count;
		_rad = _radius;
	};

	_isMilitary = [_totalHouses] call fnc_isMilitary;

	[_rad, _count,_isMilitary,_totalHouses];
};

// Friendly markers
_markerFriendly = [];
{  if (_x find "marker_friendly" == 0 ) then { _markerFriendly pushback _x }; }foreach allMapMarkers; 
{
	_locPos = getMarkerPos _x;
	_radius = getMarkerSize _x select 0;
	_result = [_locPos] call fnc_getRadiusLocation;
	_clusters pushback [_locPos,_radius,_result select 1,true,_x,true, _result select 3];
} foreach _markerFriendly;


// forEach nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameLocal","NameCity","NameVillage","Strategic","CityCenter"], 25000]; 


for "_xc" from 0 to _worldNbBlocks do {
	for "_yc" from 0 to _worldNbBlocks do {
		_markerPos = [(_xc*SIZE_BLOCK),(_yc*SIZE_BLOCK),0];
		if (_markerPos inArea _markerWhiteList) then {
			_buildings = [_markerPos, (SIZE_BLOCK/2)] call fnc_findBuildings;
			_nbBuildings = count _buildings;

			if (_nbBuildings > 0)then{
				private _posCenteredOnBuilding = position (_buildings select 0);
				private _res  = [_posCenteredOnBuilding] call fnc_getRadiusLocation;
				private _radius = _res select 0;

				_return = false;
				{ 
					private _dist = _posCenteredOnBuilding distance (_x select 0);
					if( _dist < (_x select 1)  + _radius )exitWith{_return = true;};
				} foreach _clusters;

				if (isNil '_return')then{_return = false;};
				if (!_return)then {
					_clusters pushback [_posCenteredOnBuilding,_radius,_res select 1,false,"",_res select 2,_res select 3];
				};

			};
		};
	};
};

_clusters;


