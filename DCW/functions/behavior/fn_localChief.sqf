/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Add all the actions affected to the compound chief.

  Parameters:
    0: OBJECT - unit

  Returns:
    OBJECT - unit 
*/
params["_unit","_radius"];

_unit remoteExec ["RemoveAllActions",0];
_unit setVariable["DCW_LocalChief",true];
removeGoggles _unit;
removeHeadgear _unit;
_unit allowDamage false;
_unit allowFleeing 0;
_unit addGoggles (["G_Spectacles_Tinted","G_Aviator"] call BIS_fnc_selectRandom);
_unit addHeadgear "H_Beret_blk";


[_unit,["<t color='#cd8700'>Interrogate</t>",{
    params["_unit","_asker","_action"];
    if (!(_this call DCW_fnc_startTalking)) exitWith {};

     //Populate with friendlies
    _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);
   
     _success =_curr select 3;
     _state =_curr select 12;
    
    [_asker,localize "STR_DCW_voices_localchief_tellUsAllYouKnow", false] spawn DCW_fnc_talk;
    _this call DCW_fnc_endTalking; 
    if(_state == "bastion" && !_success) exitWith{ [_unit,localize "STR_DCW_voices_localchief_securePositionFirst", false] spawn DCW_fnc_talk;false;};

    if( _curr select 17 != "hasintel") then{ 
        _sentence = localize (["STR_DCW_voices_localchief_iDontKnow","STR_DCW_voices_localchief_noIdea","STR_DCW_voices_localchief_iWouldntCollaborate"] call BIS_fnc_selectRandom);
        [_unit,_sentence, false] spawn DCW_fnc_talk; 
        [_unit,_action] remoteExec ["removeAction"];
        _unit call DCW_fnc_actionTorture;
        _unit call DCW_fnc_actionCorrupt;
    } else {
        [_unit,_action] remoteExec ["removeAction"];
        _unit call DCW_fnc_mainObjectiveIntel;
    };

},nil,1.5,false,true,"","true",20,false,""]] remoteExec ["addAction"];


