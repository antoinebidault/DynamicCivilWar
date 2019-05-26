/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

CRASHSITES  = [];

if (NUMBER_CRASHSITES == 0)exitWith{CRASHSITES};

_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_worldCenter = [_worldSize/2,_worldSize/2,0];
private _tempMarkers = MARKER_WHITE_LIST;

while {count CRASHSITES < NUMBER_CRASHSITES} do{

     _spawnPos = [_worldCenter, 0, (_worldSize/2)*.8, 5, 0, .3, 0, MARKER_WHITE_LIST] call BIS_fnc_FindSafePos;
    
    // Temp marker with previously spawned tank
    _tmpmarker = createMarker [format["ch-bl-%1",random 10000], _spawnPos];
    _tmpmarker setMarkerSize [1000,1000];
    _tmpmarker setMarkerShape "ELLIPSE";
    _tmpmarker setMarkerAlpha 0;
    _tempMarkers = _tempMarkers + [_tmpmarker];
    
    _className = (FRIENDLY_CHOPPER_CLASS call bis_fnc_selectrandom);
    _crater = createVehicle ["Crater", _spawnPos, [], round random 360, "NONE"];
    _chopper = createVehicle [_className, _spawnPos, [], round random 360, "CAN_COLLIDE"];
    _chopper enableSimulationGlobal false;
    _crater setPos (getPos _chopper);

    _chopper setDamage 1;
    _chopper setVehicleLock "LOCKED";

    private _marker = createMarker [format["tk-%1",random 10000],getPos _chopper];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "b_air";
    _chopper setVariable["marker",_marker];

    _chopper setVariable ["DCW_Type","wreck"];
    _chopper setVariable ["DCW_IsIntel",true];
    
    _taskData = [_chopper, (leader GROUP_PLAYERS),false] call fnc_createtask;
    _chopper setVariable["DCW_Task",_taskData select 0];

     //Search intel;
     [_chopper,"Secure and put the charge on...","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 12","true",
     {(_this select 1) playActionNow "medic";},
     {},
     {
          _chopper = (_this select 0);
          [[_this select 0, _this select 1], {
               params["_chopper","_player"];

               [_player,"30 seconds before detonation", false] spawn fnc_talk;
               sleep 24;
               [_player,"5...", false] call fnc_talk;
               [_player,"...4...", false] call fnc_talk;
               [_player,"...3...", false] call fnc_talk;
               [_player,"...2...", false]  call fnc_talk;
               [_player,"...1", false]  call fnc_talk;

               _bomb = "HelicopterExploBig";
               _boom = _bomb createVehicle getPos _chopper;
               _chopper remoteExec ["fnc_success",2, false];
               sleep 1;
               deleteVehicle _chopper;

          }] remoteExec ["spawn",0];

     },{},[],8,nil,true,false] remoteExec ["BIS_fnc_holdActionAdd"];

    // Add to markers

    _enemyArea = createMarker [format["ch-bl-%1",random 10000], getPos _chopper];
    _enemyArea setMarkerSize [144,144];
    _enemyArea setMarkerShape "ELLIPSE";
    _enemyArea setMarkerAlpha 0;
    _civ = 0;
    _en = 0;
    if (random 100 > 50) then { _civ = 4;} else { _en  = 4; };
    MARKERS pushback [_enemyArea,getPos _chopper,false,false,40,[],[_civ,0,_en,0,0,0,0,0,0,0],[], 0,true,false,[],"chopper", 50,"Chopper crash site",[]];
    CRASHSITES pushback _chopper;
};

CRASHSITES;