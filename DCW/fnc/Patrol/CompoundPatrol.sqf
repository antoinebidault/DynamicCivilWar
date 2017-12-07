/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Modified script by SPUn / LostVar

private ["_unit","_radius","_newPos","_i","_i2","_bPoss","_building","_buildings","_dir","_range","_curPos","_outOrNot"];

_unit = _this select 0;
_radius = _this select 1;
_meetPoint = _this select 2;
_buildings = [position _unit,_radius] call fnc_findBuildings;
if(isNil("_buildings"))exitWith{};

_building = _buildings select 0; 
if (isNil "_building")exitWith{};
_anims = ["STAND","STAND_IA","SIT_LOW","WATCH","WATCH1","WATCH2"];

while { alive _unit && !(_unit getVariable ["civ_insurgent",false]) }do{

    if (_unit getVariable ["civ_insurgent",false])exitWith{false};

    if(isNull(_unit findNearestEnemy _unit))then{
        _unit forceWalk true;
        _unit setBehaviour "SAFE";
    }else{
        _unit forceWalk false;
        _unit setBehaviour "AWARE";
    };

    _bPoss = [];
	_i = 0;
	while { ((_building buildingPos _i) select 0) != 0 } do {
    	_bPoss set [count (_bPoss), (_building buildingPos _i)];
		_i = _i + 1;
	};
	_i2 = 0;
    while{_i2 < (count _bPoss)}do{
        if (_unit getVariable ["civ_insurgent",false])exitWith{false};
       	_newPos = (floor(random(count _bPoss)));
        	_newPos = _bPoss select _newPos;
        	waitUntil {unitReady _unit || _unit distance _newPos < 2};
        	_unit doMove _newPos;

            _timer = time;
        	waitUntil {unitReady _unit || _unit distance _newPos < 2 || time > _timer + 150};
            if (_unit getVariable ["civ_insurgent",false])exitWith{false};

            if (side _unit != CIV_SIDE) then{
                 _unit stop true;
                sleep 2;
                [_unit,_anims call BIS_fnc_selectRandom,"FULL"] call BIS_fnc_ambientAnimCombat;
            };
        	sleep (20 + random 5);
            if (side _unit!= CIV_SIDE) then{
                 if (alive _unit)then{
                     _unit stop false;
                    _unit call BIS_fnc_ambientAnim__terminate;
                 };
            };

        if (_unit getVariable["DCW_Suspect",false])then{
            _unit stop true;
            _unit playActionNow "medic";
            sleep 4;
            _unit stop false;
        };

         _goToMeeting = ceil(random 2);
         if(_goToMeeting == 1)then{
           [_unit,_meetPoint] call fnc_gotomeeting;
         };

         _outOrNot = ceil(random 2);
        if(_outOrNot == 1)then{
            _dir = random 360;
            _range = 10 ;
            _curPos = getPos _unit;
             _newPos = [_curPos ,_range,_range + 30, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
            _unit doMove _newPos;
            _timer = time;
            waitUntil {sleep 4 ; unitReady _unit || _unit distance _newPos < 2 || time > _timer + 150};

            _unit stop true;
            _unit action ["sitdown",_unit];
            /*
             if (side _unit == ENEMY_SIDE) then{
                _unit stop true;
                sleep 2;
                [_unit,_anims call BIS_fnc_selectRandom,"FULL"] call BIS_fnc_ambientAnimCombat;
            };*/
            sleep 20 + random 25;
            
            _unit action ["sitdown",_unit];
            _unit stop false;

            /*
            if (side _unit == ENEMY_SIDE) then{
                if (alive _unit)then{
                    _unit stop false;
                    _unit call BIS_fnc_ambientAnim__terminate;
                };
            };*/
        }else{
            _i2 = _i2 + 1;
        };
    };
};