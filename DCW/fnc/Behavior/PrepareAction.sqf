/*
  Author: 
    Bidass

  Description:
    Prepare functions for the civilian spawned on the map mostly

*/

DCW_fnc_addActionJoinAsAdvisor = {
      _this addaction ["<t color='#FF0000'>Recruit him as a military advisor (-30pts)</t>",{
         params["_unit","_talker","_action"];
         if (!(_this call DCW_fnc_startTalking)) exitWith {};
         if ({_x getVariable["DCW_advisor",false]}count (units GROUP_PLAYERS) >= 2) exitWith {[_talker,"You can't recruit more than two military advisors...",false] call DCW_fnc_talk;_this call DCW_fnc_endTalking;false;};
         if (!([GROUP_PLAYERS,30] call DCW_fnc_afford)) exitWith {[_talker,"I need more points !",false] call DCW_fnc_talk;_this call DCW_fnc_endTalking;false;};
      
        [_unit,true] remoteExec ["stop",owner _unit];
        _talker playActionNow "GestureFreeze";
        [_unit, "GestureHi"] remoteExec ["playActionNow"];

        sleep .3;

        [_talker,"Hi buddy, I would need a military advisor, are you in ?!",false] call DCW_fnc_talk;
        [_unit,"I'm in ! Let's go",false] call DCW_fnc_talk;
        [_unit,_action] remoteExec ["removeAction"];

        sleep .3;
        
        _unit setVariable["DCW_advisor", true, true];
        [_unit,false] remoteExec ["stop",owner _unit];
        [_unit] join GROUP_PLAYERS;
        _this call DCW_fnc_endTalking;
        _unit remoteExec ["DCW_fnc_addActionLeaveGroup",0];

    },nil,1,true,true,"","true",3,false,""];
};

//Menote le mec;
DCW_fnc_addActionHandCuff =  {
    _this addaction ["<t color='#FF0000'>Capture him</t>",{
        _unit  = (_this select 0);
        _unit removeAllEventHandlers "FiredNear";
        _unit  setVariable["civ_affraid",false];

        sleep .2;
        [_unit,""] remoteExec ["switchMove"];
        sleep .2;
        [ (_this select 1),"PutDown"] remoteExec ["playActionNow"];
        _unit SetBehaviour "CARELESS";
        _unit setCaptive true;
        [_unit,-4] remoteExec ["DCW_fnc_updateRep",2];

        //Handle weapon states
        _rifle = primaryWeapon _unit; 
        if (_rifle != "") then {
            _unit action ["dropWeapon", _unit, _rifle];
            waitUntil {animationState _unit == "amovpercmstpsraswrfldnon_ainvpercmstpsraswrfldnon_putdown" || time > 3}; 
            removeAllWeapons _unit; 
        };

        _pistol = handgunWeapon _unit; 
        if (_pistol != "") then {
            _unit action ["dropWeapon", _unit, _pistol];
            waitUntil {animationState _unit == "amovpercmstpsraswrfldnon_ainvpercmstpsraswrfldnon_putdown" || time > 3}; 
            removeAllWeapons _unit; 
        };

        [_unit, ["Surrender", _unit]] remoteExec ["action"]; 
        _unit disableai "ANIM"; 
        _unit disableAI "MOVE"; 

        _unit remoteExec ["RemoveAllActions",0];

        _unit call DCW_fnc_addActionLiberate;
        _unit call DCW_fnc_addActionLookInventory;
        hint "Civilian captured";	   
        [_unit] remoteExec ["CIVIL_CAPTURED",2];

    },nil,9,false,true,"","true",3,false,""];
};


