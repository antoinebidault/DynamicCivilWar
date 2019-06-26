
params["_pos","_dist","_type"];


if (isNil '_type') then {_type = "vehicle";};
_cargoClass = if (_type == "crate") then { "CargoNet_01_box_F" } else { _type };


// Spawn CH47
_startPos = [_pos, _dist, _dist + 1, 0, 0, 20, 0] call BIS_fnc_findSafePos;
_spawnpos = [_startPos select 0, _startPos select 1, 200];

_heli_spawn = [_spawnpos, 0, SUPPORT_HEAVY_TRANSPORT_CLASS call BIS_fnc_selectRandom, SIDE_FRIENDLY] call BIS_fnc_spawnVehicle;
_chopper = _heli_spawn select 0;
_spawnpos set [2,400];
_chopper setposatl _spawnpos;
createVehicleCrew (_chopper);
_spawnpos set [2,300]; 
_cargo =  _cargoClass createVehicle _spawnpos;
_cargo setMass [((getMass _cargo) min 11400),0];
sleep 1;
_cargo setposatl _spawnpos;
_success = _chopper setSlingLoad _cargo;
if (!_success) exitWith { 

	[HQ,"Sorry guy, we are unable to drop this kind of vehicle... Try a lighter vehicle"] remoteExec ["DCW_fnc_talk"];
    [GROUP_PLAYERS,150] remoteExec ["DCW_fnc_updateScore",2];   
	{deleteVehicle _x} foreach crew _chopper; 
	deleteVehicle _chopper; 
	deleteVehicle _cargo;
};

[HQ,format["The %1 transport is in bound !",if (_type == "crate") then {"supply"}else{"vehicle"}]] remoteExec ["DCW_fnc_talk"];

_pilot = driver _chopper;
_chopper setCaptive true;
_pilot setCaptive true;

_chopper setCollisionLight true;
_chopper setPilotLight true;
_pilot setSkill 1;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET","AUTOCOMBAT"];
group _pilot setBehaviour "CARELESS";
(group (_pilot)) allowFleeing 0;
_helipad_obj = "Land_HelipadEmpty_F" createVehicle _pos;

_waypoint = (group (_pilot)) addWaypoint [_pos, 0];
_waypoint setWaypointType "UNHOOK";
_waypoint setWaypointBehaviour "CARELESS";
//_Waypoint waypointAttachVehicle _cargo;
_waypoint setWaypointSpeed "LIMITED";

_waypoint2 = (group (_pilot)) addWaypoint [[0,0,0], 1];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "FULL";
_waypoint2 setWaypointStatements ["true", "{deleteVehicle _x} foreach crew this; deleteVehicle this;"];

_chopper;