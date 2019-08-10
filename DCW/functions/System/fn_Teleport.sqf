/*
  Author: 
    Bidass

  Version:
    0.9.1

  Description:
    Player's surrendering system 

*/

DCW_map_teleport_enabled = false;

map_click_handler =
[
	"map_teleport", "onMapSingleClick",
	{
		if (DCW_map_teleport_enabled) then {
			player setPos _pos; // _pos is predefined for onMapSingleClick
			systemChat format [localize "STR_DCW_teleport_teleportToMapPosition", _pos];
			DCW_map_teleport_enabled = false;
			openMap false;
		};
	},
	nil
] call BIS_fnc_addStackedEventHandler;

_id = _this addAction
[
	localize "STR_DCW_teleport_teleportTo",
	{
		DCW_map_teleport_enabled = true;
		if (!visibleMap) then {
			// will probably need to check if player has map, and use forceMap if he doesn't
			openMap true;
			waitUntil {visibleMap};
		};
		mapCenterOnCamera ((findDisplay 12) displayCtrl 51);
		waitUntil {!visibleMap};
		if (DCW_map_teleport_enabled) then {
			systemChat localize "STR_DCW_teleport_teleportCancel";
		};
		DCW_map_teleport_enabled = false;
	},
	nil, 0.5, false, true
];
