openMap  true;


//move the marker to the click position
Base_marker = "";
onMapSingleClick {

	if ({_pos inArea _x } count MARKER_WHITE_LIST > 0) then {
		openMap false;
		[HQ,localize "STR_DCW_support_ImpossibleToDrop"] spawn DCW_fnc_talk;
	} else {
		if (count BASE_NAMES == 0) then {
			openMap false;
			[HQ,localize "STR_DCW_support_TooMany" ] spawn DCW_fnc_talk;
		} else {
			_name = BASE_NAMES select 0;
			BASE_NAMES = BASE_NAMES - [_name];
			publicVariable "BASE_NAMES";

			[SIDE_FRIENDLY, _pos,format["Base %1",_name]] remoteExec ["BIS_fnc_addRespawnPosition",0, true];

			Base_marker = createMarkerLocal [format["Base_marker_%1",_name],_pos];
			Base_marker setMarkerColor "ColorGreen";
			Base_marker setMarkerShape "ELLIPSE";
			Base_marker setMarkerBrush "Solid";
			Base_marker setMarkerAlpha .5;
			Base_marker setMarkerSize [140, 140];

			MARKER_WHITE_LIST pushback Base_marker;
			publicVariable "MARKER_WHITE_LIST";

			Base_marker_label = createMarker [format["Base_marker_label_%1",_name],_pos];
			Base_marker_label setMarkerText format["Base %1",_name];
			Base_marker_label setMarkerShape "ICON";
			Base_marker_label setMarkerColor "ColorGreen";
			Base_marker_label setMarkerType "hd_flag";
			
		};
	};
};

//clear the click handle
waitUntil {Base_marker != "" || !alive player || !visibleMap};
publicVariableServer "Base_marker";

if (!visibleMap) exitWith{};

player onMapSingleClick "";
sleep 1;
openMap false;

[getMarkerPos Base_marker,2500, "buildingKit"] spawn DCW_fnc_vehicleLift;
	
 [player,COMMENU_OUTPOST_ID] call BIS_fnc_removeCommMenuItem;
 COMMENU_OUTPOST_ID = 0;
