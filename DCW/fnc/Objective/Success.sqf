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
    [_task, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
    _taskName = (([_task,player] call BIS_fnc_taskDescription) select 0) select 0;
    [player,format["Done : %1",_taskName]] spawn fnc_Talk;
    _objWithTask setVariable["DCW_Task",""];
    _objWithTask getVariable["DCW_MarkerIntel",""] setMarkerColor "ColorGreen";
}else{
    _newTask = [_objWithTask,player,false] call fnc_CreateTask;
    [(_newTask select 0), "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
    [player,(_newTask select 2)] spawn fnc_Talk;
    _task = (_newTask select 0);
};

//Custom callback
[_task,_objWithTask,_objWithTask getVariable["DCW_Bonus",0]] call OBJECTIVE_ACCOMPLISHED;

//Delete the task after success.

_objWithTask setVariable["DCW_Type",""];
_objWithTask setVariable["DCW_IsIntel",false];
_objWithTask setVariable["DCW_IsIntelRevealed",false];

//Remote suppresion of the task
[_task] spawn {
    sleep 20;
    [_this select 0,true] call BIS_fnc_deleteTask;
};


true;