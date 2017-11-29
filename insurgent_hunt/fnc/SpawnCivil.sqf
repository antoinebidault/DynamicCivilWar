_group = _this select 0;
_pos = _this select 1;
_chief = if (count _this >= 3) then{ _this select 2 }else{objNull};
_handleFireEvent = if (count _this >= 4) then{ _this select 3 }else{true};

_unitName = CIV_LIST_UNITS call BIS_fnc_selectRandom;
_unit = _group createUnit [_unitName, _pos,[],ENEMY_SKILLS,"NONE"];

if (DEBUG)then{
    [_unit,"ColorBlue"] call fnc_addmarker;
};

//Si c'est un mauvais
_unit setVariable["IH_Chief",_chief];

[_unit] call fnc_handlekill;
_unit call fnc_handleDamaged;

//By default, it takes the average civil reputation;
_unit setVariable["IH_friendliness",CIVIL_REPUTATION];
_unit setVariable["IH_type","civ"];
_unit setDir random 360;
removeAllWeapons _unit;

if (_handleFireEvent)then{
    [_unit] spawn fnc_HandleFiredNear;
};

[_unit] spawn fnc_AddCivilianAction;

_unit
