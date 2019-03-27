/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _intel = _this select 0;
private _asker = _this select 1;
private _withNotif = if (count _this >2)then{_this select 2}else{true};

 _type = _intel getVariable["DCW_Type",""];
 _taskId = "default";
 _title = "default";
 _desc = "default";
 _message = "default";
 _messageSuccess = "default";
 _bonus = 0;

switch (_type) do {
    case "ied": { 
        _taskId = "IEDdisabling";
        _desc = "disarm the IED on the road. You need to be equiped with a toolkit, a mine detector and engineer abilities.";
        _title = "disarm the IED";
        _message = "I know something about an IED planted on this road. I can mark it on your map.";
        _messageSuccess = "This IED will no more cause trouble.";
        _bonus = 20;
     };
     case "wreck": { 
        _taskId = "WreckInvestigation";
        _desc = "Investigate the crashsite and neutralize the wreck with an explosive charge. This will give you extra credits";
        _title = "Chopper crash site (optional)";
        _message = "There is a chopper crash site in this sector.";
        _messageSuccess = "HQ, we cleaned up the crash site.";
        _bonus = 400;
     };
    case "hostage": {   
         _taskId = "hostage";
        _desc = "Find the hostage and liverate him.";
        _title = "Free the hostage";
        _message = "I know something about a hostage detained in this compound";
        _messageSuccess = "We've liberated a hostage located in this compound.";
        _bonus = 200;
     };
     case "outpost": {   
        _taskId = "outpost";
        _desc = "Clear all units in the outpost.";
        _title = "Clear the outpost";
        _message = "I've located an outpost with a few insurgents here.";
        _messageSuccess = "Outpost clear ! Good job !";
        _bonus = 50;
     };
     case "cache": {   
        _taskId = "cachedestroy";
        _desc = "Find and destroy the insurgent's cache hidden in the building";
        _title = "Destroy the cache";
        _message = "I've located a weapon cache in this building.";
        _messageSuccess = "We have successfully destroyed the cache";
        _bonus = 100;
     };
     case "sniper": {   
        _taskId = "snipers";
        _desc = "A sniper group located here";
        _title = "Kill the snipers";
        _message = "I've located a sniper team in this sector.";
        _messageSuccess = "The sniper team has been eliminated.";
        _bonus = 120;
     };
     case "tank": {   
        _taskId = "tank";
        _desc = "Destroy the tank";
        _title = "Destroy the tank";
        _message = "There is a heavy armor in this sector.";
        _messageSuccess = "Good job ! The tank has been destroyed.";
        _bonus = 200;
     };
      case "mortar": { 
        _taskId = "Mortar";
        _desc = "Destroy the mortar.";
        _title = "Destroy the mortar";
        _message = "There is a mortar position over here !";
        _messageSuccess = "This mortar won't cause any trouble.";
        _bonus = 100;
     };
    default { };
};

//Unique ID added to the task id;
_taskId = format["%1_%2",_taskId,random 20];
[GROUP_PLAYERS,  _taskId, [_desc,_title,_title],(getPos _intel),"CREATED",1,_withNotif,""] remoteExec ["BIS_fnc_taskCreate", GROUP_PLAYERS];
_intel setVariable["DCW_Bonus",_bonus, true];
_intel setVariable["DCW_Task",_taskId, true];
[_taskId,_message,_messageSuccess,_bonus];
