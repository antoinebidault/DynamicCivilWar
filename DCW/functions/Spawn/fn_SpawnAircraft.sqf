/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

private ["_chopper","_spawnPos","_className"];


AIRCRAFTS  = [];
_nbAircrafts = (count (allAirports select 0)) min MAX_NUMBER_AIRCRAFT;
if (_nbAircrafts == 0)exitWith{AIRCRAFTS};

for "_xc" from 1 to _nbAircrafts do {
    _spawnPos = [(([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom) , 4000, 10500, 3, 0, 20, 0,MARKER_WHITE_LIST] call BIS_fnc_findSafePos;
    _className = (CIV_LIST_AIRCRAFTS call bis_fnc_selectrandom);
    _aircraft = [[_spawnPos select 0, _spawnPos select 1, 50], 180, _className, SIDE_CIV] call BIS_fnc_spawnVehicle select 0;
    
    if (DEBUG) then {
        private _marker = createMarker [format["aircraft%1",random 13100],_spawnPos];
        _marker setMarkerShape "ICON";
        _marker setMarkerColor "ColorYellow";
        _marker setMarkerType "o_air";
        _aircraft setVariable["marker",_marker];
    };

    AIRCRAFTS pushback _aircraft;

    [_aircraft] call DCW_fnc_aircraftPatrol;

    sleep 10;
};
AIRCRAFTS;