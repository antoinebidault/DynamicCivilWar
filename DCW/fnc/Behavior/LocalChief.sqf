/*
  Author: 
    Bidass

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
    
    [_asker,"Tell us all you know about the insurgent commander !", false] call DCW_fnc_talk;
    _this call DCW_fnc_endTalking; 
    if(_state == "bastion" && !_success) exitWith{ [_unit,"Secure our position first", false] call DCW_fnc_talk;false;};

    if( _curr select 17 != "hasintel") then{ 
        _sentence = ["I don't know where he is...","I have no idea...","I wouldn't collaborate... This is too dangerous for my family..."] call BIS_fnc_selectRandom;
        [_unit,_sentence, false] call DCW_fnc_talk; 
        _unit removeAction _action; 
        _unit call DCW_fnc_actionTorture;
        _unit call DCW_fnc_actionCorrupt;
    } else {
        _unit removeAction _action;
        _unit call DCW_fnc_mainObjectiveIntel;
    };

},nil,1.5,false,true,"","true",20,false,""]] remoteExec ["addAction"];


[_unit,[format["<t color='#cd8700'>Secure this compound (%1 points, 6 hours)</t>",_radius max 50],{
    params["_unit","_asker","_action","_radius"];
    
    //Server execution
    [[_unit,_asker,_action],{
        params["_unit","_asker","_action"];
        if (!(_this call DCW_fnc_startTalking)) exitWith {};
        [_asker,"Is it possible to set up our camp here ?", false] remoteExec ["DCW_fnc_talk",_asker];
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);
        _success =_curr select 3;
        _radius =_curr select 4;
        
        if(_curr select 12 == "bastion") exitWith{[_unit,"This camp is still occupied by enemy forces, clean up the compound to make this compound available.", false]  remoteExec ["DCW_fnc_talk",_asker];_this call DCW_fnc_endTalking; false;};
        if(_curr select 13 < 70) exitWith{[_unit,"Improve your reputation first (70 minimum)", false]  remoteExec ["DCW_fnc_talk",_asker]; _this call DCW_fnc_endTalking;  false;};
        if (!([GROUP_PLAYERS,_radius max 50] call DCW_fnc_afford)) exitWith {[_unit,"You need more money !", false]  remoteExec ["DCW_fnc_talk",_asker]; _this call DCW_fnc_endTalking; false;};

        _unit RemoveAction _action;

        //disableAi
        _unit disableAI "MOVE";

        //Talking with the fixed glitch
        _anim = format["Acts_CivilTalking_%1",ceil(random 2)];
        [_unit,_anim] remoteExec ["switchMove", 0];
        _unit doWatch _asker;
        _asker doWatch _unit;

        [_unit,"You're welcome here ! We need your help.", false] remoteExec ["DCW_fnc_talk",_asker];
        [HQ,"Okay, we're sending you some reinforcements", false] remoteExec ["DCW_fnc_talk",_asker];
        sleep 15;
        
        [_curr] remoteExec ["DCW_fnc_compoundSecured",2]; 
        
        _unit switchMove "";
        _unit enableAI "MOVE";
        _this call DCW_fnc_endTalking; 

    }] remoteExec["spawn",2];
},_radius,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_unit,["<t color='#cd8700'>Paradrop a food box (50 points)</t>",{
    params["_unit","_asker","_action"];
    
    //Server execution
    [_this ,{
        params["_unit","_asker","_action"];
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);

        if(_curr select 12 == "bastion") exitWith{[_unit,"Secure our position first...", false] spawn DCW_fnc_talk; false;};
        if (!([GROUP_PLAYERS,50] call DCW_fnc_afford)) exitWith {[_unit,"You need more money !", false] spawn DCW_fnc_talk;false;};

        _unit RemoveAction _action;
        [_unit,"Thank you so much for your help !", false] remoteExec ["DCW_fnc_talk",_asker];
        _cratePos = [_curr select 1, 0, _curr select 4, 4, 0, 1, 0] call BIS_fnc_findSafePos;
        [_cratePos,2500,"crate"] execVM  "DCW\fnc\supportui\VehicleLift.sqf";
        [_curr, 25, 0] call DCW_fnc_setCompoundSupport;
    }] remoteExec["spawn",2];
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_unit,[format["<t color='#cd8700'>Call in the humanitary assistance (%1 points, 12 hours)</t>",round (_radius * 1.5)],{
  
    //Server execution
    [_this,{
        params["_unit","_asker","_action","_radius"];
        [_asker,"Do you need assistance ?", false] remoteExec ["DCW_fnc_talk",_asker];
        _curr = ([position _unit,false,"any"] call DCW_fnc_findNearestMarker);

        private _success =_curr select 3;
        if(_curr select 12 != "massacred") exitWith{[_unit,"Our village does not need any help...", false] remoteExec ["DCW_fnc_talk",_asker]; false;};
        if(_curr select 13 < 70) exitWith{[_unit,"Improve your reputation first (70 minimum)", false] remoteExec ["DCW_fnc_talk",_asker]; false;};
        if (!([GROUP_PLAYERS,round (_radius * 1.5)] call DCW_fnc_afford)) exitWith {[_unit,"You need more money !", false] remoteExec ["DCW_fnc_talk",_asker];false;};
        
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

        if (_state != "neutral") exitWith {[_unit,"This action requires a compound neutral state",false] remoteExec ["DCW_fnc_talk",_asker]; false;};
        if ({_x getVariable["DCW_advisor",false]} count (units GROUP_PLAYERS) == 0) exitWith {[_asker,"I need a military advisor first. I can recruit them in already secured camps.",false] remoteExec ["DCW_fnc_talk",_asker];false;};
        [_asker,"We'll provide you an army advisor for helping you to defend against insurgents.", false] remoteExec ["DCW_fnc_talk",_asker];
        [_unit,"Thanks for your help !", false] remoteExec ["DCW_fnc_talk",_asker];
        [_unit, _action] remoteExec ["removeAction",owner _unit];
        
        _advisor = objNull;
        {
           if (_x getVariable["DCW_advisor",false]) then {
               _advisor = _x;
           };
        }foreach (units GROUP_PLAYERS);

        [_advisor] joinSilent grpNull;
        [_advisor] joinSilent (group _unit);

        {
            if ( _x isKindOf "Man" && side _x == SIDE_CIV && _x != _unit) then {
                [_x, SIDE_FRIENDLY] remoteExec ["DCW_fnc_badGuyLoadout", owner _x];
            };
        }
        foreach (_curr select 5);

        [_curr, "supporting"] call DCW_fnc_setCompoundState;
        [_curr, 30, 0] call DCW_fnc_setCompoundSupport;
    }] remoteExec["spawn",2];

},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];



_unit;

