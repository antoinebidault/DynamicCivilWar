/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _grp = _this select 0;
private _landPos =_this select 1;
transportHelo = _this select 2;
private _unit = _this select 3;
private _deathReplaced = _this select 4;

interventionGroup = [transportHelo,side _unit] call fnc_SpawnHeloCrew;
replacementGroup = [transportHelo,side _unit,_this select 4] call fnc_SpawnHeloReplacement;

HASLANDED = false;
MEDEVAC_ISABORTED = false;

private _startPos = position transportHelo;
HQ sideChat format["Be advised: medevac chopper in bound ! ETA : %1min",ceil((_landPos distance _startPos)/1000)*.333] ;

 private _wp0 = _grp addwaypoint [_landPos, 10];
 _wp0 setwaypointtype "MOVE";

transportHelo addEventHandler ["handleDamage", {
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
		transportHelo setVariable ["mission_aborted",true];
	}
}];


waitUntil {transportHelo distance2D _landPos < 200};

HQ sideChat "Throw a green smoke !"  ;

SmokeShell = objNull;
_unit addEventHandler ["Fired", {
	if ((_this select 4) isKindOf "SmokeShell") then 
	{
		SmokeShell = _this select 6;
	}
}];


private _startTime = time;

waitUntil {!isNull SmokeShell || time > (_startTime + 40 ) };
if (time > (_startTime + 40)) exitWith {transportHelo setVariable ["mission_aborted",true];};

sleep 5;

[] spawn{
	sleep 3;
	transportHelo action ["useWeapon",transportHelo,driver transportHelo,1];
	sleep 5;
	transportHelo action ["useWeapon",transportHelo,driver transportHelo,1];
	sleep 3;
	transportHelo action ["useWeapon",transportHelo,driver transportHelo,1];
};

HQ sideChat "Roger !"  ;

_unit removeEventHandler ["Fired", 0];

deleteWaypoint [_grp, 0];
 private _pos = [getposatl SmokeShell, 2, 50, 7, 0, 20, 0] call BIS_fnc_FindSafePos;
 private _landpad = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "NONE"];
 private _wp01 = _grp addwaypoint [_pos, 0];

 _wp01 setwaypointtype "UNLOAD";
 _wp01 setWaypointStatements ["true","HASLANDED = true;"];

_timer = time;
waitUntil {sleep 2; HASLANDED || time == _timer + 300};

if (!HASLANDED) exitWith {[transportHelo] call fnc_AbortMedevac;};

transportHelo land "GET IN";
replacementGroup leavevehicle transportHelo;
interventionGroup leavevehicle transportHelo; 

waitUntil{{_x in transportHelo} count units  replacementGroup == 0 && {_x in transportHelo} count units  interventionGroup == 0  };

replacementGroup move position player;
{_x setUnitPos "MIDDLE"; _x setBehaviour "MIDDLE"; } foreach (units replacementGroup);
[interventionGroup,_deathReplaced,transportHelo] call fnc_save ;
HQ sideChat format["We're starting the %1 injured's evacuations.",count _deathReplaced];

waitUntil{ MEDEVAC_ISABORTED || ({_x in transportHelo} count (units  interventionGroup) == count (units  interventionGroup)) };
 
if (MEDEVAC_ISABORTED) then {
	HQ sideChat "Mission aborted, it's too dangerous here ! out.";
	_allUnits =  units replacementGroup + units interventionGroup + _deathReplaced;
	{
		if (vehicle _x == _x)then{
			unassignVehicle _x; 
		};
	} forEach _allUnits ;
	transportHelo move _startPos;
}else{
	{unassignVehicle _x;_x setBehaviour "AWARE"; _x enableAI "ALL"; _x setUnitPos "AUTO";}foreach (units replacementGroup);
	(units replacementGroup) join group _unit;
	HQ sideChat "Reinforcments arriving.";
	transportHelo move _startPos;
};

//Suppress des waypoints
while {(count(waypoints _grp))>0} do 
{
	deleteWaypoint ((waypoints _grp) select 1);	
	sleep 0.01;
};

private _wp1 = _grp addwaypoint [_startPos, 0];
_wp1 setwaypointtype "MOVE";
_wp1 setWaypointStatements ["true","{ deleteVehicle _x ;} forEach crew transportHelo;deleteVehicle transportHelo; "];

sleep 3;
	transportHelo action ["useWeapon",transportHelo,driver transportHelo,1];
sleep 5;
	transportHelo action ["useWeapon",transportHelo,driver transportHelo,1];

