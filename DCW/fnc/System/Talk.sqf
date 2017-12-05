
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 * Show chat
 */
private _talker = _this select 0;
private _say = _this select 1;

private _side = side _talker;
private _color = "#E0E0E0";
if (_side == CIVILIAN) then {
	_color = '#c6b32b';
}else{
	if (_side == RESISTANCE) then {
		_color = '#549c66';
	}else{
		if (_side == WEST) then {
			_color = '#1a657b';
		}else{
			if (_side == EAST) then {
				_color = '#d22b2f';
			};
		};
	};
};

// Create display and control
disableSerialization;
titleRsc ["RscDynamicText", "PLAIN"];
private "_display";
waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
private _ctrl = _display displayCtrl 9999;
uiNamespace setVariable ["BIS_dynamicText", displayNull];
private _ctrlBackground = _display ctrlCreate ["RscText",99999];

// Position control
private _w = 0.7 * safeZoneW;
private _x = safeZoneX + (0.15 * safeZoneW );
private _y = safeZoneY + (0.75 * safeZoneH);
private _h = safeZoneH;

_ctrl ctrlSetPosition [_x,_y,_w,_h];

// Hide control
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0;

// Show subtitle
_text = parseText format ["<t align = 'center' opacity='.7' shadow = '2' size = '.8'><t color = '%1'>%2</t></t><br /><t align = 'center' opacity='.6' shadow = '1' size = '.63'><t color = '#E0E0E0'>%3</t></t>",_color,name _talker,_say];
_ctrl ctrlSetStructuredText _text;
_ctrl ctrlSetFade 0;
_ctrl ctrlCommit 1;

sleep (count(_say)/10);

// Hide subtitle
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 1;
ctrlDelete _ctrl;
