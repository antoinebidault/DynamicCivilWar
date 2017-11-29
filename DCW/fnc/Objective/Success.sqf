/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private _unitWithTask = _this;
private _taskId = "";

if (isNil '_unitWithTask') exitWith{false};
if (isnull _unitWithTask) exitWith{false};
if (_unitWithTask getVariable["DCW_type",""] == "") exitWith { false };

[_unitWithTask getVariable["DCW_task",""],_unitWithTask] spawn OBJECTIVE_ACCOMPLISHED;


if (_unitWithTask getVariable["DCW_task",""] != "") then{
    _taskId = _unitWithTask getVariable["DCW_task",""];
    [_taskId, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
    _unitWithTask setVariable["DCW_task",""];
    _unitWithTask getVariable["DCW_markerIntel",""] setMarkerColor "ColorGreen";
}else{
    _task = [_unitWithTask,player] call fnc_CreateTask;
    [(_task select 0), "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
    player globalChat (_task select 2);   
};

_unitWithTask setVariable["DCW_type",""];
_unitWithTask setVariable["DCW_IsIntel",false];
_unitWithTask setVariable["DCW_IsIntelRevealed",false];
true;