/*
  Author: 
    Bidass

  Description:
    Triggered when the approximate commander position is known

  Parameters:
    0: OBJECT - Unit with the task

  Returns:
    OBJECT - unit with the task 
*/


params["_unit"];

playMusic "BackgroundTrack02_F";

if (getMarkerColor "dcw_commander_dir" != "") then {
	deleteMarker "dcw_commander_dir";
};

_distance = _unit distance ENEMY_COMMANDER;
_distance = (round ((_distance + (( [-1,1] call BIS_fnc_selectRandom ) * random (50))) / 100)) * 100;
_dir = round([_unit,ENEMY_COMMANDER] call BIS_fnc_dirTo);
_marker = createMarker ["dcw_commander_dir",getPos _unit];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Last direction of the Commander !";
_marker setMarkerType "hd_arrow";
_marker setMarkerDir _dir;

[_unit,"HQ, this is bravo team, we've found the presumed camp where the commander rested at night. We'll keep you in touch", true] remoteExec ["DCW_fnc_talk",GROUP_PLAYERS];

sleep 10;

[HQ,"Copy", true] remoteExec ["DCW_fnc_talk"];

sleep 10;

[_unit,format["There is some step foots over here ! I think he moved to this direction : %1deg",str (_dir)], true] remoteExec ["DCW_fnc_talk",GROUP_PLAYERS];

sleep 10;

[_unit,format["When I see the state of the fireplace, I think he is approximately at %1 meters from our position... I marked it on the map.",str _distance], true] remoteExec ["DCW_fnc_talk",GROUP_PLAYERS];

sleep 10;

[HQ,"Good job soldiers ! Go as fast as possible to this position. ", true] remoteExec ["DCW_fnc_talk",GROUP_PLAYERS];

if (getMarkerColor "dcw_commander_pos" != "") then {
	deleteMarker "dcw_commander_pos";
};

_pos = _unit getRelPos [_distance, 180 - _dir];
_marker = createMarker ["dcw_commander_pos", _pos]; 
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [200,200];
_marker setMarkerAlpha 1;
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Presumed position of the commander!";

{
	["maintask", _x, [ "Go to the presumed commander position. You can use drones to find him easily. He will probably try to flee if you're attacking is corpsemen. If you can't find him, interrogate a leutnant or a compound chief.","Find the commander","Find the commander"], _pos, "ASSIGNED", 1, true, true,""] remoteExec ["BIS_fnc_setTask" ,_x , true];
} foreach ([] call DCW_fnc_allPlayers);

if (!isMultiplayer) then {
	saveGame;
};