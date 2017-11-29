/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private ["_chopper","_spawnPos","_className"];


CHOPPERS  = [];

if (NUMBER_CHOPPERS == 0)exitWith{CHOPPERS};

for "_xc" from 1 to NUMBER_CHOPPERS do {
    _spawnPos = [player, 4000, 4500, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    _className = (ENEMY_CHOPPERS call bis_fnc_selectrandom);
    _chopper = [[_spawnPos select 0, _spawnPos select 1, 50], 180, _className, ENEMY_SIDE] call BIS_fnc_spawnVehicle select 0;

     _chopper setPilotLight true;
     _chopper setCollisionLight true;
     group _chopper setBehaviour "SAFE";
     driver _chopper setBehaviour "SAFE";

    [_chopper] spawn fnc_chopperpatrol;

    if (DEBUG) then {
        private _marker = createMarker [format["chopp%1",random 13100],_spawnPos];
        _marker setMarkerShape "ICON";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerType "o_air";
        _chopper setVariable["marker",_marker];

    };
    
    CHOPPERS pushback _chopper;
};

sleep 1;

if (DEBUG) then{
    while {true} do{
        {
            if (!alive _x || damage _x == 1) then { 
                private _marker = _x getVariable["marker",objNull];
                 deleteMarker _marker;
            }else{
                private _marker = _x getVariable["marker",objNull];
                _marker setMarkerPos (getPosASL _x);
            };
        }
        foreach CHOPPERS;
        sleep .5;
    };
};