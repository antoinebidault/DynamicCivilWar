
disableSerialization;

createDialog "building_Dialog";
waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;
{
    _ctrl lbAdd format ["%1 : %2 points", getText (configFile >> "CfgVehicles" >>  _x select 1 >> "displayName"), _x select 0];
    _ctrl lbSetPicture [_foreachIndex, getText (configFile >> "CfgVehicles" >>  _x select 1 >> "editorPreview")];
} forEach BUILD_ITEMS;

// Set current selection as 0
_ctrl lbSetCurSel 0;

// Handle selection
((findDisplay 9999) displayCtrl 1500) ctrlAddEventHandler ['LBSelChanged', {
    _index = lbCurSel 1500;
    _price = (BUILD_ITEMS select _index) select 0;
    ctrlSetText [1600, format["Buy item (- %1 points/%2)",str _price, str DCW_SCORE] ];
}];