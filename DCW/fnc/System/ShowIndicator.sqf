/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


params ["_text","_time"];

_time = [_this,1,10] call BIS_fnc_param;
_layer = round (random 99999);

// Create display and control
waitUntil {!INDICATOR_SHOWN};
INDICATOR_SHOWN = true;
disableSerialization;
_layer cutrsc ["rscDynamicText","plain"];
_display = displayNull;
waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
_ctrl = _display displayCtrl 9999;
uiNamespace setVariable ["BIS_dynamicText", displayNull];
_ctrlBackground = _display ctrlCreate ["RscText",9999];

// Position control
private _w = 0.2 * safeZoneW;
private _x =  safeZoneX + (0.85 * safeZoneW );
private _y =  safeZoneY + (0.85 * safeZoneH);
private _h = safeZoneH;

_ctrl ctrlSetPosition [_x,_y,_w,_h];

// Hide control
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0;

// Show subtitle
_color = "#e0e0e0"; 
_text = parseText format ["<t align = 'left' shadow = '2' size = '.6'><t color = '%1'>" + _text + "</t></t>",_color];
_ctrl ctrlSetStructuredText _text;
_ctrl ctrlSetFade 0;
_ctrl ctrlCommit 1;

if (_time > 0) then{
	sleep _time;
	INDICATOR_SHOWN = false;	
} else {
	[] spawn {
		sleep 24;
		INDICATOR_SHOWN = false;
	};
	waitUntil { !INDICATOR_SHOWN; sleep 1
	; };
};

// Hide subtitle
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 1;
ctrlDelete _ctrl;
sleep 1;