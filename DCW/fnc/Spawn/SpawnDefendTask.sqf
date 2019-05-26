params["_compound"];

_units = [];
_spawnPos = [_compound select 1, .75*SPAWN_DISTANCE,.75*(SPAWN_DISTANCE+100), 5, 0, .3, 0, MARKER_WHITE_LIST] call BIS_fnc_FindSafePos;
_grp = createGroup SIDE_ENEMY;
_nbVehicles = 1 max (floor random 3);


if (getMarkerColor "DCW_defend" !="") then{
	deleteMarker "DCW_defend";
};
_taskId = format["DCW_defend_%1",str (_compound select 0)];

{
	[_taskId, _x, ["Enemy attack incoming, set up the defenses","Defend civilian","Defend civilian"],_compound select 1,"CREATED",1, true] remoteExec ["BIS_fnc_setTask",_x, false];
} foreach units GROUP_PLAYERS;     


for "_j" from 1 to _nbVehicles do {
	_unitName = ENEMY_LIST_CARS call BIS_fnc_selectRandom;
	_car = ([_spawnPos, random 360,_unitName, SIDE_ENEMY] call bis_fnc_spawnvehicle)  select 0;
	_car enableDynamicSimulation false;
	_nbUnits = (count (fullCrew [_car,"cargo",true]));

	{_units pushback _x; _x enableDynamicSimulation false; }foreach crew _car;

	//Civilian team spawn.
	//If we killed them, it's over.
	_grp = group _car;
	for "_xc" from 1 to _nbUnits  do {
		_unit =[_grp,_spawnPos,true] call fnc_spawnEnemy;
		_unit moveInCargo _car;
		_units pushback _unit;
		_unit enableDynamicSimulation false;
	};
};

sleep 10;

_wp =_grp addWaypoint [_compound select 1, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointFormation "LINE";
_wp setWaypointCompletionRadius 30;


_dir = round([_spawnPos,_compound select 1] call BIS_fnc_dirTo);
_marker = createMarker ["DCW_defend",_spawnPos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Defend !";
_marker setMarkerType "hd_arrow";
_marker setMarkerDir _dir;


waitUntil {sleep 3; ({_x inArea (_compound select 0)} count (units GROUP_PLAYERS) == 0 && {_x inArea (_compound select 0)} count _units >= 3) || ({ _x distance (_compound select 1) > SPAWN_DISTANCE } count (units GROUP_PLAYERS) == count (units GROUP_PLAYERS)) || ({(alive _x) && (!(captive _x))} count _units <= 2) };

// If eliminated
if ({(alive _x) && (!(captive _x))} count _units <= 2) then{

	{
		[HQ, "Good job ! The compound is safe now."] remoteExec ["fnc_talk",_x,false];
		[_taskId,"SUCCEEDED",true] remoteExec ["BIS_fnc_taskSetState",_x,false];
	} foreach allPlayers;    

	[_compound,"supporting"] call fnc_setCompoundState;
	[_compound,30, 10] call fnc_setCompoundSupport;         

} else {
	{
		[HQ, "The compound wasn't defended..."] remoteExec ["fnc_talk",_x,false];
		[_taskId,"FAILED",true] remoteExec ["BIS_fnc_taskSetState",_x,false];
	} foreach allPlayers;       

	[_compound,"bastion"] call fnc_setCompoundState;
	[_compound,-35, 10] call fnc_setCompoundSupport;
};

{ { deleteVehicle _x; } foreach crew _x; deleteVehicle _x; } foreach _units;

_units = [];

