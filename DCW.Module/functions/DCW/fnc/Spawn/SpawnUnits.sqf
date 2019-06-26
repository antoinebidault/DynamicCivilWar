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
private _nbenemies = _people select 2; 

if (_compoundState == "neutral" || _compoundState == "humanitary" || _compoundState == "supporting" || _compoundState == "secured" || _compoundState == "massacred") then {
  _population =  _population + _nbenemies ;
  _nbenemies = 0;
};

//List positions;
private _posResult = [];
private _posResult = [_pos,_radius] call DCW_fnc_SpawnPosition;
private _posSelects = _posResult select 0;
private _enterable = _posResult select 1;

//Enemies
for "_xc" from 1 to _nbenemies  do {

    private _posSelected = [];
    private _nbUnit = 1 ;
    
    if (count _posSelects > 0)then{
        _posSelected = _posSelects call BIS_fnc_selectRandom;
        _posSelects = _posSelects - [_posSelected];
    }else{
        _posSelected = [_pos,1, _radius, 2, 0, 10, 0] call BIS_fnc_findSafePos;
    };

    _grp = createGroup SIDE_ENEMY;
    for "_xc" from 1 to _nbUnit do {
      _enemy = [_grp,_posSelected,false] call DCW_fnc_spawnEnemy;
      _enemy setVariable["DCW_Type","enemy"];
      _enemy setDir random 360;
      _units pushBack _enemy;
    };

    [leader _grp,_radius,_meetingPointPosition,_buildings] spawn DCW_fnc_EnemyCompoundPatrol;
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
        private _spawnPos = _pos;
        if (count _enterable > 0) then {
          _randomBuilding = _enterable call BIS_fnc_selectRandom;
          _spawnPos = getPos _randomBuilding;
        };
        _posSelected = [_spawnPos,1, 22, 1.5, 0, 20, 0] call BIS_fnc_findSafePos;
    };

    if (count _posSelected > 0) then {
      
      if (_compoundState == "supporting") then {
        _grp = createGroup SIDE_FRIENDLY;
      }else{
        _grp = createGroup SIDE_CIV;
      };

     
      if (_xc == 1 && _population >= 1 && count _buildings > 0) then {
        _civ = [_grp,_posSelected,_chief,false] call DCW_fnc_SpawnCivil;
        [_civ,_radius] call DCW_fnc_localChief;
        _units pushBack _civ;
        if (_compoundState == "massacred" || _compoundState == "humanitary") then {
          _civ setDamage (floor(random 1)) min .3;
        };
        _chief = _civ;

      }else{
        if (_xc == 2 && _population > 10)then{
          _civ = [_grp,_posSelected,_chief,false,"C_Marshal_F"] call DCW_fnc_SpawnCivil;
         removeAllWeapons _civ;
          _civ call DCW_fnc_Medic;
          _units pushBack _civ;
        }else{
          if (_xc == 3 && _compoundState == "supporting") then {
              _advisor = [_grp, _posSelected, false] call DCW_fnc_spawnfriendly;
              _units pushback _advisor;
          } else{
            _civ = [_grp,_posSelected,_chief,if (_compoundState == "supporting") then {false}else{true},nil,_compoundScore] call DCW_fnc_SpawnCivil;
            if (_compoundState == "massacred" || _compoundState == "humanitary") then {
              
              _civ setDamage ([.9,.85,.5,.7,.3] call BIS_fnc_selectRandom);
              if (damage _civ <= .6) then {
		            _civ call DCW_fnc_addActionHeal;
              };
              if (damage _civ < .8) then {
                _civ setUnconscious true;
                _civ setPos ([_posSelected,1, 45, 2, 0, 10, 0] call BIS_fnc_findSafePos);
              };
            };
            [_civ,_radius,_meetingPointPosition,_buildings] spawn DCW_fnc_CivilianCompoundPatrol;

            // If "supporting"
            if (_compoundState == "supporting") then {
              [_civ, SIDE_FRIENDLY] call DCW_fnc_BadBuyLoadout;
              [_civ] remoteexec ["DCW_fnc_AddCivilianAction",0];
            };
            

            _units pushBack _civ;

          };
        };
      };

    };
};

_units;