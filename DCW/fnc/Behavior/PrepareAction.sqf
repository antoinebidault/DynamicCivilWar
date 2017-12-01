/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


//Menote le mec;
addActionHandcuff =  {
    _this addAction["Capture him",{
        _man  = (_this select 0);
        _man removeAllEventHandlers "FiredNear";
        _man  setVariable["civ_affraid",false];
        _man switchMove "";
        // (_this select 1)  action ["WeaponOnBack",  _this select 1];
        (_this select 1) playActionNow "PutDown";
        _man SetBehaviour "CARELESS";
        _man setCaptive true;
        [_man,-30] call fnc_updateRep;

        _rifle = primaryWeapon _man; //get the officers primary weapon
        if (_rifle != "") then {
        _man action ["dropWeapon", _man, _rifle]; //drop weapon animation (doesn't actually remove the weapon)
        waitUntil {animationState _man == "amovpercmstpsraswrfldnon_ainvpercmstpsraswrfldnon_putdown" || time > 3}; //waituntil drop weapon animation is complete
        removeAllWeapons _man; //remove all the officers weapons
        };

        _pistol = handgunWeapon _man; //get the officers primary weapon
        if (_pistol != "") then {
            _man action ["dropWeapon", _man, _pistol]; //drop weapon animation (doesn't actually remove the weapon)
            waitUntil {animationState _man == "amovpercmstpsraswrfldnon_ainvpercmstpsraswrfldnon_putdown" || time > 3}; //waituntil drop weapon animation is complete
            removeAllWeapons _man; //remove all the officers weapons
        };

        _man action ["Surrender", _man]; //play the surrender animation
        _man disableai "ANIM"; //disable animation so he doesnt move
        _man disableAI "MOVE"; //disable move so he doesnt run away

        removeAllActions _man;

        _man call addActionLiberate;
        _man call addActionLookInventory;
        hint "Civilian captured";	   
        [_man] call CIVIL_CAPTURED;

    },nil,1.5,true,true,"","true",3,false,""];
};

addActionLiberate =  {
    _this addAction["Liberate him",{
        _man  = (_this select 0);
        (_this select 1) playActionNow "PutDown";
        [_man] call fnc_handlefiredNear;
        [_man] call fnc_addCivilianAction;
        (_this select 0) SetBehaviour "AWARE";
        (_this select 0) setCaptive false;
        _man switchMove ""; 
        _man enableai "ANIM"; 
        _man enableai "MOVE"; 
        [_man,10] call fnc_updateRep;
    },nil,1.5,true,true,"","true",3,false,""];
};

addActionLookInventory = {
    _this addAction["Search in gear",{
        _unit = (_this select 0);
        _human = (_this select 1);
        if (_unit getVariable["DCW_suspect",false])then{
            _unit addItem "IEDLandSmall_Remote_Mag";
            [_human,"Holy shit ! This man is carrying an IED !"];
            [_unit,4] call fnc_updateRep;   
            [_unit,30] call fnc_updateScore;   
        }else{
            [_unit,-2] call fnc_updateRep;   
        };

        if (alive _unit) then {
            _human action ["Gear", _unit];
        };
    },nil,1.5,true,true,"","true",3,false,""];
};

addActionHalt = {
    _this addAction["Say hello",{
        params["_unit","_asker","_action"];
        _asker playActionNow "GestureFreeze";
        [_asker,"Hello sir !"] call fnc_Talk;
        if (!weaponLowered _asker) exitWith { 
            [_unit,"I don't talk to somebody pointing his gun on me ! Go away !"] call fnc_Talk;
            _unit playActionNow "gestureNo";
            [_asker,"I'm sorry, sir !"] call fnc_Talk;
            [_unit,-7] call fnc_updateRep;
            [] call CIVIL_DISRESPECT;
            false; 
        };
        
        _unit removeAction _action;
        _unit doWatch _asker;
        sleep 1;
        _unit stop true;
        _unit playActionNow "GestureHi";
        [_unit,format["Hi ! My name is %1.", name _unit]] call fnc_Talk;
        sleep 1.5;
        _unit disableAI "MOVE";
        sleep 30;
        _unit stop false;
        _unit enableAI "MOVE";
        _unit call addActionHalt;
    },nil,1.5,true,true,"","true",20,false,""];
};

addActionDidYouSee = {
    //Try to gather intel
    _this addAction["Did you see anything recently ?",{
    params["_unit","_talker","_action"];
        _unit removeAction _action;

        if (_unit getVariable["DCW_friendliness",50] < 40) exitWith {
            [_unit,-15] call fnc_updateRep;
            [_unit,"Don't talk to me !"] call fnc_Talk;
            false;
        };
        
        [_talker,"Did you see anything recently ?"] call fnc_Talk;
        private _data = _unit targetsQuery [objNull,ENEMY_SIDE, "", [], 0];
        sleep 1;
        _data = _data select {side group (_x select 1) == ENEMY_SIDE};
        if (count _data == 0) exitWith {
            [_unit, "I saw nothing..."] call fnc_Talk;
        };
        if (count _data > 3) then { _data = [_data select 0] + [_data select 1] + [_data select 2];};
        
        [_unit,format["I saw %1 enemies...",count _data]] call fnc_Talk;
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
                [_unit, format["I saw a %1 %2 %3km away, %4minutes ago ", _type,_compass,_nbMeters,ceil((_x select 5)/60)]] call fnc_Talk;
                _marker = createMarkerLocal [format["enemyviewed-%1", random 50], position _enemy];
                _marker setMarkerShapeLocal "ICON";
                _marker setMarkerTypeLocal "mil_dot";
                _marker setMarkerColorLocal "ColorRed";
                _marker setMarkerTextLocal format["%1", _type];
                _markers pushback _marker;
                sleep .3;
            };
        } forEach _data;

        [_unit,"I marked their positions on your map. Help us please !"] call fnc_Talk;
        [_unit,15] call fnc_updateRep;
        [_talker,"Thanks a lot !"] call fnc_Talk;
        [_unit,"You're welcome !"] call fnc_Talk;
        sleep 240;
        { deleteMarker _x; }foreach _markers;
        if (alive _unit) then {
            _unit call addActionDidYouSee;
        };
    },nil,1.5,true,true,"","true",3,false,""];
};


    

