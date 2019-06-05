/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


_this remoteExec ["RemoveAllActions",0];
_this setVariable["DCW_LocalChief",true];
removeGoggles _this;
removeHeadgear _this;
_this allowDamage false;
_this allowFleeing 0;
_this addGoggles (["G_Spectacles_Tinted","G_Aviator"] call BIS_fnc_selectRandom);
_this addHeadgear "H_Beret_blk";


[_this,["<t color='#666000'>Interrogate</t>",{
    params["_unit","_asker","_action"];
     //Populate with friendlies
    _curr = ([position _unit,false] call fnc_findNearestMarker);
   
     _success =_curr select 3;
     _state =_curr select 12;
    
    [_asker,"Tell us all you know about the insurgent commander !", false] spawn fnc_talk;
    if(_state == "bastion" && !_success) exitWith{ [_unit,"Secure our position first", false] spawn fnc_talk; false;};

        if( _curr select 17 != "hasintel") then{ 
            _sentence = ["I don't know where he is...","I have no idea...","I wouldn't collaborate... This is too dangerous for my family..."] call BIS_fnc_selectRandom;
            [_unit,_sentence, false] spawn fnc_talk; 
            _unit removeAction _action; 
            _unit call fnc_actionTorture;
            _unit call fnc_actionCorrupt;
        } else {
            _unit removeAction _action;
            _unit call fnc_MainObjectiveIntel;
        };

},nil,1.5,false,true,"","true",20,false,""]] remoteExec ["addAction"];




