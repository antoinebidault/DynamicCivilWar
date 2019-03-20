
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Show chat
 */
private _talker = _this select 0;
private _say = _this select 1;
private _sound = _this select 2;

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

if (_sound) then {
	[] spawn { playSound (RADIO_CHAT_LIST call BIS_fnc_selectRandom); };
};

_talker setVariable["DCW_speak",true];

// Create display and control
disableSerialization;
titleRsc ["RscDynamicText", "PLAIN"];
private _display = displayNull;
waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
MESS_SHOWN = true;
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
_text = parseText format ["<t align = 'center' shadow = '2' size = '.8'><t color = '%1'>%2</t></t><br /><t align = 'center' shadow = '1' size = '.63'><t color = '#E0E0E0'>%3</t></t>",_color,name _talker,_say];
_ctrl ctrlSetStructuredText _text;
_ctrl ctrlSetFade 0;
_talker setRandomLip true;
_ctrl ctrlCommit .2;

sleep (count(_say)/10) max 1.4;
_talker setRandomLip false;

// Hide subtitle
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit .3;
ctrlDelete _ctrl;
MESS_SHOWN = false;

_talker setVariable["DCW_speak",false];