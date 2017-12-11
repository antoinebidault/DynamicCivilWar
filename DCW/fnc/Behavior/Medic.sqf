/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


RemoveAllActions _this;
_this setVariable["DCW_Medic",true];
removeGoggles _this;
removeHeadgear _this;

_this stop true;

//Heal action
_this addAction["Heal me and my team ! (45 points / 3 hours)",{
    params["_medic","_unit","_action"];
    if ([_unit,45] call fnc_afford) exitWith {false};
    [_unit,"Could you please heal me and my team ?"] call fnc_talk;
    [_medic,"Okay, let's see what you have"] call fnc_talk;
    skipTime 3;
    _medic removeAction _action;
    {_x setDamage 0;_x setFatigue 0; }foreach units (group (_this select 1));
    sleep 1;
    [_medic,"You and your team should go better."] call fnc_talk;
}];
