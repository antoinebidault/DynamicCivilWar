
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: Bidass

  Version:
    {VERSION}
 * License : GNU (GPL)
 * Show chat
 */
 if (isNull player) exitWith{};
_talker = _this select 0;
_sentence = _this select 1;

_side = side group _talker;
_color = "#E0E0E0";
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
100 cutrsc ["rscDynamicText","plain"];
_display = displayNull;
waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
_ctrl = _display displayCtrl 9999;

// Position control
 _w = 0.7 * safeZoneW;
 _x = safeZoneX + (0.15 * safeZoneW );
 _y = safeZoneY + (0.75 * safeZoneH);
 _h = safeZoneH;

// Show subtitle
_text = parseText format ["<t font='PuristaSemiBold' align = 'center' shadow = '2' size = '.8'><t color = '%1'>%2</t></t><br /><t align = 'center'  shadow = '1' size = '.63'><t color = '#E0E0E0'>%3</t></t><br/>",_color,name _talker,_sentence];
_ctrl ctrlSetStructuredText _text;

_ctrl ctrlSetPosition [_x,.95*_y,_w,_h];
_ctrl ctrlCommit 0;
_ctrl ctrlSetPosition [_x,_y,_w,_h];

// Hide control
_ctrl ctrlSetFade 0;
_ctrl ctrlCommit .3;

_ctrl;
