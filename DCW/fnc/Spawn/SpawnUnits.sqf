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

if (_population < 1) exitWith { _units };

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


//Ajout des enemis 
for "_xc" from 1 to _nbenemies  do {

    _isPatrol = false;
    _cancel = false;
    _nbUnit = 1;
    _posSelected = [];

    //if (random 100 > 75) then{_nbUnit = ((PATROL_SIZE select 0) + floor random (PATROL_SIZE select 1)); _isPatrol = true; };

    if (_isPatrol)then{
      _posSelected = [_pos,1, _radius, 5, 0, 20, 0] call BIS_fnc_findSafePos;
    }else{
      if (count _posSelects > 0)then{
         _posSelected = _posSelects call BIS_fnc_selectRandom;
        _posSelects = _posSelects - [_posSelected];
      }else{
         _cancel = true;
      }
    };

    if (!_cancel) then {
      _grp = createGroup ENEMY_SIDE;
      for "_xc" from 1 to _nbUnit do {
        _enemy = [_grp,_posSelected] call fnc_spawnEnemy;
        _enemy setVariable["DCW_Type","enemy"];
        _enemy setDir random 360;
        _units pushBack _enemy;
      };

      //Si c'est une patrouille
      if (_isPatrol)then{
        [leader _grp] spawn fnc_largePatrol;
      }else{
        [leader _grp,_radius,_meetingPointPosition] spawn fnc_patrol;
      };
    };
};


//Ajout des civils avec leur chef si c'est un gros compound
_chief = objNull;
for "_xc" from 1 to _population do {
  if (count _posSelects > 0)then{
    _posSelected = _posSelects call BIS_fnc_selectRandom;
    _posSelects = _posSelects - [_posSelected];
    _unitName = CIV_LIST_UNITS call BIS_fnc_selectRandom;
    _grp = createGroup CIV_SIDE;
  
    if (_xc == 1 && _population >= 2) then {
		  _civ = [_grp,_posSelected,_chief,false] call fnc_SpawnCivil;
      _civ call fnc_localChief;
      _units pushBack _civ;
      _chief = _civ;
    }else{
       _civ = [_grp,_posSelected,_chief,true] call fnc_SpawnCivil;
      [_civ,_radius,_meetingPointPosition] spawn fnc_patrol;
      _units pushBack _civ;
    };
  };
};

_units;