[_this,["<t color='#666000'>Secure this compound (200 points, 6 hours)</t>",{
    params["_unit","_asker","_action"];
    
    //Server execution
    [[_unit,_asker,_action],{
        params["_unit","_asker","_action"];
        [_asker,"Is it possible to set up our camp here ?", false] spawn fnc_talk;
        _curr = ([position _unit,false] call fnc_findNearestMarker);

        private _success =_curr select 3;
        if(_curr select 12 == "bastion") exitWith{[_unit,"This camp is still occupied by enemy forces, clean up the compound to make this compound available.", false] spawn fnc_talk; false;};
        if(_curr select 13 < 70) exitWith{[_unit,"Improve your reputation first (70 minimum)", false] spawn fnc_talk; false;};
        if (!([GROUP_PLAYERS,200] call fnc_afford)) exitWith {[_unit,"You need more money !", false] spawn fnc_talk;false;};

        _unit RemoveAction _action;

        //disableAi
        _unit disableAI "MOVE";

        //Talking with the fixed glitch
        _anim = format["Acts_CivilTalking_%1",ceil(random 2)];
        [_unit,_anim] remoteExec ["switchMove", 0];
        _unit doWatch _asker;
        _asker doWatch _unit;

        [_unit,"You're welcome here ! We need help. You can set up your camp here.", false] remoteExec ["fnc_talk"];
        [HQ,"Okay, we're sending you some reinforcements", false]  remoteExec ["fnc_talk"];
        
        _units = _unit call fnc_compoundSecured; 
        //Execute a little animation
        [[_asker, (_units select { typeOf _x == FRIENDLY_FLAG }) select 0 ],{ 
            params["_asker","_flag"];
            
            showCinemaBorder true;
            _camPos = _asker modelToWorld [-1,-0.2,1.9];
            _cam = "camera" camcreate _camPos;
            _cam cameraeffect ["internal", "back"];
            _cam camSetPos _camPos;
            _cam camSetTarget _unit;
            _cam camSetFov 1.0;
            _cam camCommit 0;
            
            _cam camSetPos (_unit modelToWorld [-1,-0.2,1.9]);
            _cam camSetTarget _asker;
            titleCut ["6 hours later...", "BLACK OUT", 3];
            sleep 3;
            titleCut ["6 hours later...", "BLACK FADED", 999];
            
            if (!isMultiplayer) then {
                skipTime 6;
            };

            sleep 1;
            titleCut ["6 hours later...", "BLACK IN", 4];
            
            _flag = (_units select { typeOf _x == FRIENDLY_FLAG }) select 0;
            
            _cam camSetPos (_flag modelToWorld [-10,-0.2,2.9]); 
            _cam camSetTarget  (_flag modelToWorld [0,0,5]); 
            _cam camCommit 0;
            _cam camSetFov 1;
            _cam camSetPos (_flag modelToWorld [-20,-0.2,3.2]);
            _cam camCommit 10;
            sleep 10;

            showCinemaBorder false;
            _cam cameraeffect ["terminate", "back"];
            camDestroy _cam;

        }] remoteExec["spawn"];
        _unit switchMove "";
        _unit enableAI "MOVE";

    }] remoteExec["spawn",2];
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_this,["<t color='#666000'>Paradrop a food box (50 points)</t>",{
    params["_unit","_asker","_action"];
    
    //Server execution
    [[_unit,_asker,_action],{
        params["_unit","_asker","_action"];
        _curr = ([position _unit,false] call fnc_findNearestMarker);

        if(_curr select 12 == "bastion") exitWith{[_unit,"Secure our position first...", false] spawn fnc_talk; false;};
        if (!([GROUP_PLAYERS,50] call fnc_afford)) exitWith {[_unit,"You need more money !", false] spawn fnc_talk;false;};

        _unit RemoveAction _action;
        [_unit,"Thank you so much for your help !", false] spawn fnc_talk;
        _cratePos = [_curr select 1, 0, _curr select 4, 4, 0, 20, 0] call BIS_fnc_FindSafePos;
        [_cratePos,1500,"crate"] execVM "DCW\supportui\fnc\VehicleLift.sqf";
        [_curr, 25, 0] call fnc_setCompoundSupport;
        
    }] remoteExec["spawn",2];
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_this,["<t color='#666000'>Call in the humanitary assistance (300 points, 12 hours)</t>",{
    params["_unit","_asker","_action"];
    
    //Server execution
    [[_unit,_asker,_action],{
        params["_unit","_asker","_action"];
        [_asker,"Do you need assistance ?", false] call fnc_talk;
        _curr = ([position _unit,false] call fnc_findNearestMarker);

        private _success =_curr select 3;
        if(_curr select 12 != "massacred") exitWith{[_unit,"Our village does not need any help...", false] spawn fnc_talk; false;};
        if(_curr select 13 < 70) exitWith{[_unit,"Improve your reputation first (70 minimum)", false] spawn fnc_talk; false;};
        if (!([GROUP_PLAYERS,200] call fnc_afford)) exitWith {[_unit,"You need more money !", false] spawn fnc_talk;false;};
        
        [_curr, "humanitary"] call fnc_setCompoundState;
        [_curr, 50, 0] call fnc_setCompoundSupport;

    }] remoteExec["spawn",2];
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];


[_this,["<t color='#666000'>Gives him a military advisor</t>",{
    params["_unit","_asker","_action"];
    
        params["_unit","_asker","_action"];

         if ({_x getVariable["DCW_advisor",false]} count (units GROUP_PLAYERS) == 0) exitWith {[_asker,"I need a military advisor first. I can recruit them in already secured camps.",false] call fnc_talk;false;};
        [_asker,"We'll provide you an army advisor for helping you to defend against insurgents.", false] call fnc_talk;
        [_unit,"Thanks for your help !", false] call fnc_talk;
        _unit RemoveAction _action;
        
        _advisor = objNull;
        {
           if (_x getVariable["DCW_advisor",false]) then {
               _advisor = _x;
           };
        }foreach (units GROUP_PLAYERS);

        [_advisor] joinSilent grpNull;
        [_advisor] joinSilent (group _unit);

        _curr = ([position _unit,false] call fnc_findNearestMarker);

        {
            if (side _x == SIDE_CIV && _x != _unit) then {
                [_x, SIDE_FRIENDLY] call fnc_BadGuyLoadout;
            };
        }
        foreach _curr select 5;

        [_curr, "supporting"] call fnc_setCompoundState;
        [_curr, 30, 0] call fnc_setCompoundSupport;

},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", 0, true];




