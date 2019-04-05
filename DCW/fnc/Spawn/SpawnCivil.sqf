/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

_group = _this select 0;
_pos = _this select 1;
_chief = if (count _this >= 3) then{ _this select 2 }else{objNull};
_handleFireEvent = if (count _this >= 4) then{ _this select 3 }else{true};
_unitName = if (count _this >= 5) then{ _this select 4 }else{CIV_LIST_UNITS call BIS_fnc_selectRandom};

_unit = _group createUnit [_unitName, _pos,[],ENEMY_SKILLS,"NONE"];



//Si c'est un mauvais
_unit setVariable["DCW_Chief",_chief, true];

[_unit] call fnc_handlekill;
_unit call fnc_handleDamaged;

//By default, it takes the average civil reputation;
_unit setVariable["DCW_Suspect", if(random 100 > PERCENTAGE_SUSPECT) then {false}else{true} ];
_unit setVariable["DCW_Friendliness",CIVIL_REPUTATION, true];

if (DEBUG)then{
    [_unit, if (_unit getVariable["DCW_Suspect", false])then{"ColorOrange"}else{"ColorBlue"}] call fnc_addmarker;
};

_unit setVariable["DCW_Type","civ"];
_unit setDir random 360;
removeAllWeapons _unit;

if (_handleFireEvent)then{
    [_unit] spawn fnc_HandleFiredNear;
    [_unit] remoteEXec ["fnc_AddCivilianAction",0];
};

UNITS_SPAWNED pushBack _unit;

_unit
