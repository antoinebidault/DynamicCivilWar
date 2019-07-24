 /*
	Author: 
		Bidass

  Version:
    {VERSION}

	Description:
		Add the set camping action to the player.
        
	Parameters:
		0: OBJECT - unit (player)

	Returns:
		BOOL - true 
*/

 
 _this addAction [format["<t color='#00FF00'>%1 (1 hour)</t>", localize "STR_DCW_actionCamp_setUpAction"], {
        params["_unit","_asker","_action"];

        if((_unit findNearestEnemy _unit) distance _unit < 100) exitWith {hint localize "STR_DCW_actionCamp_error" ;};
        if(([getPos _unit, 1, getDir _unit ] call BIS_fnc_relPos) isFlatEmpty  [2, -1, 0.3, 2, 0, false, _unit]  isEqualTo [] ) exitWith { 
            hint localize "STR_DCW_actionCamp_error2" ; };

        {deleteVehicle _x;} foreach CAMP_OBJS;
        
		[_unit, "medic"] remoteExec ["playActionNow"];

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
        
        titleCut ["", "BLACK FADED", 9999];
	    [parseText format ["<t font='PuristaBold' size='1.6'>1 %1</t><br/>%2",localize "STR_DCW_actionCamp_hourLater", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

        if (!isMultiplayer) then {
            skipTime 1;
        };
        CAMP_OBJS = [getPos _unit,getDir _unit, compo_camp ] call BIS_fnc_objectsMapper;
        sleep 3;
        titleCut ["", "BLACK IN", 3];
        sleep 3;
        disableUserInput false;
        [_unit,localize "STR_DCW_voices_teamLeader_campSetUp"] remoteExec ["DCW_fnc_talk",0, false];

        hint localize "STR_DCW_actionCamp_hint";
         
        // Pack up camp
        (CAMP_OBJS select 0) addAction [format["<t color='#00FF00'>%1</t>",localize "STR_DCW_actionCamp_packUpAction"], {
            params["_unit","_asker","_action"];
            _unit call DCW_fnc_actioncamp;
           CAMP_RESPAWN_POSITION = [];
           publicVariable "CAMP_RESPAWN_POSITION";
           
           disableUserInput true;
            titleCut ["", "BLACK OUT", 1];
            sleep 3;
            if (!isMultiplayer) then {
                skipTime 1;
            };
            {deleteVehicle _x;} foreach CAMP_OBJS;
            titleCut ["", "BLACK FADED", 9999];
            [parseText format ["<t font='PuristaBold' size='1.6'>1 %1</t><br/>%2",localize "STR_DCW_actionCamp_hourLater", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

            sleep 3;
            titleCut ["", "BLACK IN", 3];
            [_asker,localize "STR_DCW_voices_teamLeader_campPackedUp" ] remoteExec ["DCW_fnc_talk",0, false];
             sleep 3;
           disableUserInput false;
        },nil,4,true,true, ""];

        
        //Rest animations
        (CAMP_OBJS select 18) remoteExec ["DCW_fnc_actionrest",0, true];

},nil,1,false,true,"","if(vehicle(_this) == _this)then{true}else{false};",15,false,""];