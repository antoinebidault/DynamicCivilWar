/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private _unitWithTask = _this;
private _task = "";

if (isNil '_unitWithTask') exitWith{false};
if (isnull _unitWithTask) exitWith{false};


//Task type unknown
if (_unitWithTask getVariable["DCW_type",""] == "") exitWith { false };

//Task already successful
if (!(_unitWithTask setVariable["DCW_IsIntel",false])) exitWith {false};

[_unitWithTask getVariable["DCW_task",""],_unitWithTask] spawn OBJECTIVE_ACCOMPLISHED;


if (_unitWithTask getVariable["DCW_task",""] != "") then{
    _task = _unitWithTask getVariable["DCW_task",""];
    [_task, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
    _unitWithTask setVariable["DCW_task",""];
    _unitWithTask getVariable["DCW_markerIntel",""] setMarkerColor "ColorGreen";
}else{
    _newTask = [_unitWithTask,player,false] call fnc_CreateTask;
    [(_newTask select 0), "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
    [player,(_newTask select 2)] call fnc_Talk;
    _task = (_newTask select 0);
};

//Delete the task after success.
[_task,true] call BIS_fnc_deleteTask;

_unitWithTask setVariable["DCW_type",""];
_unitWithTask setVariable["DCW_IsIntel",false];
_unitWithTask setVariable["DCW_IsIntelRevealed",false];
true;