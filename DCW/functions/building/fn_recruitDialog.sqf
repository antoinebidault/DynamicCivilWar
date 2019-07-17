
disableSerialization;

createDialog "recruit_Dialog";
waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;
{
    _ctrl lbAdd format ["%1 : %2 points", getText (configFile >> "CfgVehicles" >>  _x >> "displayName"), _x call DCW_fnc_getUnitCost ];
    _ctrl lbSetPicture [_foreachIndex, getText (configFile >> "CfgVehicles" >>  _x >> "editorPreview")];
} forEach FRIENDLY_LIST_UNITS;

// Set current selection as 0
_ctrl lbSetCurSel 0;

// Handle selection
((findDisplay 9999) displayCtrl 1500) ctrlAddEventHandler ['LBSelChanged', {
    _index = lbCurSel 1500;
    _price = (FRIENDLY_LIST_UNITS select _index) call DCW_fnc_getUnitCost;
    ctrlSetText [1600, format["Recruit soldier (- %1 points/%2)",str _price , str DCW_SCORE] ];
}];