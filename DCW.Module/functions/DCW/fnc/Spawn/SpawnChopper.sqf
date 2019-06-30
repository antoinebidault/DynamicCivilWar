/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_chopper","_spawnPos","_className"];


CHOPPERS  = [];

if (NUMBER_CHOPPERS == 0)exitWith{CHOPPERS};

for "_xc" from 1 to NUMBER_CHOPPERS do {
    _spawnPos = [(([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom) , 4000, 4500, 3, 0, 20, 0,MARKER_WHITE_LIST] call BIS_fnc_findSafePos;
    _className = (ENEMY_CHOPPERS call bis_fnc_selectrandom);
    _chopper = [[_spawnPos select 0, _spawnPos select 1, 50], 180, _className, SIDE_ENEMY] call BIS_fnc_spawnVehicle select 0;
     _chopper setPilotLight true;
     _chopper setCollisionLight true;
     group _chopper setBehaviour "SAFE";
     driver _chopper setBehaviour "SAFE";

    if (DEBUG) then {
        private _marker = createMarker [format["chopp%1",random 13100],_spawnPos];
        _marker setMarkerShape "ICON";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerType "o_air";
        _chopper setVariable["marker",_marker];
    };
    UNITS_SPAWNED_CLOSE pushback _chopper;

    [_chopper] call DCW_fnc_chopperpatrol;

    sleep 50;
    
};
