/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Basic chopper patrol around the group position

  Parameters:
    0: OBJECT - Chopper

  Returns:
    BOOL - true 
*/

params["_aircraft"];
_pilot = driver _aircraft;
_aircraft setBehaviour "CARELESS";
_aircraft setPilotLight true;
_aircraft setCollisionLight true;
//_chopper flyInHeight 75;
//_grp setSpeedMode "LIMITED";
sleep random 50;

_aircraft setFuel 1;
while { alive _pilot } do {
    // Pick up a random unit
    _unit = ([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom;
    sleep .4;
     _newPos = ([_unit, 0, 8000, 0, 0, 20, 0] call BIS_fnc_findSafePos);
     _wp = group _pilot addWaypoint [_newPos, 0];
     _wp setWaypointType "HOLD";
     _wp setWaypointCompletionRadius 100;
     _wp setWaypointBehaviour "SAFE";

    waitUntil {sleep 10;(_aircraft distance2D _newPos) < 140 || !alive _aircraft};

    sleep .4;

    _affectedAirport = (allAirports select 0) call BIS_fnc_selectRandom;
    _aircraft assignToAirport _affectedAirport;
    _aircraft landAt _affectedAirport;
    
    waitUntil {sleep 10;isTouchingGround _aircraft || !alive _aircraft};
    sleep 200;
    _aircraft setFuel 0;
    sleep 300;
    _aircraft setFuel 1;
    sleep 10;
};