AddActionFeeling = {
    //Try to gather intel
    _this addAction[format["What's your feeling about the %1's presence in %2",getText(configfile >> "CfgFactionClasses" >> format["%1",faction player] >> "displayName"),worldName] ,{
        params["_unit","_talker","_action"];
            [_unit,1] call fnc_updateRep;
            _unit removeAction _action;
            _message = "No problem, if you stay calm";
            if (CIVIL_REPUTATION  < 10) then {
                _message = "Go away, before I call all my friends to kick your ass!";
            }else{
                if (CIVIL_REPUTATION  < 20) then {
                _message = "You crossed a line... I would never help you ! ";
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

            [_unit,_message] call fnc_Talk;
            sleep 120;
            _unit call AddActionFeeling;

        },nil,1.5,true,true,"","true",3,false,""];
};



addActionGetIntel = {
    //Try to gather intel
   _this addAction["Gather intel (15 minutes)",{
       params["_unit","_talker","_action"];

         if (_unit getVariable["DCW_friendliness",50] < 35) exitWith {
            [_unit,-12] call fnc_updateRep;
           [_unit,"Don't talk to me !"] call fnc_Talk;
           false;
        };

        _unit removeAction _action;
        if (!weaponLowered _talker)then{
            _talker  action ["WeaponOnBack", _talker];
        };
        showCinemaBorder true;
        _camPos = _talker modelToWorld [-1,-0.2,1.9];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.0;
        _cam camCommit 0;
        _unit stop true;
        _unit lookAt _talker;
        _talker lookAt _unit;

        sleep 1;

        _unit disableAI "MOVE";
        _unit switchMove format["Acts_CivilTalking_%1",ceil(random 2)];
        titleCut ["15 minutes later...", "BLACK OUT", 1];

        sleep 1;

        skipTime .25;

        sleep 4;

        titleCut ["15 minutes later...", "BLACK IN", 4];
        _res = [_unit,_talker] call fnc_GetIntel;
        [_unit,(_res select 1)] call fnc_Talk;
        showCinemaBorder false;
        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;
        [_unit,30] call fnc_updateRep;
        sleep 10;
        _unit enableAI "MOVE";
    },nil,1.5,true,true,"","true",3,false,""];
};


addActionRally = {
    //Try to make him a friendly
   _this addAction["Try to rally (30 minutes)",{
       params["_unit","_talker","_action"];
       _unit removeAction _action;
        showCinemaBorder true;
        _camPos = _talker modelToWorld [-1,-0.2,1.9];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.0;
        _cam camCommit 0;
        _unit stop true;
        _unit lookAt _talker;
        _talker lookAt _unit;
        sleep 1;
        _unit disableAI "MOVE";
        titleCut ["30 minutes later...", "BLACK OUT", 1];
        sleep 1;
        skipTime .50;
        sleep 2;
        titleCut ["30 minutes later...", "BLACK IN", 4];
        sleep 3;
        _unit stop false;
        _unit enableAI "ALL";
        showCinemaBorder false;
        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;

       if(random 100 < PERCENTAGE_FRIENDLY_INSURGENTS) then {
            [_unit,"Ok, I'm in !"] call fnc_Talk;
            [_unit,SIDE_CURRENT_PLAYER] call fnc_BadBuyLoadout;
            [_unit,50] call fnc_updateRep;
            sleep 5;
            [_unit] joinSilent group(_talker);
        }else{
            [_unit,"No thanks..."] call fnc_Talk;
            [_unit,- round(random 15) ] call fnc_updateRep;
        };
    },nil,1.5,true,true,"","true",3,false,""];
};



addActionFindChief = {
    params["_unit","_chief"];
    //Try to gather intel
   _unit addAction["Where is your chief ?",{
        params["_unit","_talker","_action"];
        _chief = (_this select 3) select 0;
        if(alive _chief)then{
            [_unit,format["I marked you the exact position where I last saw %1", name _chief]] call fnc_Talk;
            _marker = createMarkerLocal [format["chief-%1", random 50], getPosWorld _chief];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "mil_dot";
            _marker setMarkerColorLocal "ColorGreen";
            _marker setMarkerTextLocal "LocalChief";
        }else{
            [_unit,"Our chief is no more... Fucking war !"] call fnc_Talk;
        };
    },[_chief],1.5,true,true,"","true",3,false,""];
};


addActionLeave = {
    _this addAction["Go away !",{
        params["_unit","_asker"];
        [_unit,-3] call fnc_updateRep;
        RemoveAllActions _unit;
        _asker playActionNow "gestureGo";
        [_asker,"Sorry sir, you must leave now, go away !"] call fnc_Talk;
        _pos = [getPos _unit, 1000, 1100, 1, 0, 20, 0] call BIS_fnc_findSafePos;
        _unit stop false;
        _unit forceWalk false;
        _unit forceSpeed 10;
        _unit move _pos;
    }];
};

