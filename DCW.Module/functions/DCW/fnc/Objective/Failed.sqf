/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

private _unitWithTask = _this;

if (isNil '_unitWithTask') exitWith{false};
if (isnull _unitWithTask) exitWith{false};
if (_unitWithTask getVariable["DCW_IsIntelRevealed",false])then{
    _unitWithTask setVariable["DCW_IsIntelRevealed",false];
    deleteMarker(_unitWithTask getVariable["DCW_MarkerIntel",""]);
    [_unitWithTask getVariable["DCW_Task",""], "FAILED",true] remoteExec ["BIS_fnc_taskSetState",GROUP_PLAYERS];

    // Spawn task successful on each client
    [[_unitWithTask getVariable["DCW_Task",""]],{
        params["_task","_taskName","_objWithTask"];
        sleep 20;
        [_task,true] call BIS_fnc_deleteTask;
    }] remoteExec ["spawn", GROUP_PLAYERS,false]; 
};