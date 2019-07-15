
disableSerialization;

createDialog "building_Dialog";
waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;
{
    _ctrl lbAdd format ["%1 - %2", _x select 0, _x select 1];
} forEach BUILD_ITEMS;


((findDisplay 9999) displayCtrl 1500) ctrlAddEventHandler ['LBSelChanged', {
_index = lbCurSel 1500;
_picture = getText (configFile >> "CfgVehicles" >> ((BUILD_ITEMS select _index) select 2) >> "editorPreview");
ctrlSetText [1502, _picture];

}]