/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Add all the actions affected to the compound's medic.

  Parameters:
    0: OBJECT - unit

  Returns:
    OBJECT - unit 
*/
_this remoteExec ["RemoveAllActions",0];

_this setVariable["DCW_Medic",true];
_this setUnitTrait ["Medic",true];

removeGoggles _this;
removeHeadgear _this;

_this stop true;

//Heal action
[_this, ["<t color='#cd8700'>Heal me and my team ! (45 points / 3 hours)</t>",{
    params["_medic","_unit","_action"];
    if ([GROUP_PLAYERS,45] call DCW_fnc_afford) exitWith {false};

    [_unit,"Could you please heal me and my team ?", false] call DCW_fnc_talk;
    [_medic,"Ok, i'm gonna examinate you...", false] call DCW_fnc_talk;

    if (!isMultiplayer) then {
        skipTime 3;
    };

    _medic removeAction _action;

    { 
        _x setDamage 0; 
        _x setFatigue 0; 
        if (ACE_ENABLED) then {
        	[objNull, _x] call ace_medical_DCW_fnc_treatmentAdvanced_fullHealLocal;
        };
    } foreach units (group (_unit));

    [_medic , "medic"] remoteExec ["playActionNow"];
    sleep 1;
    [_medic,"You and your team should go better.", false] call DCW_fnc_talk;

},nil,1.5,false,true,"","true",3,false,""]] remoteExec ["addAction"];