[_unit,[format["<t color='#cd8700'>Secure this compound (%1 points, 6 hours)</t>",_radius max 50],{
    params["_unit","_asker","_action","_radius"];
    
    //Server execution
    [[_unit,_asker,_action],{
        params["_unit","_asker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        [_asker,localize "STR_DCW_voices_teamLeader_isItPossibleToSetupBase", false] remoteExec ["DCW_fnc_talk",_asker];
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);
        _success =_curr select 3;
        _radius =_curr select 4;
        
        if(_curr select 12 == "bastion") exitWith{[_unit,localize "STR_DCW_voices_localchief_thisCampIsStillOccupied", false]  remoteExec ["DCW_fnc_talk",_asker];_this call DCW_fnc_endTalking; false;};
        if(_curr select 13 < 70) exitWith{[_unit,format["%1 (70 mini.)",localize "STR_DCW_voices_localchief_youMustImprove"], false]  remoteExec ["DCW_fnc_talk",_asker]; _this call DCW_fnc_endTalking;  false;};
        if (!([GROUP_PLAYERS,_radius max 50] call DCW_fnc_afford)) exitWith {[_unit,localize "STR_DCW_voices_localchief_youNeedMoreMoney", false]  remoteExec ["DCW_fnc_talk",_asker]; _this call DCW_fnc_endTalking; false;};

        // Remove action
        [_unit,_action] remoteExec ["RemoveAction",owner _unit];

        //disableAi
        [_unit,"MOVE"] remoteExec ["disableAI",owner _unit];

        //Talking with the fixed glitch
        _anim = format["Acts_CivilTalking_%1",ceil(random 2)];
        [_unit,_anim] remoteExec ["switchMove", 0];

        [_unit, localize "STR_DCW_voices_localchief_yourHelpIsWelcome", false] remoteExec ["DCW_fnc_talk",_asker];
        [HQ, localize "STR_DCW_voices_HQ_sendingTroops", false] remoteExec ["DCW_fnc_talk",_asker];


        sleep 15;
        
        [_curr] call DCW_fnc_compoundSecured; 
        
        [_unit,""] remoteExec ["switchMove",owner _unit];
        [_unit,"MOVE"] remoteExec ["enableAI",owner _unit];
      
        _this call DCW_fnc_endTalking; 

    }] remoteExec["spawn",2];
},_radius,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_unit,["<t color='#cd8700'>Paradrop a food box (50 points)</t>",{
    params["_unit","_asker","_action"];
    
    //Server execution
    [_this ,{
        params["_unit","_asker","_action"];
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);

        if(_curr select 12 == "bastion") exitWith{[_unit,localize "STR_DCW_voices_localchief_securePositionFirst", false] spawn DCW_fnc_talk; false;};
        if (!([GROUP_PLAYERS,50] call DCW_fnc_afford)) exitWith {[_unit,localize "STR_DCW_voices_localchief_youNeedMoreMoney", false] spawn DCW_fnc_talk;false;};
        [_asker,localize "STR_DCW_voices_teamLeader_aChopperIsComing", false] remoteExec ["DCW_fnc_talk",_asker];
        [_unit,_action] remoteExec ["RemoveAction",owner _unit];
        [_unit,localize "STR_DCW_voices_localchief_thankYou", false] remoteExec ["DCW_fnc_talk",_asker];
        _cratePos = [_curr select 1, 0, _curr select 4, 4, 0, 1, 0] call BIS_fnc_findSafePos;
        [_cratePos,2500,"crate"] spawn DCW_fnc_vehicleLift;
        [_curr, 25, 0] call DCW_fnc_setCompoundSupport;
    }] remoteExec["spawn",2];
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_unit,[format["<t color='#cd8700'>Call in the humanitary assistance (%1 points, 12 hours)</t>",round (_radius * 1.5)],{
  
    //Server execution
    [_this,{
        params["_unit","_asker","_action","_radius"];
         _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);

        private _success =_curr select 3;
        if(_curr select 12 != "massacred") exitWith{[_unit,localize "STR_DCW_voices_localchief_ourVillageDoesNotNeed", false] remoteExec ["DCW_fnc_talk",_asker]; false;};
        if(_curr select 13 < 70) exitWith{[_unit,format["%1 (70 mini.)",localize "STR_DCW_voices_localchief_youMustImprove"], false] remoteExec ["DCW_fnc_talk",_asker]; false;};
        if (!([GROUP_PLAYERS,round (_radius * 1.5)] call DCW_fnc_afford)) exitWith {[_unit,localize "STR_DCW_voices_localchief_youNeedMoreMoney", false] remoteExec ["DCW_fnc_talk",_asker];false;};
      
        [_asker,localize "STR_DCW_voices_teamLeader_wellProvideYou", false] remoteExec ["DCW_fnc_talk",_asker];
        [_curr, "humanitary"] call DCW_fnc_setCompoundState;
        [_curr, 50, 0] call DCW_fnc_setCompoundSupport;

    }] remoteExec["spawn",2];
},round (_radius * 1.5),2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_unit,["<t color='#cd8700'>Gives him a military advisor</t>",{
    
    // Execution on the server only
     [_this,{
         params["_unit","_asker","_action"];
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);
        _state = _curr select 12;

        if (_state != "neutral" && _state != "supporting") exitWith { "This action requires a compound in a neutral state." remoteExec ["hint",_asker]; false;};
        if ({_x getVariable["DCW_advisor",false]} count (units GROUP_PLAYERS) == 0) exitWith { "I need a military advisor first. I can recruit them in already secured camps." remoteExec ["hint",_asker];false;};
        [_asker,localize "STR_DCW_voices_teamLeader_wellProvideYou", false] remoteExec ["DCW_fnc_talk",_asker];
        [_unit,localize "STR_DCW_voices_localchief_thankYou", false] remoteExec ["DCW_fnc_talk",_asker];
        [_unit, _action] remoteExec ["removeAction",owner _unit];
        
        _advisor = objNull;
        {
           if (_x getVariable["DCW_advisor",false]) then {
               _advisor = _x;
           };
        }foreach (units GROUP_PLAYERS);

        [_advisor] joinSilent grpNull;
        [_advisor] joinSilent (group _unit);
        _advisor setVariable["DCW_disable_cache", false, true];

        {
            if ( _x isKindOf "Man" && side _x == SIDE_CIV && _x != _unit) then {
                [_x, SIDE_FRIENDLY] remoteExec ["DCW_fnc_badGuyLoadout", owner _x];
            };
        }
        foreach (_curr select 5);

        [_curr, "resistance"] spawn DCW_fnc_setCompoundState;
        [_curr, 25 + floor(random 10), 0] spawn DCW_fnc_setCompoundSupport; 
    }] remoteExec["spawn",2];

},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];

_unit;

