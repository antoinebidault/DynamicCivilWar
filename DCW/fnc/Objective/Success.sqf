/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _objWithTask = _this;
private _task = "";
private _taskName = "";

//Task type unknown
if (_objWithTask getVariable["DCW_Type",""] == "") exitWith { false };

//Task already successful
if (!(_objWithTask setVariable["DCW_IsIntel",false])) exitWith {false};

_task = _objWithTask getVariable["DCW_Task",""];

// Silently create a task if not exists
if (_task == "") then {
    [_objWithTask,(leader GROUP_PLAYERS),false] call fnc_CreateTask;
    _task = _objWithTask getVariable["DCW_Task",""];
};

// Spawn task successful on each client
[[_task,_objWIthTask],{
    params["_task","_objWithTask"];

    _taskName = ((_task call BIS_fnc_taskDescription) select 1) select 0;
    [_task, "SUCCEEDED",true] call BIS_fnc_taskSetState;
    [(leader GROUP_PLAYERS), format["Task done : %1",_taskName],true] call fnc_Talk;
    _objWithTask setVariable["DCW_Task","", true];
    _objWithTask getVariable["DCW_MarkerIntel",""] setMarkerColor "ColorGreen";

     sleep 20;
     
    [_task,true] call BIS_fnc_deleteTask;

}] remoteExec ["spawn", GROUP_PLAYERS,false];

//Custom callback
[_task,_objWithTask,_objWithTask getVariable["DCW_Bonus",0]] call OBJECTIVE_ACCOMPLISHED;

//Delete the task after success.
_objWithTask setVariable["DCW_Type",""];
_objWithTask setVariable["DCW_IsIntel",false];
_objWithTask setVariable["DCW_IsIntelRevealed",false];

true;