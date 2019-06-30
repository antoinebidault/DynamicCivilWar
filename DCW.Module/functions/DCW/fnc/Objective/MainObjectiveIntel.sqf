/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _unit = _this;

if(!alive ENEMY_COMMANDER)exitWith {false};
if(count COMMANDER_LAST_POS == 0) exitWith {[_unit,"But I think you already know it...",false] remoteExec ["DCW_fnc_Talk"];false;};

private _initPos = COMMANDER_LAST_POS call BIS_fnc_selectRandom;
COMMANDER_LAST_POS = COMMANDER_LAST_POS - [_initPos];

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
      _initPos = [["dcw_intel_c"],["water"]] call BIS_fnc_randomPos;
    };
    deleteMarker format["dcw_intel_q_%1",_j];
    _marker = createMarker [format["dcw_intel_q_%1",_j],_initPos];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "hd_unknown";
    _marker setMarkerPos _initPos;
};

//Unique ID added to the task id;
_taskId = "maintask";

[[_unit,_taskid,_pos],{
  params ["_unit","_taskid","_pos"];
  [_unit,"I marked you on the map where I think he is.",true] call DCW_fnc_Talk;
  {
    [_taskId, _x, [ "Investigate the sector where the enemy\n commander is possibly located","Investigate the sector","Investigate the sector"], _pos, "ASSIGNED", 1, true, true,""] remoteExec ["BIS_fnc_setTask" ,_x , true];
  } foreach ([] call DCW_fnc_allPlayers);
  [(leader GROUP_PLAYERS),"Thank you, we'll investigate this place.",true] call DCW_fnc_Talk;
  [(leader GROUP_PLAYERS),"HQ, we've caught informations about the possible enemy commander last position.",false] call DCW_fnc_Talk;
  [HQ,"Copy ! We'll send you extra credits in order to accomplish your task. Good luck ! Out.",false] call DCW_fnc_Talk;
 
}] remoteExec["spawn", GROUP_PLAYERS, false];

[GROUP_PLAYERS,250,false,(leader GROUP_PLAYERS)] call DCW_fnc_updatescore;

if (!isMultiplayer) then{
	saveGame;
};

playMusic "LeadTrack04a_F";

true;