DCW_fnc_addActionInstructor = {
    
    if (!isMultiplayer)then {
        _this addaction ["<t color='#FF0000'>Savegame</t>",{
        saveGame;
        },nil,1.5,false,true,"","true",3,false,""];
    };

     _this addaction ["<t color='#FF0000'>Briefing</t>",{
        params["_unit"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        [_unit, "Your main objective is to seek and neutralize an enemy commander hidden somewhere..."] call DCW_fnc_talk;
        [_unit, "He will be always moving on the map, hiding in forestry area or compounds."] call DCW_fnc_talk;
        [_unit, "You have two way to get info about his location : interrogating civil chief in compound or interrogating one of his officers wandering on the map in trucks..."] call DCW_fnc_talk;
        [_unit, "We've located a few of these officers spreading the insurgency accross the country. It's highly recommended to neutralize them"] call DCW_fnc_talk;
        [_unit, "The key path is to make the population always supporting you. Giving people food, medicine and military training will make our investigations easier."] call DCW_fnc_talk;
        [_unit, "Alright guys ? Any question ? Dismiss !"] call DCW_fnc_talk;
        _this call DCW_fnc_endTalking;
    },nil,1,true,true,"","true",3,false,""];
};

DCW_fnc_addActionGiveUsAHand =  {
    _this select 0 addaction ["<t color='#FF0000'>Give us a hand (20 points/10 minutes)</t>",{
        _unit  = (_this select 0);
        _talker  = (_this select 1);
        _action  = (_this select 2);

         if (!(_this call DCW_fnc_startTalking)) exitWith {};
         if (!([GROUP_PLAYERS,20] call DCW_fnc_afford)) exitWith {_this call DCW_fnc_endTalking;[_unit,"You need more points !",false] call DCW_fnc_talk;false;};
         [_unit,"Ok, we're taking your flank",false] spawn DCW_fnc_talk;
         _this call DCW_fnc_endTalking;

        {
            [_x,_action] remoteExec ["removeAction",2];
            [_x,["Stop following us",{
                _unit  = (_this select 0);
                _talker  = (_this select 1);
                _action  = (_this select 2);
                [_unit,"Understood sir !",false] spawn DCW_fnc_talk;

                 {
                    [_x,_action] remoteExec ["removeAction",2];
                    _x setVariable ["follow_player",false];
                    [_x] remoteExec ["DCW_fnc_addActionGiveUsAHand"];
                } foreach units group _unit;
            }]] remoteExec ["addAction",2];
        } foreach units group _unit;

        _talker playActionNow "PutDown";
        // Make follow us
        _group =  group _unit ;
        [_group,_talker] spawn {
            params["_group","_talker"];
            (leader _group) setVariable["follow_player",true];
            _wp1 = _group addWaypoint [[0,0,0],0];
            _wp1 setWaypointType "MOVE";
            _wp1 setWaypointBehaviour "AWARE";
            while {alive _talker && leader _group getVariable["follow_player", false]} do {
                _wp1 setWaypointPosition [(_talker ModelToWorld [random 25,-20,0]), 0];
                _group setCurrentWaypoint _wp1;
                sleep 20;
            };
        };
         

    },nil,1,false,true,"","true",5,false,""];
};

DCW_fnc_addActionLiberate =  {
    _this addaction ["<t color='#FF0000'>Liberate him</t>",{
        _unit  = (_this select 0);
        _talker  = (_this select 1);
        _action  = (_this select 2);
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        [_talker,"Go away now ! asshole !",false] call DCW_fnc_talk;
        if(side _unit != SIDE_CIV) then {
		    [_unit] joinSilent createGroup SIDE_CIV;
        };
        _unit remoteExec ["removeAllActions",0];
        [_talker,"PutDown"] remoteExec ["playActionNow"];
        //[_unit] call DCW_fnc_handlefiredNear;
        //[_unit] call DCW_fnc_addCivilianAction;
        _this call DCW_fnc_endTalking;
        _unit SetBehaviour "AWARE";
        _unit setCaptive false;
        [_unit,""] remoteExec ["switchMove",0]; 
        [_unit,"ANIM"] remoteExec ["switchMove",owner _unit]; 
        [_unit,"MOVE"] remoteExec ["switchMove",owner _unit]; 
        if (side _unit == SIDE_CIV) then {
            [_unit,2] remoteExec ["DCW_fnc_updateRep",2];
        };
        _pos = [getPos _unit, 1000, 1100, 1, 0, 20, 0] call BIS_fnc_findSafePos;
        
        [_unit,false] remoteExec ["stop",owner _unit]; 
        [_unit,10] remoteExec ["forceSpeed",owner _unit]; 
        [_unit,false] remoteExec ["forceWalk",owner _unit]; 
        [_unit,_pos] remoteExec ["move",owner _unit]; 
        
    },nil,1,false,true,"","true",3,false,""];
};


DCW_fnc_addActionLookInventory = {
      _this addaction ["<t color='#FF0000'>Search in gear</t>",{
        params["_unit","_human","_action"];
        _unit removeAction _action;
        if (_unit getVariable["DCW_Suspect",false])then{
            for "_i" from 1 to 3 do {_unit addItemToUniform "1Rnd_HE_Grenade_shell";};
            [_human,"Holy shit ! This man is carrying material for IED purposes !",true] remoteExec ["DCW_fnc_talk"];
            [_unit,1] remoteExec ["DCW_fnc_updateRep",2];   
            [GROUP_PLAYERS,30,false,_human] remoteExec ["DCW_fnc_updateScore",2];   
            _unit remoteExec ["RemoveAllActions",0];
        }else{
            [_unit,-1] remoteExec ["DCW_fnc_updateRep",-2];   
        };
        sleep .4;
        if (alive _unit) then {
            _human action ["Gear", _unit];
        };

    },nil,5,false,true,"","true",3,false,""];
};

DCW_fnc_addActionHalt = {
      _this addaction ["<t color='#FF0000'>Say hello</t>",{
        params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        
        _talker remoteExec ["GestureFreeze"];
        
        _unit stop true;
        [_unit,"MOVE"] remoteExec ["disableAI"];

        [_talker,"Hello sir !",false] call DCW_fnc_talk;
        
        if (!weaponLowered _talker) exitWith { 
            [_unit,"I don't talk to somebody pointing his gun on me ! Go away !",false] remoteExec ["DCW_fnc_talk",_talker];
            [_unit, "gestureNo"] remoteExec ["playActionNow",2];
            [_talker,"I'm sorry, sir !",false] call DCW_fnc_talk;
            [_unit,-2] remoteExec ["DCW_fnc_updateRep",2];
            _unit stop false;
            [_unit,"MOVE"] remoteExec ["enableAI"];
            _this call DCW_fnc_endtalking;
            false; 
        };
        
        [_unit,_action] remoteExec ["removeAction"];
        _unit remoteExec ["DCW_fnc_addActionDidYouSee"];
        _unit remoteExec ["DCW_fnc_addActionFeeling"];
        _unit remoteExec ["DCW_fnc_addActionGetIntel"];
        _unit remoteExec ["DCW_fnc_addActionRally"];
        _unit remoteExec ["DCW_fnc_addActionSupportUs"];
        if ( _unit getVariable["DCW_Chief",objNull] != objNull && alive (_unit getVariable["DCW_Chief",objNull])) then {
            [_unit,_unit getVariable["DCW_Chief",objNull]] remoteExec ["DCW_fnc_addActionFindChief"];
        };

        sleep 1;
        [_unit, "GestureHi"] remoteExec ["playActionNow"];
        [_unit,format["Hi ! My name is %1.", name _unit],false] remoteExec ["DCW_fnc_talk",_talker];
        
        sleep 0.5;

        _this call DCW_fnc_endtalking;

        waitUntil { _talker distance _unit > 13; sleep 4; };
            
        _unit stop false;
        [_unit,"MOVE"] remoteExec ["enableAI"];

        _unit remoteExec ["RemoveAllActions"];
        [_unit] remoteExec ["DCW_fnc_addCivilianAction"];

    },nil,12,false,true,"","true",6,false,""];
};

DCW_fnc_addActionDidYouSee = {
    //Try to gather intel
     _this addaction ["<t color='#FF0000'>Did you see anything recently ?</t>",{
    params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};

        [_unit,_action] remoteExec ["removeAction"];

        /*if (_unit getVariable["DCW_Friendliness",50] < 40) exitWith {
            [_unit,-2] remoteExec ["DCW_fnc_updateRep",2];
            [_unit,"Don't talk to me !",false] call DCW_fnc_talk;
            false;
        };*/
        
        [_talker,"Did you see anything recently ?", false] remoteExec ["DCW_fnc_talk",_talker];
        private _data = _unit targetsQuery [objNull,SIDE_ENEMY, "", [], 0];
        sleep 1;
        _data = _data select {side group (_x select 1) == SIDE_ENEMY};

        if (count _data == 0) exitWith {
            [_unit, "I saw nothing...",false] remoteExec ["DCW_fnc_talk",_talker];
            _this call DCW_fnc_endtalking;
        };

        if (count _data > 3) then { _data = [_data select 0] + [_data select 1] + [_data select 2];};
        
        [_unit,format["I saw %1 enemies...",count _data],false] remoteExec ["DCW_fnc_talk", _talker];
        _markers = [];
        {
            _enemy = _x select 1;
            if (alive _enemy) then {
                _nbMeters = round((_enemy distance _unit)/10)/100;
                _ang = ([_unit,_enemy] call BIS_fnc_dirTo) + 11.25; 
                if (_ang > 360) then {_ang = _ang - 360};
                _points = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"];
                _num = floor (_ang / 22.5);
                _compass = _points select _num;
                _type = getText (configFile >> "cfgVehicles" >> typeOf vehicle _enemy >> "displayName");
                [_unit, format["I saw a %1 %2 %3km away, %4minutes ago ", _type,_compass,_nbMeters,ceil((_x select 5)/60)],false] call DCW_fnc_talk;
                _marker = createMarkerLocal [format["enemyviewed-%1", random 50], position _enemy];
                _marker setMarkerShapeLocal "ICON";
                _marker setMarkerTypeLocal "mil_dot";
                _marker setMarkerColorLocal "ColorRed";
                _marker setMarkerTextLocal format["%1", _type];
                _markers pushback _marker;
                sleep .3;
            };
        } forEach _data;

        [_unit,"I marked their positions on your map. Help us please !",false] call DCW_fnc_talk;
        [_unit,1] remoteExec ["DCW_fnc_updateRep",2];
        [_talker,"Thanks a lot !",false] call DCW_fnc_talk;
        _this call DCW_fnc_endtalking;
        sleep 240;
        { deleteMarker _x; }foreach _markers;
        if (alive _unit) then {
            _unit remoteExec ["DCW_fnc_addActionDidYouSee"];
        };

    },nil,5,false,true,"","true",2.5,false,""];
};

