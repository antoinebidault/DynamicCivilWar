

/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Spawn a defend task

  Parameters:
    0: ARRAY - Compound config array

*/

params["_compound"];

_units = [];
_nbGroups = 1 max ceil(random 2);

_taskId = format["DCW_defend_%1",str (_compound select 0)];

[HQ,format[localize "STR_DCW_voices_HQ_enemyGroups",_nbGroups]] remoteExec ["DCW_fnc_talk"];
{
	[_taskId, _x, [localize "STR_DCW_spawnDefendTask_taskDesc",localize "STR_DCW_spawnDefendTask_taskName",localize "STR_DCW_spawnDefendTask_taskName"],_compound select 1,"CREATED",1, true] remoteExec ["BIS_fnc_setTask",_x, false];
} foreach units GROUP_PLAYERS;     

_unitsInCompound = _compound select 5;
{
	if (side _x == SIDE_CIV) then {
		[_x] joinSilent (createGroup SIDE_FRIENDLY);
	};
}
foreach _unitsInCompound;

for "_j" from 1 to _nbGroups do {

	_grp = createGroup SIDE_ENEMY;
	_spawnPos = [_compound select 1, .65*SPAWN_DISTANCE,.65*(SPAWN_DISTANCE+100), 1, 0, .3, 0, MARKER_WHITE_LIST] call BIS_fnc_findSafePos;
	_nbUnits =  4 + floor(random 6); 

	for "_xc" from 1 to _nbUnits  do {
		_unit =[_grp,_spawnPos,true] call DCW_fnc_spawnEnemy;
		_unit setBehaviour "AWARE";
		_unit setSpeedMode "FULL";
		_unit enableDynamicSimulation false;
		_units pushback _unit;
	};

		
	_mkrName = format["DCW_defend_%1",str _j];
	if (getMarkerColor _mkrName !="") then{
		deleteMarker _mkrName;
	};

	// Calculate direction for the marker
	_dir = round([_spawnPos,_compound select 1] call BIS_fnc_dirTo);

	_marker = createMarker [_mkrName,_spawnPos];
	_marker setMarkerShape "ICON";
	_marker setMarkerColor "ColorRed";
	_marker setMarkerText "Defend !";
	_marker setMarkerType "hd_arrow";
	_marker setMarkerDir _dir;

	_wp = _grp addWaypoint [_compound select 1, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "LINE";
	_wp setWaypointCompletionRadius 30;

};



_sectorToDefend = _compound select 0;
waitUntil {sleep 3; ({_x inArea _sectorToDefend} count (units GROUP_PLAYERS) == 0 && {_x inArea _sectorToDefend} count _units >= 2) || ({ _x distance (_compound select 1) > SPAWN_DISTANCE } count (units GROUP_PLAYERS) == count (units GROUP_PLAYERS)) || ({alive _x && !(captive _x)} count _units < 2) };

// If eliminated
if ({(alive _x) && !(captive _x)} count _units <= 2) then{

	{
		[HQ, localize "STR_DCW_voices_HQ_taskDefendSuccess"] remoteExec ["DCW_fnc_talk",_x,false];
		[_taskId,"SUCCEEDED",true] remoteExec ["BIS_fnc_taskSetState",_x,false];
	} foreach ([] call DCW_fnc_allPlayers);    

	[_compound,"resistance"] call DCW_fnc_setCompoundState;
	[_compound, 30, 10] call DCW_fnc_setCompoundSupport;         

} else {
	{
		[HQ, localize "STR_DCW_voices_HQ_taskDefendSuccess"] remoteExec ["DCW_fnc_talk",_x,false];
		[_taskId,"FAILED",true] remoteExec ["BIS_fnc_taskSetState",_x,false];
	} foreach ([] call DCW_fnc_allPlayers);       

	[_compound,"bastion"] call DCW_fnc_setCompoundState;
	[_compound,-35, 10] call DCW_fnc_setCompoundSupport;
};

// Delete all units
{ { _x call DCW_fnc_deleteMarker; deleteVehicle _x; } foreach crew _x; _x call DCW_fnc_deleteMarker; deleteVehicle _x; } foreach _units;

_units = [];

