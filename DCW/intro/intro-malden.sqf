
0 fadeSound .2;

_dest = START_POSITION;
_spawnpos = [_dest, 1000, 2000, 0, 1, 20, 0] call BIS_fnc_findSafePos;


_cam = "camera" camcreate _spawnpos;
_cam cameraeffect ["internal", "back"];
showCinemaBorder true;


_spawnpos set [2,70]; 
_heli_spawn = [_spawnpos, 0, SUPPORT_MEDEVAC_CHOPPER_CLASS call BIS_fnc_selectRandom, SIDE_FRIENDLY] call BIS_fnc_spawnVehicle;
_chopper = _heli_spawn select 0;
_chopper setPos _spawnpos;
_cam camSetPos (_chopper modelToWorld[3,50,2]);
createVehicleCrew (_chopper);
_pilot = driver _chopper;
{ _x moveInAny _chopper; } foreach  units GROUP_PLAYERS;
_chopper setCollisionLight true;
_chopper setPilotLight true;
_chopper flyInHeight 70;
_chopper setCaptive true;
_pilot setSkill 1;
_chopper flyInHeight 70;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET", "AUTOCOMBAT"];
group _pilot setBehaviour "CARELESS";
(group (_pilot)) allowFleeing 0;

_helipad_obj = "Land_HelipadEmpty_F" createVehicle _dest;

_waypoint = (group (_pilot)) addWaypoint [_dest, 0];
_waypoint setWaypointType "TR UNLOAD";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointStatements ["{vehicle _x == this} count units GROUP_PLAYERS == 0", "(vehicle this) land ""GET IN""; GROUP_PLAYERS  leaveVehicle (vehicle this);"];
_waypoint setWaypointCompletionRadius 4;

_waypoint2 = (group (_pilot)) addWaypoint [_spawnpos, 1];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "FULL";
_waypoint2 setWaypointCompletionRadius 40;
_waypoint2 setWaypointStatements ["true", "{deleteVehicle _x} foreach crew (vehicle this); deleteVehicle (vehicle this);"];


sleep 1;

titleCut ["", "BLACK IN",10];

playMusic "seal";

[] spawn {
	sleep 4;
	nul = ["Bidass presents",.3,.7,8] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["An arma III scenario",.5,.2,8] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["<t color='#cd8700' size = '2.4'>Dynamic Civil War</t>",-1,-1,10,1,0] spawn BIS_fnc_dynamicText;
	sleep 12;
	nul = ["Music by Explosion in the sky",.3,.7,5] spawn BIS_fnc_dynamicText;
};

_camPos =  [getPos _chopper, 400,[_chopper,_helipad_obj] call BIS_fnc_dirTo] call BIS_fnc_relPos;
_camPos set[2,30];
hint str _camPos;
_cam camSetPos _camPos;
_cam camsettarget _dest;
_cam camcommit 0;

sleep 15;

_cam camsettarget _chopper modelToWorld[0,0,-14];
_cam camcommit 4;

sleep 14;

//[_cam,_chopper, [14,2,17], 7] call fnc_camfollow;

_smoke = "SmokeShellYellow" createVehicle  _dest; 

[_chopper] spawn{
	params["_chopper"];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 5;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
};

[_cam,_chopper, [0,40,4], 7] call fnc_camfollow;

deleteVehicle _smoke;
_dest set [2,5];
_cam camSetPos _dest;
_cam camsettarget _chopper modelToWorld[0,0,-10];
_cam camcommit 0;
sleep 10;

//[_cam,_chopper, [-14,22,-15],7] call fnc_camfollow;

titleCut ["", "BLACK OUT", 1];
sleep 1;
titleCut ["", "BLACK FADED", 9999];


camDestroy _cam;
showCinemaBorder false;
_cam cameraeffect ["terminate", "back"];
[_chopper] spawn{
	params["_chopper"];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 5;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 40;
	8 fadeSound 1;	
};


//[player, "All units deployed to the insertion point", 150, 250, 75, 1, [], 0, false] call BIS_fnc_establishingShot;