DCW_fnc_addActionFeeling = {
    //Try to gather intel
     _this addaction [format["<t color='#FF0000'>What's your feeling about the %1's presence in %2</t>",getText(configfile >> "CfgFactionClasses" >> format["%1",faction (([] call DCW_fnc_allPlayers) select 0)] >> "displayName"),worldName] ,{
        params["_unit","_talker","_action"];
            if (!(_this call DCW_fnc_startTalking)) exitWith {};
            [_unit,1] remoteExec ["DCW_fnc_updateRep",2];
            [_unit, _action] remoteExec["removeAction"];
            _message = "No problem, if you stay calm";
            CIVIL_REPUTATION = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker) select 13;
            if (CIVIL_REPUTATION  < 10) then {
                _message = "Go away, before I call all my friends to kick your ass!";
            }else{
                if (CIVIL_REPUTATION  < 20) then {
                _message = "You crossed a line... I would never help you guys ! ";
                }else{
                    if (CIVIL_REPUTATION  < 30) then {
                    _message = "It's getting really bad... ";
                    }else{
                        if (CIVIL_REPUTATION  < 40) then {
                            _message = "You're not welcome here... ";
                        }else{
                            if (CIVIL_REPUTATION  < 50) then {
                                _message = "Ou relations are getting worst";
                            }else{
                            if (CIVIL_REPUTATION  < 55) then {
                                    _message = "You should do more to help us !";
                                }else{
                                    if (CIVIL_REPUTATION  < 70) then {
                                        _message = "Less hostile around here, it's getting better here.";
                                    }else{
                                        if (CIVIL_REPUTATION  < 85) then {
                                            _message = "You made a great job here ! Thanks for everything.";
                                        }else{
                                            if (CIVIL_REPUTATION  <= 100) then {
                                                _message = "Have a drink my friend ! Grab a bier ! My home is yours !";
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };

            [_unit,_message,false] call DCW_fnc_talk;
            _this call DCW_fnc_endtalking;
            
            sleep 120;
            
            _unit remoteExec["DCW_fnc_addActionFeeling"];

        },nil,4,false,true,"","true",3,false,""];
};



DCW_fnc_addActionGetIntel = {
    //Try to gather intel
    _this addaction ["<t color='#FF0000'>Gather intel (15 minutes)</t>",{
       params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};

        //Suspect
        _isSuspect=_unit getVariable ["DCW_Suspect",false];

         /*if (_unit getVariable["DCW_Friendliness",50] < 35 ) exitWith {
            if (side _unit == SIDE_CIV) then {
                [_unit,-3] remoteExec ["DCW_fnc_updateRep",2];
            };  
           [_unit,"Don't talk to me !",false] call DCW_fnc_talk;
           false;
        };*/

        _unit removeAction _action;
        if (!weaponLowered _talker)then{
            _talker action ["WeaponOnBack", _talker];
        };
        showCinemaBorder true;
        _camPos = _talker modelToWorld [-1,-0.2,1.9];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.0;
        _cam camCommit 0;
        _unit lookAt _talker;
        _talker lookAt _unit;

        sleep 1;

        //Talking with the fixed glitch
        _anim = format["Acts_CivilTalking_%1",ceil(random 2)];
        _unit switchMove _anim;

        titleCut ["", "BLACK OUT", 1];
        [parseText format ["<t font='PuristaBold' size='1.6'>15 minutes later...</t><br/>%1", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

        sleep 1;
        if (!isMultiplayer) then {
            skipTime .25;
        };
        if (_isSuspect)then{
           [_unit,["Not your business !","I must leave...","Leave me alone please...","I'm a dead man if I talk to you..."] call BIS_fnc_selectRandom,false] call DCW_fnc_talk;
        }else{
           [_unit,_talker] remoteExec ["DCW_fnc_getIntel",2];
           [_unit,3] remoteExec ["DCW_fnc_updateRep",2];
        };

        sleep 1;

        titleCut ["", "BLACK IN", 4];

        showCinemaBorder false;
        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;

        // Stop
        _this call DCW_fnc_endTalking;

         waitUntil{animationState _unit != _anim};
        [_unit,""] remoteExec["switchMove",owner _unit] ;

        sleep 10;


    },nil,5,false,true,"","true",3,false,""];
};


DCW_fnc_addActionRally = {
    //Try to make him a friendly
    _this addaction["<t color='#FF0000'>Try to rally (30 minutes/5 points)</t>",{
       params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        if (!([GROUP_PLAYERS,5] call DCW_fnc_afford)) exitWith {_this call DCW_fnc_endTalking;[_unit,"You need more money !",false] call DCW_fnc_talk;false;};

        _unit removeAction _action;
        showCinemaBorder true;
        _camPos = _talker modelToWorld [-1,-0.2,1.9];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.0;
        _cam camCommit 0;
        [_unit,true] remoteExec["stop",owner _unit];
        _unit lookAt _talker;
        _talker lookAt _unit;
        sleep 1;
        _unit disableAI "MOVE";
        titleCut ["", "BLACK OUT", 1];
        [parseText format ["<t font='PuristaBold' size='1.6'>30 minutes later...</t><br/>%1", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

        sleep 1;
        skipTime .50;
        sleep 2;
        titleCut ["", "BLACK IN", 4];
        sleep 3;
        showCinemaBorder false;
        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;

        //Suspect
        _isSuspect = _unit getVariable ["DCW_Suspect",false];
        
        _this call DCW_fnc_endTalking;
       
       if(random 100 < PERCENTAGE_FRIENDLY_INSURGENTS && !_isSuspect) then {
            [_unit,false] remoteExec["stop",owner _unit];
            [_unit,"ALL"] remoteExec["enableAI",owner _unit];
            [_unit,"Ok, I'm in !",false] remoteExec ["DCW_fnc_talk",_talker];
            [_unit,SIDE_FRIENDLY] remoteExec ["DCW_fnc_badBuyLoadout",owner _unit];
            _unit remoteExec ["RemoveAllActions"];
            _unit setVariable["DCW_recruit",true,true];
            _unit remoteExec ["DCW_fnc_addActionLeaveGroup"];
            [_unit,3] remoteExec ["DCW_fnc_updateRep",2];
            [_unit] joinSilent grpNull;
            [_unit] join GROUP_PLAYERS;
        }else{
            if (_isSuspect)then{
                [_unit,"No thanks",false] remoteExec ["DCW_fnc_talk",_talker];
            }else{
                [_unit,"Sorry, but I have a family ! No way I get back to war...", false] remoteExec ["DCW_fnc_talk",_talker];
            };

            [_unit,-1 ] remoteExec ["DCW_fnc_updateRep",2];
        };
    },nil,2,false,true,"","true",3,false,""];
};

DCW_fnc_addActionSupportUs = {
    //Try to gather intel
     _this addaction ["<t color='#FF0000'>Give him help (2 hours/20points)</t>",{
        params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        _unit removeAction _action;

        if (!([GROUP_PLAYERS,20] call DCW_fnc_afford)) exitWith {_this call DCW_fnc_endTalking;[_unit,"You need more money !",false] remoteExec ["DCW_fnc_talk",_talker];false;};
        
        [_talker,"What are looking for ? We can provide you food, medicine, water...", false] remoteExec ["DCW_fnc_talk",_talker];
        [_unit,1] remoteExec ["DCW_fnc_updateRep",(2 + floor random 2)];
        [_unit,"Thanks for your precious help !",false] remoteExec ["DCW_fnc_talk",_talker];
        [_unit,"You're welcome !",false] remoteExec ["DCW_fnc_talk",_talker];
        _this call DCW_fnc_endTalking;
    },nil,1,false,true,"","true",2.5,false,""];

};


DCW_fnc_addActionFindChief = {
    params["_unit","_chief"];
    //Try to gather intel
   _unit addAction["<t color='#FF0000'>Where is your chief ?</t>",{
        params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        _chief = (_this select 3) select 0;
        if(alive _chief) then {

            _marker = "localchief";
            if(getMarkerColor "localchief" == "") then {
                _marker = createMarkerLocal ["localchief", getPosWorld _chief];
            };
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "mil_dot";
            _marker setMarkerColorLocal "ColorGreen";
            _marker setMarkerTextLocal "Local chief";
            _marker setMarkerPosLocal (getPosWorld _chief);

            [_unit,format["I marked you the exact position where I last saw %1", name _chief],false] remoteExec ["DCW_fnc_talk",_talker];
        }else{
            [_unit,"Our chief is no more... Fucking war !",false] remoteExec ["DCW_fnc_talk",_talker];
        };
        _this call DCW_fnc_endTalking;
    },[_chief],7,false,true,"","true",3,false,""];
};


DCW_fnc_addActionLeaveGroup = {
     _this addaction ["<t color='#FF0000'>Order him to leave</t>",{
        params["_unit","_talker"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        [_unit,4] remoteExec ["DCW_fnc_updateRep",2];
        _unit remoteExec ["removeAllActions",0];
        [_talker,"gestureGo"] remoteExec ["playActionNow"];
        [_talker,format["%1, You are now free to go ! Thanks for your help",name _unit],false] remoteExec ["DCW_fnc_talk",_talker];
        [_unit,["Well, good bye buddy !","Bye my friend !","Ok, See you in hell.."] call BIS_fnc_selectRandom,false]  remoteExec ["DCW_fnc_talk",_talker];;
        _newGrp = createGroup SIDE_FRIENDLY;
        [_unit] join _newGrp;
        
        [_unit,{
            _pos = [getPos _this, 1000, 1100, 1, 0, 20, 0] call BIS_fnc_findSafePos;
            _this enableAI "MOVE";
            _this stop false;
            _this forceWalk false;
            _this forceSpeed 10;
            _this move _pos;
            waitUntil { isNull _this || _this distance _pos < 10 };
            deleteVehicle _this;
        }] remoteExec ["spawn",owner _unit];

        _this call DCW_fnc_endTalking;
    },nil,8,false,true,"","true",3,false,""];
};

DCW_fnc_addActionLeave = {
     _this addaction ["<t color='#FF0000'>Go away !</t>",{
        params["_unit","_talker"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        [_unit,-3] remoteExec ["DCW_fnc_updateRep",2];
        _unit remoteExec ["removeAllActions",0];
        [_talker,"gestureGo"] remoteExec ["playActionNow"];
        [_talker,"Sorry sir, you must leave now, go away !",false] remoteExec ["DCW_fnc_talk",_talker];

        [_unit,{
            _pos = [getPos _this, 1000, 1100, 1, 0, 20, 0] call BIS_fnc_findSafePos;
            _this enableAI "MOVE";
            _this stop false;
            _this forceWalk false;
            _this forceSpeed 10;
            _this move _pos;
            waitUntil { isNull _this || _this distance _pos < 10};
            deleteVehicle _this;
        }] remoteExec ["spawn",owner _unit];

        _this call DCW_fnc_endTalking;
    },nil,8,false,true,"","true",3,false,""];
};


DCW_fnc_actionRest =  {
    _this addAction ["<t color='#00FF00'>Rest (3 hours)</t>", {
        params["_tent","_unit","_action"];
        if((_unit findNearestEnemy _unit) distance _unit < 100) exitWith { [_unit,"Impossible untill there is enemies around",false] call DCW_fnc_talk;};
        _tent removeAction _action;
        _newObjs = [getPos _unit,getDir _unit, compo_rest ] call BIS_fnc_objectsMapper;
        _camPos = _unit modelToWorld [.3,2.2,2];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.05;
        _cam camCommit 30;
        _unit stop true;
        sleep 2;
        _unit action ["sitdown",_unit];
        sleep 3;
        
        if (!isMultiplayer) then {
            setAccTime 120;
        };

        sleep 25;
        
        if (!isMultiplayer) then {
            setAccTime 1;
            skipTime 3;
        };

        sleep 3;
        [_unit,"Ok, let's go back to work !",false] remoteExec ["DCW_fnc_talk",_unit];
        _unit action ["sitdown",_unit];

        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;

        _unit setFatigue 0;
        _unit setStamina 1;
        _unit enableStamina false;
        _unit enableFatigue false;

        { deleteVehicle _x; }foreach _newObjs;

        sleep 1;
        disableUserInput false;
        sleep 3;

        if (!isMultiplayer) then {
            savegame;
        };

        [_tent,_unit,_action] spawn {
            params["_tent","_unit","_action"];
            sleep 30;
            _unit enableStamina true;
            _unit enableFatigue true;
            sleep 300;
            if (isNull _tent) exitWith {};
            _tent call DCW_fnc_actionRest;
        };
        
    },nil,1,false,true,"","if(vehicle(_this) == _this)then{true}else{false};",15,false,""];
 };

DCW_fnc_actionCorrupt =  {
    _this addAction ["<t color='#000000'>Corrupt him (30min/-100pts)</t>",{
          params["_unit","_talker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
         if (!([GROUP_PLAYERS,100] call DCW_fnc_afford)) exitWith {_this call DCW_fnc_endTalking; [_unit,"You need more money !", false] spawn DCW_fnc_talk;false;};

        //Populate with friendlies
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);
    
        [_talker,"Maybe we could find an arrangement...", false] remoteExec ["DCW_fnc_talk",_talker];

        sleep 1;
        titleCut ["", "BLACK IN", 1];
        [parseText format ["<t font='PuristaBold' size='1.6'>30 minutes later...</t><br/>%1", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

        showCinemaBorder true;
        _camPos = _talker modelToWorld [-1,-0.2,1.9];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _unit disableAI "MOVE";
        titleCut ["", "BLACK OUT", 1];
        sleep 1;
        skipTime .50;
        detach _talker;
        _talker switchMove "";
        sleep 2;
        titleCut ["", "BLACK IN", 4];
        sleep 3;
        _unit stop false;
        _unit enableAI "ALL";
        showCinemaBorder false;
        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;
        
        if(_curr select 17 == "torture") then{ 
            if (!isMultiplayer) then {
                skipTime 6;
            };
		    [_unit,20] remoteExec ["DCW_fnc_updateRep",2];
            [_unit,"I accept the deal...", false] remoteExec ["DCW_fnc_talk",_talker];
            _unit call DCW_fnc_mainObjectiveIntel;
        } else {
            [_unit,"You're wasting your time !", false] remoteExec ["DCW_fnc_talk",_talker];
            [_unit,-10] remoteExec ["DCW_fnc_updateRep",2];
        };

        _unit removeAction _action;
        _this call DCW_fnc_endTalking;

    },nil,1,true,true,"","true",20,false,""];
};

DCW_fnc_actionTorture =  {
    _this addAction ["<t color='#000000'>Torture him (2 hours/Bad reputation)</t>",{
        params["_unit","_talker","_action"];
        //Populate with friendlies
        if (!(_this call DCW_fnc_startTalking)) exitWith {};

        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);
    
		[_unit,-20] remoteExec ["DCW_fnc_updateRep",2];
        [_talker,"I need an answer now !! Little piece of shit !!", false] remoteExec ["DCW_fnc_talk",_talker];

        titleCut ["", "BLACK OUT", 1];
        [parseText format ["<t font='PuristaBold' size='1.6'>2 hours later...</t><br/>%1", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

        sleep 1;

        showCinemaBorder true;
        _camPos = _talker modelToWorld [-1,-0.2,1.9];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _unit disableAI "MOVE";

        titleCut ["", "BLACK IN", 1];
        sleep 1;

        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.0;
        _cam camCommit 0;
        _unit stop true;
        _unit lookAt _talker;
        _talker lookAt _unit;


        // Animation 
        _talker attachTo [_unit,[-0.9,-0.2,0]]; 
        _talker setDir (_talker getRelDir _unit); 
	    _talker switchMove "Acts_Executioner_StandingLoop";
        _talker switchMove "Acts_Executioner_Backhand";
        _unit switchMove "Acts_ExecutionVictim_Backhand";
        [_unit] call DCW_fnc_shout;
        _unit setDamage .5;
        
        sleep 3.6;
        
        // Standing loop
        _unit switchMove "Acts_ExecutionVictim_Loop";
        _talker switchMove "Acts_Executioner_StandingLoop";
        sleep 1;

        // Animation 
        _talker switchMove "Acts_Executioner_Forehand";
        _unit switchMove "Acts_ExecutionVictim_Forehand";
        [_unit] call DCW_fnc_shout;
        _unit setDamage .7;

        sleep 3.6;

        // Standing loop
        _unit switchMove "Acts_ExecutionVictim_Loop";
        _talker switchMove "Acts_Executioner_StandingLoop";

        sleep 1;
      
        titleCut ["", "BLACK OUT", 2];
        sleep 2;
        skipTime .50;
        titleCut ["", "BLACK IN", 4];
        sleep 3;
        _unit stop false;
        _unit enableAI "ALL";
        showCinemaBorder false;
        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;
        detach _talker;
        _talker switchMove "";

        if(_curr select 17 == "torture") then{ 
            if (!isMultiplayer) then {
                skipTime 6;
            };
            _unit removeAction _action;
            [_unit,"I know something ! But stop it ! Please !", false] remoteExec ["DCW_fnc_talk",_talker];
		    [_unit,10] remoteExec ["DCW_fnc_updateRep",2];
            _unit call DCW_fnc_mainObjectiveIntel;
        } else {
            [_unit,"Argh... I've told you, I have no idea where he is... Leave me alone ! Please !", false] remoteExec ["DCW_fnc_talk",_talker];
            [_unit,-10] remoteExec ["DCW_fnc_updateRep",2];
            _unit removeAction _action; 
            removeAllActions _unit;
        };
        _this call DCW_fnc_endTalking;
    },nil,1,true,true,"","true",20,false,""];
};


DCW_fnc_startTalking = {
    params["_unit","_talker","_action"];
     if (_unit getVariable["DCW_talking",false]) exitWith {
         hint "Can't do multiple action at the same time..."; 
        _this spawn {
            sleep 10;
            _this call DCW_fnc_endTalking;
        };
        false;
    };
    _unit setVariable["DCW_talking",true];
    [_unit,[_unit,_talker] call BIS_fnc_dirTo] remoteExec ["setDir",owner _unit];
    [_unit,_talker] remoteExec ["doWatch",owner _unit];
    [_unit,_talker] remoteExec ["lookAt",owner _unit];
    true;
};


DCW_fnc_endTalking = {
    params["_unit","_talker","_action"];
    _unit setVariable["DCW_talking",false,true];
    true;
};
