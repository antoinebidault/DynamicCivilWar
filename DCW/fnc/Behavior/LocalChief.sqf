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

_this addGoggles (["G_Spectacles_Tinted","G_Aviator"] call BIS_fnc_selectRandom);
_this addHeadgear "H_Beret_blk";

[_this,["Interrogate",{
    params["_unit","_asker","_action"];
     //Populate with friendlies
    _curr = ([position _unit,false] call fnc_findNearestMarker);
   
    private _success =_curr select 3;
    
    [_asker,"Tell us all you know about the commander !", false] call fnc_talk;

     if(!_success) exitWith{[_unit,"Secure our position first", false] spawn fnc_talk;false;};

    _unit RemoveAction (_this select 2);
    _unit call fnc_MainObjectiveIntel;
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction"];

[_this,["Set up a base here (200 points, 6 hours)",{
    params["_unit","_asker","_action"];
    
    //Server execution
    [[_unit,_asker,_action],{
        params["_unit","_asker","_action"];
        [_asker,"Is it possible to set up our camp here ?", false] call fnc_talk;
        _curr = ([position _unit,false] call fnc_findNearestMarker);

        private _success =_curr select 3;
        if(!_success) exitWith{[_unit,"Secure our position first", false] spawn fnc_talk; false;};
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
        
        //Execute a little animation
        [{ 
            
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
            
            [_unit] remoteExec["fnc_compoundSecured", 2]; 
            
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
        }] remoteExec["spawn",0];
        _unit switchMove "";
        _unit enableAI "MOVE";

    }] remoteExec["spawn",2];
},nil,2.5,false,true,"","true",20,false,""]] remoteExec ["addAction", GROUP_PLAYERS, true];
