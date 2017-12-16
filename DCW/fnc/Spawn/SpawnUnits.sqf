/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_unitName","_civ"];
private _pos = _this select 0;
private _radius = _this select 1;
private _isCleared = _this select 2;
private _people = _this select 3;
private _meetingPointPosition = _this select 4;
private _units = [];
private _population = _people select 0; 
private _nbSnipers = _people select 1; 
private _nbenemies = _people select 2; 


//List positions;
private _posResult = [];
private _posResult = [_pos,_radius] call fnc_SpawnPosition;
private _posSelects = _posResult select 0;
private _enterable = _posResult select 1;
private _cancel = true;


if (_nbSnipers > 0)then{
  
  {
    _objs = nearestTerrainObjects [_x select 0, ["Tree","Bush"], 20];
    if (count _objs > 0) then{
      private _obj  =_objs select 0;
      private  _grp = createGroup ENEMY_SIDE;
      for "_xc" from 1 to _nbSnipers do {
        
        _unitName = ENEMY_SNIPER_UNITS call BIS_fnc_selectRandom;
        _unit = _grp createUnit [_unitName, _pos,[],ENEMY_SKILLS,"NONE"];

        if (DEBUG)then{
            [_unit,"ColorRed"] call fnc_addmarker;
        };

        [_unit] call fnc_AddTorch;
        [_unit] call fnc_handlekill;

        _unit setVariable["DCW_Type","sniper"];
        UNITS_SPAWNED pushback _unit;
        
        _unit doWatch _pos;
        if (_xc == 1)then{
          _unit setVariable["DCW_IsIntel",true];
          _unit setUnitPos "MIDDLE";
          _unit addWeapon "Binocular";
          _unit selectWeapon "Binocular";

          //Handle success of the mission
          _unit addeventhandler ["Killed",
            { 
              params["_unit","_killer"];
               if (group _killer == group player) then{
                  _unit call fnc_success;
                };
                deleteMarker (_unit getVariable["marker",""]);
                UNITS_SPAWNED = UNITS_SPAWNED - [_unit];
            }
          ];

        }else{
          _unit setUnitPos "DOWN";
        };

        _units pushBack _unit;
      };
    };
  }
  foreach selectBestPlaces [_pos, 500, "trees + 3*hills - houses - forest", 5, 1];
};


//Enemies
for "_xc" from 1 to _nbenemies  do {

    private _posSelected = [];
    private _nbUnit = 1;
    
    if (count _posSelects > 0)then{
        _posSelected = _posSelects call BIS_fnc_selectRandom;
        _posSelects = _posSelects - [_posSelected];
    }else{
        _posSelected = [_pos,1, _radius, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
    };

    _grp = createGroup ENEMY_SIDE;
    for "_xc" from 1 to _nbUnit do {
      _enemy = [_grp,_posSelected,false] call fnc_spawnEnemy;
      _enemy setVariable["DCW_Type","enemy"];
      _enemy setDir random 360;
      _units pushBack _enemy;
    };

    [leader _grp,_radius,_meetingPointPosition] spawn fnc_patrol;
};


//Civilians
_chief = objNull;
for "_xc" from 1 to _population do {
    private _posSelected = [];
     if (count _posSelects > 0)then{
      _posSelected = _posSelects call BIS_fnc_selectRandom;
      _posSelects = _posSelects - [_posSelected];
    }else{
        _posSelected = [_pos,1, _radius, 1.5, 0, 20, 0] call BIS_fnc_FindSafePos;
    };

    if (count _posSelected > 0) then {
      _unitName = CIV_LIST_UNITS call BIS_fnc_selectRandom;
      _grp = createGroup CIV_SIDE;
    
      if (_xc == 1 && _population >= 4) then {
        _civ = [_grp,_posSelected,_chief,false] call fnc_SpawnCivil;
        _civ call fnc_localChief;
        _units pushBack _civ;
        _chief = _civ;
      }else{
        if (_xc == 2 && _population > 10)then{
          _civ = [_grp,_posSelected,_chief,false,"C_Marshal_F"] call fnc_SpawnCivil;
          _civ call fnc_Medic;
          _units pushBack _civ;
        }else{
          _civ = [_grp,_posSelected,_chief,true] call fnc_SpawnCivil;
          [_civ,_radius,_meetingPointPosition] spawn fnc_patrol;
          _units pushBack _civ;
        };
      };
    };
};

_units;