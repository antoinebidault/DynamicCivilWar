 _this addAction ["<t color='#00FF00'>Set up camp (1 hour)</t>", {
        params["_unit","_asker","_action"];

        if((_unit findNearestEnemy _unit) distance _unit < 100)exitWith {[_unit,"Impossible untill there is enemies around (100m radius)",false] spawn fnc_talk;};
        if(([getPos _unit, 1, getDir _unit ] call BIS_fnc_relPos) isFlatEmpty  [2, -1, 0.3, 2, 0, false, _unit]  isEqualTo [] )exitWith {[_unit,"Impossible to build the camp here. Check there is not any object in front of you.",false] call fnc_talk;};

        {deleteVehicle _x;} foreach CAMP_OBJS;
        
         _unit playActionNow "medic";

        CAMP_MARKER setMarkerPos getPos _unit;
        CAMP_MARKER setMarkerSize [70,70];
        CAMP_MARKER setMarkerShape "ELLIPSE";
        CAMP_MARKER setMarkerColor "ColorGreen";
        CAMP_MARKER setMarkerAlpha 0.2;

        // Set up global scope variable for respawning all units
        CAMP_RESPAWN_POSITION = getPos _unit;
        publicVariable "CAMP_RESPAWN_POSITION";

        // Update the respawn position
        if (!(CAMP_RESPAWN_POSITION_ID isEqualTo [])) then {
             CAMP_RESPAWN_POSITION_ID remoteExec ["BIS_fnc_removeRespawnPosition",0]; 
        };
        CAMP_RESPAWN_POSITION_ID =  [SIDE_FRIENDLY, getMarkerPos CAMP_MARKER,"camp"] call BIS_fnc_addRespawnPosition;
        publicVariable "CAMP_RESPAWN_POSITION_ID";

        if (!dialog) then {
            disableUserInput true;
        };

        titleCut ["", "BLACK OUT", 3];
        sleep 3;
        
        titleCut ["1 hour later...", "BLACK FADED", 9999];
        if (!isMultiplayer) then {
            skipTime 1;
        };
        CAMP_OBJS = [getPos _unit,getDir _unit, compo_camp ] call BIS_fnc_objectsMapper;
        sleep 3;
        titleCut ["", "BLACK IN", 3];
        sleep 3;
        disableUserInput false;
        [_unit, "The camp is set up !"] remoteExec ["fnc_talk",0, false];

        hint "If you want to pack up the camp, watch the map on the ground and use the action button : 'pack up the camp'. Get close to the tent to make your unit rest (and accelerate the time of the day in singleplayer only).";
         
        // Pack up camp
        (CAMP_OBJS select 0) addAction ["<t color='#00FF00'>Pack up camp</t>", {
            params["_unit","_asker","_action"];
            _unit call fnc_actioncamp;
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
            [_asker, "We've packed up the camp !"] remoteExec ["fnc_talk",0, false];
             sleep 3;
           disableUserInput false;
        },nil,4,true,true, ""];

        
        //Rest animations
        (CAMP_OBJS select 18) remoteExec ["fnc_actionrest",0, true];

    },nil,1,false,true,"","if(vehicle(_this) == _this)then{true}else{false};",15,false,""];