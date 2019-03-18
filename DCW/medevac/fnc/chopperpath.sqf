/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _grp = _this select 0;
private _landPos =_this select 1;
TRANSPORTHELO = _this select 2;
private _unit = _this select 3;

interventionGroup = [TRANSPORTHELO,side _unit] call fnc_SpawnHeloCrew;

HASLANDED = false;
MEDEVAC_ISABORTED = false;

private _startPos = position TRANSPORTHELO;
[HQ,format["Be advised: medevac chopper in bound ! ETA : %1min",ceil((_landPos distance _startPos)/1000)*.333] ,true] remoteExec ["fnc_talk"];

 private _wp0 = _grp addwaypoint [_landPos, 10];
 _wp0 setwaypointtype "MOVE";

TRANSPORTHELO addEventHandler ["handleDamage", {
	params [
		"_unit",			
		"_hitSelection",	
		"_damage",			
		"_source",		
		"_projectile",		
		"_hitPartIndex",	
		"_instigator",		
		"_hitPoint"		
	];
	if (_damage > .2)then{
		[TRANSPORTHELO] call fnc_AbortMedevac;
	}
}];


waitUntil {TRANSPORTHELO distance2D _landPos < 200};

[HQ,"Squad leader, throw a green smoke to mark the LZ !" ,true] remoteExec ["fnc_talk"];


SmokeShell = objNull;
_unit addEventHandler ["Fired", {
	if ((_this select 4) isKindOf "SmokeShell") then 
	{
		SmokeShell = _this select 6;
	}
}];


private _startTime = time;

waitUntil {!isNull SmokeShell || time > (_startTime + 50 ) };
if (time > (_startTime + 50)) exitWith {[TRANSPORTHELO] call fnc_AbortMedevac;};

sleep 5;

[] spawn{
	sleep 3;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
	sleep 5;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
	sleep 3;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
};

[HQ,"Landing procedure started !" ,true] remoteExec ["fnc_talk"];

_unit removeEventHandler ["Fired", 0];

deleteWaypoint [_grp, 0];
 private _pos = [getposatl SmokeShell, 2, 50, 7, 0, 20, 0] call BIS_fnc_FindSafePos;
 private _landpad = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "NONE"];
 private _wp01 = _grp addwaypoint [_pos, 0];

 _wp01 setwaypointtype "UNLOAD";
 _wp01 setWaypointStatements ["true","HASLANDED = true;"];

_timer = time;
waitUntil {sleep 2; HASLANDED || time == _timer + 300};

if (!HASLANDED) exitWith {[TRANSPORTHELO] call fnc_AbortMedevac;};

// Remove deads soldiers
private _soldiersDead = units (group _unit) select {_x getVariable["unit_injured",false] };
replacementGroup = [TRANSPORTHELO,side _unit,_soldiersDead] call fnc_SpawnHeloReplacement;
sleep 1;

TRANSPORTHELO land "GET IN";
replacementGroup leavevehicle TRANSPORTHELO;
interventionGroup leavevehicle TRANSPORTHELO; 


waitUntil{{_x in TRANSPORTHELO} count units  replacementGroup == 0 && {_x in TRANSPORTHELO} count units  interventionGroup == 0  };

replacementGroup move position _unit;
{_x setUnitPos "MIDDLE"; _x setBehaviour "MIDDLE"; } foreach (units replacementGroup);

{ [_x] joinSilent grpNull; } foreach _soldiersDead;

//Make replacementGroup join player
{unassignVehicle _x;_x setBehaviour "AWARE"; _x enableAI "ALL"; _x setUnitPos "AUTO";}foreach (units replacementGroup);
(units replacementGroup) join group _unit;
[HQ,"Reinforcments arriving.",true] remoteExec ["fnc_talk"];

// Save units
[HQ,format["We're starting the %1 injured's evacuations.",count _soldiersDead],true] remoteExec ["fnc_talk"];
[interventionGroup,_soldiersDead,TRANSPORTHELO] spawn fnc_save;

waitUntil{ MEDEVAC_ISABORTED || ({_x in TRANSPORTHELO} count (units  interventionGroup) == count (units  interventionGroup)) };
 
if (MEDEVAC_ISABORTED) then {
	[HQ,"Medevec aborted, it's too dangerous here, we're RTB! out.",true] remoteExec ["fnc_talk"];
	_allUnits =  units replacementGroup + units interventionGroup + _soldiersDead;
	{
		if (vehicle _x == _x)then{
			unassignVehicle _x; 
		};
	} forEach _allUnits ;
	TRANSPORTHELO move _startPos;
}else{

	TRANSPORTHELO move _startPos;
};

//Suppress des waypoints
while {(count(waypoints _grp))>0} do 
{
	deleteWaypoint ((waypoints _grp) select 1);	
	sleep 0.01;
};

private _wp1 = _grp addwaypoint [_startPos, 0];
_wp1 setwaypointtype "MOVE";
_wp1 setWaypointStatements ["true","{ deleteVehicle _x ;} forEach crew TRANSPORTHELO;deleteVehicle TRANSPORTHELO; "];

sleep 3;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
sleep 5;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];

