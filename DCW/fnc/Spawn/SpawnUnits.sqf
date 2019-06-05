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
private _buildings = _this select 5;
private _compoundState  = _this select 6;
private _compoundScore  = _this select 7;

private _units = [];
private _population = _people select 0; 
private _nbSnipers = _people select 1; 
private _nbenemies = _people select 2; 

if (_compoundState == "default" || _compoundState == "humanitary" || _compoundState == "secured" || _compoundState == "massacred") then {
  _population =  _population + _nbenemies + _nbSnipers;
  _nbenemies = 0;
  _nbsnipers = 0;
};

//List positions;
private _posResult = [];
private _posResult = [_pos,_radius] call fnc_SpawnPosition;
private _posSelects = _posResult select 0;
private _enterable = _posResult select 1;
private _cancel = true;

if (!_isCleared) then{
  if (_nbSnipers > 0)then{
     _sniperPos = [_pos,_radius, 1.4*_radius, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
    //{
    // _objs = nearestTerrainObjects [_x select 0, ["Tree","Bush"], 20];
    //  if (count _objs > 0) then{
        _obj  =_objs select 0;
        _grp = createGroup SIDE_ENEMY;
        for "_xc" from 1 to _nbSnipers do {
          
          _unitName = ENEMY_SNIPER_UNITS call BIS_fnc_selectRandom;
          _unit = _grp createUnit [_unitName, _sniperPos,[],AI_SKILLS,"NONE"];
          [_unit] joinSilent _grp;

          [_unit,"ColorRed"] call fnc_addmarker;
          [_unit] call fnc_handlekill;

          _unit setVariable["DCW_Type","sniper", true];
          UNITS_SPAWNED_CLOSE pushback _unit;
          
          _unit doWatch _pos;
          if (_xc == 1)then{
            _unit setVariable["DCW_IsIntel",true, true];
            _unit setUnitPos "MIDDLE";
            _unit addWeapon "Binocular";
            _unit selectWeapon "Binocular";

            //Handle success of the mission
            _unit addMPEventHandler ["MPKilled",
              { 
                params["_unit","_killer"];
                if (group _killer == GROUP_PLAYERS) then{
                    _unit call fnc_success;
                  };
              }
            ];

          }else{
            _unit setUnitPos "DOWN";
          };

          _units pushBack _unit;
        };
    // };
  // }
    //foreach selectBestPlaces [_sniperPos, 100, "trees + 3*hills - houses - forest", 5, 1];
  };


  //Enemies
  for "_xc" from 1 to _nbenemies  do {

      private _posSelected = [];
      private _nbUnit = 1 ;
      
      if (count _posSelects > 0)then{
          _posSelected = _posSelects call BIS_fnc_selectRandom;
          _posSelects = _posSelects - [_posSelected];
      }else{
          _posSelected = [_pos,1, _radius, 2, 0, 10, 0] call BIS_fnc_FindSafePos;
      };

      _grp = createGroup SIDE_ENEMY;
      for "_xc" from 1 to _nbUnit do {
        _enemy = [_grp,_posSelected,false] call fnc_spawnEnemy;
        _enemy setVariable["DCW_Type","enemy"];
        _enemy setDir random 360;
        _units pushBack _enemy;
      };

      [leader _grp,_radius,_meetingPointPosition,_buildings] spawn fnc_EnemyCompoundPatrol;
  };
};

//Civilians
_chief = objNull;
_grp = grpNull;
for "_xc" from 1 to _population do {
    private _posSelected = [];
     if (count _posSelects > 0)then{
      _posSelected = _posSelects call BIS_fnc_selectRandom;
      _posSelects = _posSelects - [_posSelected];
    }else{
        _posSelected = [_pos,1, _radius, 1.5, 0, 20, 0] call BIS_fnc_FindSafePos;
    };

    if (count _posSelected > 0) then {
      
      if (_compoundState == "supporting") then {
        _grp = createGroup SIDE_FRIENDLY;
      }else{
        _grp = createGroup SIDE_CIV;
      };

     
      if (_xc == 1 && _population >= 1 && count _buildings > 0) then {
        _civ = [_grp,_posSelected,_chief,false] call fnc_SpawnCivil;
        _civ call fnc_localChief;
        _units pushBack _civ;
        if (_compoundState == "massacred" || _compoundState == "humanitary") then {
          _civ setDamage (floor(random 1)) min .3;
        };
        _chief = _civ;

      }else{
        if (_xc == 2 && _population > 10)then{
          _civ = [_grp,_posSelected,_chief,false,"C_Marshal_F"] call fnc_SpawnCivil;
         removeAllWeapons _civ;
          _civ call fnc_Medic;
          _units pushBack _civ;
        }else{
          if (_xc == 3 && _compoundState == "supporting") then {
              _advisor = [_grp, _posSelected, false] call fnc_spawnfriendly;
              _units pushback _advisor;
          } else{
            _civ = [_grp,_posSelected,_chief,true,nil,_compoundScore] call fnc_SpawnCivil;
            if (_compoundState == "massacred" || _compoundState == "humanitary") then {
              _civ setDamage ([1,.9,.5,.7] call BIS_fnc_selectRandom);
            };
            [_civ,_radius,_meetingPointPosition,_buildings] spawn fnc_CivilianCompoundPatrol;

            // If "supporting"
            if (_compoundState == "supporting") then {
              [_civ,side _civ] call fnc_BadBuyLoadout;
            };

            _units pushBack _civ;

          };
        };
      };

    };
};

_units;