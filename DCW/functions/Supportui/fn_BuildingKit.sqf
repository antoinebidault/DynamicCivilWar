openMap  true;

//move the marker to the click position
Base_marker = "";
onMapSingleClick {
	Base_marker = createMarkerLocal ["medevac_marker",_pos];
	Base_marker setMarkerColorLocal "ColorBlack";
	Base_marker setMarkerShapeLocal "ELLIPSE";
	Base_marker setMarkerBrushLocal "Solid";
	Base_marker setMarkerSizeLocal [13, 13];
};

//clear the click handle
waitUntil {Base_marker != "" || !alive player || !visibleMap};
publicVariableServer "Base_marker";

if (!visibleMap) exitWith{};

player onMapSingleClick "";
[HQ,"The building kit is in bound !",true] remoteExec ["DCW_fnc_talk"];
sleep 1;
openMap false;

[getMarkerPos Base_marker,2500, "buildingKit"] spawn DCW_fnc_vehicleLift;
	
 [player,COMMENU_OUTPOST_ID] call BIS_fnc_removeCommMenuItem;