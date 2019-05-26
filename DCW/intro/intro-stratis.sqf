
_start = [[1272.35,6632.95,0] , 600, 260 ] call BIS_fnc_relPos;
_dest = [1272.35,6632.95,0];

// Spawn CH47
_spawnpos = _start;


[] spawn {
	sleep 13;
	nul = ["Bidass presents",.3,.7,6] spawn BIS_fnc_dynamicText;
	sleep 11;
	nul = ["An arma III scenario",.3,.2,6] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["Dynamic Civil War",-1,-1,5,1,0] spawn BIS_fnc_dynamicText;
};


_heli_spawn = [_spawnpos, 0, SUPPORT_HEAVY_TRANSPORT_CLASS call BIS_fnc_selectRandom, SIDE_PLAYER] call BIS_fnc_spawnVehicle;
_chopper = _heli_spawn select 0;
_spawnpos set [2,220];
_chopper setposatl _spawnpos;
createVehicleCrew (_chopper);
_spawnpos set [2,100]; 
_cargo =  "B_Boat_Transport_01_F" createVehicle _spawnpos;
_cargo setposatl _spawnpos;
_chopper setSlingLoad _cargo;
_pilot = driver _chopper;
{ _x moveInAny _cargo; } foreach  units GROUP_PLAYERS;
_chopper setCollisionLight true;
_chopper setPilotLight true;
_chopper flyInHeight 70;
_pilot setSkill 1;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET","AUTOCOMBAT"];
group _pilot setBehaviour "CARELESS";
(group (_pilot)) allowFleeing 0;
//_helipad_obj = "Land_HelipadEmpty_F" createVehicle _dest;

_waypoint = (group (_pilot)) addWaypoint [_dest, 0];
_waypoint setWaypointType "UNHOOK";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointStatements ["true", "playMusic ""seal"";"];


_waypoint2 = (group (_pilot)) addWaypoint [_spawnpos, 1];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "FULL";
_waypoint2 setWaypointStatements ["true", "{deleteVehicle _x} foreach crew this; deleteVehicle this;"];

_chopper;