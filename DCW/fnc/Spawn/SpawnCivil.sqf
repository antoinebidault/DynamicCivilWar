/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_group = _this select 0;
_pos = _this select 1;
_chief =  [_this, 2, objNull, [objNull]] call BIS_fnc_param;
_handleFireEvent =  [_this, 3, true, [true]] call BIS_fnc_param;
_unitName =  [_this, 4, CIV_LIST_UNITS call BIS_fnc_selectRandom, ["",[]]] call BIS_fnc_param;
_friendlieness =  [_this, 5, 100-PERCENTAGE_SUSPECT, [0]] call BIS_fnc_param;

_unit = _group createUnit [_unitName, _pos,[],AI_SKILLS,"NONE"];
[_unit] joinsilent _group;
// _group call DCW_fnc_sendToHC;

removeAllWeapons _unit;
//_unit setBehaviour "CARELESS";
/*_unit allowFleeing 0;
_unit setBehaviour "SAFE";
_unit setSpeedMode "LIMITED";*/

//Si c'est un mauvais
_unit setVariable["DCW_Chief",_chief, true];

[_unit] call DCW_fnc_handlekill;
_unit call DCW_fnc_handleDamaged;

//By default, it takes the average civil reputation;
_unit setVariable["DCW_Suspect", if(random 100 > _friendlieness) then {true}else{false} ];
// _unit setVariable["DCW_Friendliness",CIVIL_REPUTATION, true];

if (DEBUG)then{
    [_unit, if (_unit getVariable["DCW_Suspect", false])then{"ColorOrange"}else{"ColorBlue"}] call DCW_fnc_addmarker;
};

_unit setVariable["DCW_Type","civ"];
_unit setDir random 360;

if (_handleFireEvent)then{
    [_unit] spawn DCW_fnc_HandleFiredNear;
    [_unit] remoteexec ["DCW_fnc_AddCivilianAction",0];
};

UNITS_SPAWNED_CLOSE pushBack _unit;

_unit
