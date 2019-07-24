
 if (isNull player) exitWith{};

_display = uiNamespace getVariable "BIS_dynamicText";
_ctrl = _display displayCtrl 9999;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit .3;
sleep .3;
ctrlDelete _ctrl;
sleep .1;

uiNamespace setVariable ["BIS_dynamicText",displayNull];