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
private _clusters = [];

fnc_getRadiusLocation = {
	params ["_locpos", "_countonlyhouses"];
	_locpos set [2,0];
	private _houseCount = 0;
	private _oldHouseCount = 0;
	private _prevHouseCount = 0;
	private _rad = 300;
	private _finalCount = 0;
	private _houses = []; 
	for "_radius" from 50 to 500 step 50 do
	{
		_houses = []; 
		_excludedcount = 0;
		_houses = [_locPos,_radius] call fnc_findBuildings;
		_allhousecount = (count _houses);
		_finalCount = _allhousecount - _oldHouseCount;
		if ((_finalCount < _prevHouseCount) && (_radius > 99)) exitWith { _rad = _radius; _finalCount = _finalCount; };
		_oldHouseCount = _oldHouseCount +  _finalCount;
		_prevHouseCount = _finalCount;
	};
	[_rad, _finalCount];
};


{
	_pos = getPos _x;
    _res = [getPos _x,true] call fnc_getRadiusLocation;
	_clusters pushback [_pos,_res select 0,_res select 1,true,name _x];
} forEach nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameLocal","NameCity","NameVillage","Strategic","CityCenter"], 25000]; 

for "_xc" from 0 to _worldNbBlocks do {
	for "_yc" from 0 to _worldNbBlocks do {
		_markerPos = [(_xc*SIZE_BLOCK),(_yc*SIZE_BLOCK),0];
		_buildings = [_markerPos, (SIZE_BLOCK/2)] call fnc_findBuildings;
		_nbBuildings = count _buildings;
		if (_nbBuildings > 0)then{
			private _radius = (SIZE_BLOCK/2) MIN ((count _buildings + 3)*10);
			private _posCenteredOnBuilding = position (_buildings call BIS_fnc_selectrandom);

			_return = false;
			{ 
				private _dist = _posCenteredOnBuilding distance (_x select 0);
				if( _dist < (_x select 1)  + _radius )exitWith{_return = true;};
			} foreach _clusters;

			if (isNil '_return')then{_return = false;};
			if (!_return)then {
				_clusters pushback [_posCenteredOnBuilding,_radius,_nbBuildings,false,""];
			};

		};
	};
};

_clusters;


