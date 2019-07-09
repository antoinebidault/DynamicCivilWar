/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Little cutscene triggered when player secures an outpost

  Parameters:
    0: ARRAY - an array of units spawned in the compound. 
			   There must be a flag inside with FRIENDLY_FLAG

*/
if (isNull player) exitWith{};

params["_units"];

player allowDamage false;

_flag =  (_units select { typeOf _x == FRIENDLY_FLAG }) select 0;

titleCut ["", "BLACK OUT", 1];
sleep 1;
showCinemaBorder true;
_cam = "camera" camcreate (_flag modelToWorld [-10,-0.2,2.9]);
_cam cameraeffect ["internal", "back"];
_cam camSetTarget  (_flag modelToWorld [0,0,5]); 
_cam camCommit 0;
_cam camSetFov 1;
_cam camSetPos (_flag modelToWorld [-20,-0.2,3.2]);
_cam camCommit 10;

[parseText format ["<t font='PuristaBold' size='1.6'>The reinforcements arrived</t><br/>%1", daytime call BIS_fnc_timeToString], true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;

sleep 1;

titleCut ["", "BLACK FADED", 999];
if (!isMultiplayer) then {
	skipTime 6;
};

sleep 1;

titleCut ["", "BLACK IN", 1];

sleep 11;

titleCut ["", "BLACK OUT", 1];

sleep 1;


showCinemaBorder false;
_cam cameraeffect ["terminate", "back"];
camDestroy _cam;

titleCut ["", "BLACK IN", 1];

sleep 1;

player allowDamage true;