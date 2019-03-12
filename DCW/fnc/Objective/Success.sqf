/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _objWithTask = _this;
private _task = "";
private _taskName = "";

//if (isNil '_unitWithTask') exitWith{false};
//if (isnull _unitWithTask) exitWith{false};

//Task type unknown
if (_objWithTask getVariable["DCW_Type",""] == "") exitWith { false };

//Task already successful
if (!(_objWithTask setVariable["DCW_IsIntel",false])) exitWith {false};


_task = _objWithTask getVariable["DCW_Task",""];
if (_task != "") then{
    [_task, "SUCCEEDED",true] remoteExec ["BIS_fnc_taskSetState"];
    _taskName = (([_task,LEADER_PLAYERS] call BIS_fnc_taskDescription) select 0) select 0;
    [LEADER_PLAYERS,format["Done : %1",_taskName],true] remoteExec ["fnc_Talk"];
    _objWithTask setVariable["DCW_Task",""];
    _objWithTask getVariable["DCW_MarkerIntel",""] setMarkerColor "ColorGreen";
}else{
    _newTask = [_objWithTask,LEADER_PLAYERS,false] remoteExec ["fnc_CreateTask"];
    [(_newTask select 0), "SUCCEEDED",true] remoteExec ["BIS_fnc_taskSetState"];
    [LEADER_PLAYERS,(_newTask select 2),true] remoteExec ["fnc_Talk"];
    _task = (_newTask select 0);
};

//Custom callback
[_task,_objWithTask,_objWithTask getVariable["DCW_Bonus",0]] remoteExec ["OBJECTIVE_ACCOMPLISHED"];

//Delete the task after success.

_objWithTask setVariable["DCW_Type",""];
_objWithTask setVariable["DCW_IsIntel",false];
_objWithTask setVariable["DCW_IsIntelRevealed",false];

//Remote suppresion of the task
[_task] spawn {
    sleep 20;
    [_this select 0,true] remoteExec ["BIS_fnc_deleteTask"];
};


true;