playMusic "BackgroundTrack02_F";

if (getMarkerColor "DCW_commander_dir" != "") then {
	deleteMarker "DCW_commander_dir";
};

_distance = (round (LEADER_PLAYERS distance ENEMY_COMMANDER + (([-1,1] call BIS_fnc_selectRandom ) * random 200) / 100)) * 100;
_dir = round([LEADER_PLAYERS,ENEMY_COMMANDER] call BIS_fnc_dirTo);
_marker = createMarker ["DCW_commander_dir",getPos LEADER_PLAYERS];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Last direction of the Commander !";
_marker setMarkerType "hd_arrow";
_marker setMarkerDir _dir;

[LEADER_PLAYERS,"HQ, this is bravo team, we've found the presumed camp where the commander rested at night. We'll keep you in touch", true] remoteExec ["fnc_talk"];
[HQ,"Copy", true] remoteExec ["fnc_talk"];
sleep 10;
[LEADER_PLAYERS,format["There is some step foots over here, I think he moved to this direction : %1",str (180 - _dir)], true] remoteExec ["fnc_talk"];
[LEADER_PLAYERS,format["When I see the state of the fireplace, I think he is approximately at %1 meters from our position",str _distance], true] remoteExec ["fnc_talk"];
sleep 3;
[HQ,"Good job soldiers ! investgate this position.", true] remoteExec ["fnc_talk"];

if (getMarkerColor "DCW_commander_pos" != "") then {
	deleteMarker "DCW_commander_pos";
};
_marker = createMarker ["DCW_commander_pos",getPos LEADER_PLAYERS];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [200,200];
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Presumed position of the commander!";