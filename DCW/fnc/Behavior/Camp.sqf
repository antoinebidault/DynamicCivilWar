/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Very simple
 */
params["_unit"];

CAMP_OBJS = [];

CAMP_MARKER = createMarker [format["camp-marker-%1",random 10000], getPos _unit];
CAMP_MARKER setMarkerSize [70,70];
CAMP_MARKER setMarkerShape "ELLIPSE";
CAMP_MARKER setMarkerColor "ColorGreen";
CAMP_MARKER setMarkerAlpha 0;
MARKER_WHITE_LIST pushback CAMP_MARKER;
publicVariable "MARKER_WHITE_LIST";

fnc_ActionCamp =  {
    _this addAction ["<t color='#00FF00'>Set up camp (1 hour)</t>", {
        params["_unit","_asker","_action"];
        if((_unit findNearestEnemy _unit) distance _unit < 100)exitWith {[_unit,"Impossible untill there is enemies around (100m radius)",false] call fnc_talk;};
        if(([getPos _unit, 1, getDir _unit ] call BIS_fnc_relPos) isFlatEmpty  [2, -1, 0.3, 2, 0, false, _unit]  isEqualTo [] )exitWith {[_unit,"Impossible to build the camp here. Check there is not any object in front of you.",false] call fnc_talk;};
       
        {deleteVehicle _x;} foreach CAMP_OBJS;

        disableUserInput true;
        
        CAMP_MARKER setMarkerPos getPos _unit;
        CAMP_MARKER setMarkerSize [70,70];
        CAMP_MARKER setMarkerShape "ELLIPSE";
        CAMP_MARKER setMarkerColor "ColorGreen";
        CAMP_MARKER setMarkerAlpha 0.2;

        // Set up global scope variable for respawning all units
        CAMP_RESPAWN_POSITION = getPos _unit;
        publicVariable "CAMP_RESPAWN_POSITION";

        
        titleCut ["", "BLACK OUT", 3];
        sleep 3;
        titleCut ["1 hour later...", "BLACK FADED", 9999];
        if (!isMultiplayer) then {
            skipTime 1;
        };
        CAMP_OBJS = [getPos _unit,getDir _unit, compo_camp ] call BIS_fnc_ObjectsMapper;
        sleep 3;
        titleCut ["", "BLACK IN", 3];
        sleep 3;
        disableUserInput false;

        // Pack up camp
        (CAMP_OBJS select 0) addAction ["<t color='#00FF00'>Pack up camp</t>", {
           CAMP_RESPAWN_POSITION = [];
           publicVariable "CAMP_RESPAWN_POSITION";
           
           disableUserInput true;
            titleCut ["", "BLACK OUT", 1];
            sleep 3;
            if (!isMultiplayer) then {
                skipTime 1;
            };
            {deleteVehicle _x;} foreach CAMP_OBJS;
            titleCut ["1 hour later...", "BLACK FADED", 9999];
            sleep 3;
             titleCut ["", "BLACK IN", 3];
             sleep 3;
           disableUserInput false;
        }];

    },nil,1.5,false,true,"","if(vehicle(_this) == _this)then{true}else{false};",15,false,""];
 };

_unit call fnc_ActionCamp;