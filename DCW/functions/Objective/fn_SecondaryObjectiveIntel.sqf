/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Spawn main objective intel.

  Parameters:
    0: OBJECT - unit

  Returns:
    BOOL - true 
*/

private _unit = _this;

if (count OFFICERS == 0) exitWith {false};

private _officer = OFFICERS select 0;
private _initPos = getPos _officer;
private _ratio = 0.8;
private _offset = 40;
private _distance = 350 + random 250;

//Get the marker random position
private _pos = [_initPos, _offset, (_distance - _offset) , 0, 0, 20, 0] call BIS_fnc_findSafePos;

deleteMarker "dcw_intel_c";
_marker = createMarker ["dcw_intel_c",_pos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerColor "ColorRed";
_marker setMarkerBrush "Border";
_marker setMarkerSize [_distance,_distance];
_marker setMarkerPos _pos;

private _nb = (2+round(random 2));
for "_j" from 1 to _nb do {
    if (_j > 1) then{
      _initPos = [["dcw_intel_c"], ["water"]] call BIS_fnc_randomPos;
    };
    deleteMarker format["dcw_intel_q_%1", _j];
    _marker = createMarker [format["dcw_intel_q_%1",_j], _initPos];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "hd_unknown";
    _marker setMarkerPos _initPos;
};

//Unique ID added to the task id;
_taskId = "sectask";
[[_unit,_taskid,_pos,_officer],{
  params ["_unit","_taskid","_pos","_officer"];
  [_unit,format["I marked you on the map where %1 I think he is.", name _officer],true] call DCW_fnc_talk;
  {
    [_taskId, _x, [ "Investigate the sector where the officer is possibly located","Find the officer","Find and interrogate the officer"], _pos, "ASSIGNED", 1, true, true,""] remoteExec ["BIS_fnc_setTask" ,_x , true];
  } foreach ([] call DCW_fnc_allPlayers);
  [(leader GROUP_PLAYERS), "Thank you, we'll investigate this place.", true] call DCW_fnc_talk;
  [(leader GROUP_PLAYERS), "HQ, we've caught informations about the possible enemy officer last position.", false] call DCW_fnc_talk;
  [HQ, "Copy ! We'll send you extra credits in order to accomplish your task. Good luck ! Out.", false] call DCW_fnc_talk;
}] remoteExec["spawn", GROUP_PLAYERS, false];


_loc =  nearestLocations [getPosWorld _officer, ["NameVillage","NameCity","NameCityCapital"],10000] select 0;
{
    private _officerPos = getPos _officer;
    private _officerName = name _officer;

    // Task creation
    [format["DCW_secondary_%1", _officerName],_x, [format["Our drones give us some informations about an insurgent's officer location. Move to his location and try to gather informations about the commander. His name is %1",_officerName],"Interrogate the officer","Interrogate the officer"],_officerPos,"CREATED",1, true] remoteExec ["BIS_fnc_setTask",_x, true];
    
    // HQ message
    [HQ,format[localize "STR_DCW_voices_HQ_secondaryBriefing" ,_officerName,round(((getPos _loc) distance2D (_x))/100)/100,text _loc], true] remoteExec ["DCW_fnc_talk",_x,false];
} foreach ([] call DCW_fnc_allPlayers);


[GROUP_PLAYERS,200,false,(leader GROUP_PLAYERS)] call DCW_fnc_updatescore;

if (!isMultiplayer) then{
	saveGame;
};

// playMusic "LeadTrack04a_F";

true;