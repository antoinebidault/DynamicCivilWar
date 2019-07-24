/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/


params ["_text","_time"];

if (isNull player) exitWith{false;};

if (_text == "") then {
	("RscCompoundStatus" call BIS_fnc_rscLayer) cutRsc ["RscCompoundStatus", "PLAIN DOWN", 0];
} else {
	_color = "#e0e0e0"; 
	_structuredText = format ["<t align = 'right' shadow = '2' size = '1'><t color = '%1'>" + _text + "</t></t>",_color];
	("RscCompoundStatus" call BIS_fnc_rscLayer) cutRsc ["RscCompoundStatus","PLAIN"];	
		disableSerialization;
		((uiNamespace getVariable "RscCompoundStatus")displayCtrl 55222) ctrlSetStructuredText parseText _structuredText;
};