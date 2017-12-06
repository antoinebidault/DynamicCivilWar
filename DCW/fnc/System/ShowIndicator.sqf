/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


params ["_text"];

// Create display and control
disableSerialization;
titleRsc ["RscDynamicText", "PLAIN"];
private "_display";
waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
private _ctrl = _display displayCtrl 9999;
uiNamespace setVariable ["BIS_dynamicText", displayNull];
private _ctrlBackground = _display ctrlCreate ["RscText",99999];

// Position control
private _w = 0.2 * safeZoneW;
private _x = safeZoneX + (0.10 * safeZoneW );
private _y = safeZoneY + (0.10 * safeZoneH);
private _h = safeZoneH;

_ctrl ctrlSetPosition [_x,_y,_w,_h];

// Hide control
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0;

// Show subtitle
_color = "#e0e0e0"; 
_text = parseText format ["<t align = 'left' opacity='.7' shadow = '2' size = '1.1'><t color = '%1'>" + _text + "</t></t>",_color];
_ctrl ctrlSetStructuredText _text;
_ctrl ctrlSetFade 0;
_ctrl ctrlCommit 1;

sleep 10;

// Hide subtitle
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 1;
ctrlDelete _ctrl;