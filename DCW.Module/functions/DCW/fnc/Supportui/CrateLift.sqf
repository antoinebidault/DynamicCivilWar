
params["_unit","_dist"];

// Spawn CH47
_pos = [_unit, _dist, _dist+1, 0, 0, 20, 0] call BIS_fnc_findSafePos;
_spawnpos = [_pos select 0, _pos select 1, 200];

_heli_spawn = [_spawnpos, 0, SUPPORT_HEAVY_TRANSPORT_CLASS call BIS_fnc_selectRandom, SIDE_FRIENDLY] call BIS_fnc_spawnVehicle;
_chopper = _heli_spawn select 0;
_spawnpos set [2,400];
_chopper setposatl _spawnpos;
createVehicleCrew (_chopper);
_spawnpos set [2,300]; 
_cargo =  "CargoNet_01_box_F" createVehicle _spawnpos;
_cargo setposatl _spawnpos;
_chopper setSlingLoad _cargo;
_pilot = driver _chopper;
_chopper setCollisionLight true;
_chopper setPilotLight true;
_pilot setSkill 1;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET","AUTOCOMBAT"];
group _pilot setBehaviour "CARELESS";
(group (_pilot)) allowFleeing 0;
_helipad_obj = "Land_HelipadEmpty_F" createVehicle (getPos _unit);

_waypoint = (group (_pilot)) addWaypoint [getPos _unit, 0];
_waypoint setWaypointType "UNHOOK";
_waypoint setWaypointBehaviour "CARELESS";
//_Waypoint waypointAttachVehicle _cargo;
_waypoint setWaypointSpeed "LIMITED";

_waypoint2 = (group (_pilot)) addWaypoint [[0,0,0], 1];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "FULL";
_waypoint2 setWaypointStatements ["true", "{deleteVehicle _x} foreach crew this; deleteVehicle this;"];

_chopper;