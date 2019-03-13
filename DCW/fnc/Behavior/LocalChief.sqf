/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


RemoveAllActions _this;
_this setVariable["DCW_LocalChief",true];
removeGoggles _this;
removeHeadgear _this;

_this addGoggles (["G_Spectacles_Tinted","G_Aviator"] call BIS_fnc_selectRandom);
_this addHeadgear "H_Beret_blk";

[_this,["Interrogate",{
    (_this select 0) RemoveAction (_this select 2);
    (_this select 0) call fnc_MainObjectiveIntel;
}]] remoteExec ["addAction"];

[_this,["Set up camp here (200 points, 6 hours)",{
    params["_unit","_asker","_action"];
    
    //Talk
    [_asker,"Is it possible to set up our camp here ?", false] spawn fnc_talk;

    //Populate with friendlies
    _curr = ([position _unit,false] call fnc_findNearestMarker);
    MARKERS = MARKERS - [_curr];
   
    private _marker =_curr select 0;
    private _pos =_curr select 1;
    private _triggered =_curr select 2;
    private _success =_curr select 3;
    private _radius =_curr select 4;
    private _units =_curr select 5;
    private _peopleToSpawn =_curr select 6;
    private _meetingPointPosition =_curr select 7;
    private _points =_curr select 8;
    private _isLocation =_curr select 9;
    private _randomnumber = floor random 100000;
    private _mkrToAvoid = createMarker ["friendly-outpost-" + (str _randomnumber), getPos player];
    
    if(!_success) exitWith{[_unit,"Secure our position first", false] spawn fnc_talk;false;};

    if (!([GROUP_PLAYERS,200] call fnc_afford)) exitWith {[_unit,"You need more money !", false] spawn fnc_talk;false;};

    _unit RemoveAction _action;
    _buildings = nearestObjects [_pos, ["house"], 300];
    {
        if ([_x, 3] call BIS_fnc_isBuildingEnterable) then {
            _posBuilding = [_x] call BIS_fnc_buildingPositions;
            RESPAWN_POSITION = ([_posBuilding] call BIS_fnc_selectRandom) select 0;
            if (true) exitWith{true};
        };
    } foreach _buildings;

     // Put in whitelisty
    _mkrToAvoid setMarkerAlpha 0;
    _mkrToAvoid setMarkerShape "RECTANGLE";
    _mkrToAvoid setMarkerSize [500,500];
    MARKER_WHITE_LIST pushback _mkrToAvoid;

    //disableAi
    _unit disableAI "MOVE";

     //Talking with the fixed glitch
    _anim = format["Acts_CivilTalking_%1",ceil(random 2)];
    _unit switchMove _anim;

    showCinemaBorder true;
    _camPos = _asker modelToWorld [-1,-0.2,1.9];
    _cam = "camera" camcreate _camPos;
    _cam cameraeffect ["internal", "back"];
    _cam camSetPos _camPos;
    _cam camSetTarget _unit;
    _cam camSetFov 1.0;
    _cam camCommit 0;


    _unit doWatch _asker;
    _asker doWatch _unit;

    [_unit,"You're welcome here ! We need help. You can set up your camp here.", false] call fnc_talk;

    _cam camSetPos (_unit modelToWorld [-1,-0.2,1.9]);
    _cam camSetTarget _asker;

    [_unit,"Okay, I'll send you some reinforcements", false] call fnc_talk;
    
    titleCut ["6 hours later...", "BLACK OUT", 3];
    sleep 3;
    titleCut ["6 hours later...", "BLACK FADED", 999];
    
    //Suppress temporarly the marker
    MARKERS = MARKERS - [_curr];

    /* [_nbCivilian,_nbSnipers,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies]
    _peopleToSpawn set [1,0];
    _peopleToSpawn set [2,0];
    _peopleToSpawn set [5,0];
    _peopleToSpawn set [6,0];
    _peopleToSpawn set [7,0];
    _peopleToSpawn set [8,0];*/
    _peopleToSpawn set [9,(_peopleToSpawn select 0) + ceil(random 3)];
    _curr  set [6,_peopleToSpawn];

    _units = _curr select 5;
	_units = _units + ([_pos,_radius,_peopleToSpawn select 9,_meetingPointPosition] call fnc_SpawnFriendlyOutpost);

    _marker = createMarker ["marker",_pos];
    _marker setMarkerShape "ICON";
    _marker setMarkerColor "ColorGreen";
    _marker setMarkerType "hd_flag";

    MARKERS pushback _curr;

    if (!isMultiplayer) then {
        skipTime 6;
    };
    sleep 1;
    titleCut ["6 hours later...", "BLACK IN", 4];
    
    _flag = (_units select { typeOf _x == FRIENDLY_FLAG }) select 0;
    

    _cam camSetPos (_flag modelToWorld [-10,-0.2,2.9]); 
    _cam camSetTarget  (_flag modelToWorld [0,0,5]); 
    _cam camCommit 0;
    _cam camSetFov 1;
    _cam camSetPos (_flag modelToWorld [-20,-0.2,3.2]);
    _cam camCommit 10;
    sleep 10;

    showCinemaBorder false;
    _cam cameraeffect ["terminate", "back"];
    camDestroy _cam;

     waitUntil{animationState _unit != _anim};
    _unit switchMove "";

    _unit enableAI "MOVE";
    
    hint "Next time, you'll respawn at this position.";

}]] remoteExec["addAction", LEADER_PLAYERS];
