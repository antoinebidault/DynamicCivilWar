/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//list buildings
params["_pos","_radius"];

//list buildings
_positions = [];

//list buildings
private _buildings = nearestObjects [_pos, ["house"], _radius*1.3];
{
    if ([_x, 3] call BIS_fnc_isBuildingEnterable) then {
        _posBuilding = [_x] call BIS_fnc_buildingPositions;
        for "_uc" from 0 to 1 do {
        private _rndpos = ([_posBuilding] call BIS_fnc_selectRandom) select 0;
        _posBuilding = _posBuilding - [_rndpos];
        _positions pushback _rndpos;
        };
    };
} foreach _buildings;

[_positions,_buildings];
