private _unitWithTask = _this;

if (isNil '_unitWithTask') exitWith{false};
if (isnull _unitWithTask) exitWith{false};
if (_unitWithTask getVariable["IH_IsIntelRevealed",false])then{
    _unitWithTask setVariable["IH_IsIntelRevealed",false];
    deleteMarker(_unitWithTask getVariable["IH_markerIntel",""]);
    [_unitWithTask getVariable["IH_task",""], "FAILED",true] spawn BIS_fnc_taskSetState;
};