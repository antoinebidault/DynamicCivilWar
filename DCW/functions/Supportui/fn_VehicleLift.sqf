params["_pos","_dist","_type","_chopperClass"];

if (isNil '_pos') exitWith{hint "unknown position for chopper lift"};
if (isNil '_type') then {_type = "vehicle";};
_cargoClass = _type;
if (_type == "crate") then { _cargoClass = "CargoNet_01_box_F"; };
if (_type == "ammo") then { _cargoClass =  "B_CargoNet_01_ammo_F"; };
if (_type == "buildingKit") then { _cargoClass =  "B_Slingload_01_Repair_F"; };
if (isNil '_chopperClass') then { _chopperClass =  SUPPORT_HEAVY_TRANSPORT_CLASS call BIS_fnc_selectRandom; };

// Correct the destination position
_destPos = [_pos, 0, 60, 7, 0, 1, 0] call BIS_fnc_findSafePos;

// Spawn CH47
_startPos = [_pos, _dist, _dist + 3, 0, 0, 20, 0] call BIS_fnc_findSafePos;

// 200 meter lift for the chopper to be spawned
_spawnpos = [_startPos select 0, _startPos select 1, 0];

//Custom variable
if (_type != "crate") then {
	MARKER_PARADROP_VEHICLE = createMarker [format["vehicle-drop-%1",str random 10],_pos];
	MARKER_PARADROP_VEHICLE setMarkerShape "ICON";
	MARKER_PARADROP_VEHICLE setMarkerColor "ColorBlack";
	MARKER_PARADROP_VEHICLE setMarkerText "Vehicle paradrop";
	MARKER_PARADROP_VEHICLE setMarkerType "mil_warning";
};

_heli_spawn = [_spawnpos, 0, SUPPORT_HEAVY_TRANSPORT_CLASS call BIS_fnc_selectRandom, SIDE_FRIENDLY] call BIS_fnc_spawnVehicle;
_chopper = _heli_spawn select 0;
_spawnpos set [2,400];
_chopper setposatl _spawnpos;
createVehicleCrew (_chopper);
_spawnpos set [2,300];
_cargo =  _cargoClass createVehicle _spawnpos;
if (_type == "ammo")  then {
	_cargo call DCW_fnc_spawnCrate;
} else {
	if (_type == "buildingKit") then {
		[_cargo,["<t color='#cd8700'>Recruit a guard</t>", { [] call DCW_fnc_recruitDialog; },nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction",0,true];
		[_cargo,["<t color='#cd8700'>Buy objects</t>", { [] call DCW_fnc_buildingDialog; },nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction",0,true];
	};
};

_cargo setMass [((getMass _cargo) min 11400),0];
sleep 1;
_cargo setposatl _spawnpos;
_success = _chopper setSlingLoad _cargo;

if (!_success) exitWith { 
    [GROUP_PLAYERS,150] remoteExec ["DCW_fnc_updateScore",2];   
	{deleteVehicle _x} foreach crew _chopper; 
	deleteVehicle _chopper; 
	deleteVehicle _cargo;
	[_pos,_dist,_type,"B_Heli_Transport_03_F"] call DCW_fnc_vehicleLift;
};

[HQ,format["The %1 is in bound !",
if (_type == "crate") then {"supply transport"}else{
	if (_type=="buildingKit") then{
		"building kit"
	} else{
		"vehicle transport"
	};
}]] remoteExec ["DCW_fnc_talk"];

_pilot = driver _chopper;
_chopper setCaptive true;
_pilot setCaptive true;

_chopper setCollisionLight true;
_chopper setPilotLight true;
_pilot setSkill 1;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET","AUTOCOMBAT"];
group _pilot setBehaviour "CARELESS";
(group (_pilot)) allowFleeing 0;
_helipad_obj = "Land_HelipadEmpty_F" createVehicle _destPos;

_waypoint = (group (_pilot)) addWaypoint [_destPos, 0];
_waypoint setWaypointType "UNHOOK";
_waypoint setWaypointBehaviour "CARELESS";
//_Waypoint waypointAttachVehicle _cargo;
_waypoint setWaypointSpeed "LIMITED";

_waypoint2 = (group (_pilot)) addWaypoint [_startPos, 1];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "FULL";
_waypoint2 setWaypointStatements ["true", "{deleteVehicle _x} foreach crew this; deleteVehicle this; deleteMarker MARKER_PARADROP_VEHICLE;"];

_chopper;