/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 *
 * Modified script of SPUn / LostVar
 */


private _unit = _this select 0;
private _radius = _this select 1;
private _meetPoint = _this select 2;

private _buildings = [getPos _unit,_radius] call fnc_findBuildings;
if(isNil("_buildings"))exitWith{};

private _building = _buildings select 0; 
if (isNil "_building")exitWith{};

private _bPoss = [];
private _i = 0;
private _i2 = 0;
private _dir = 0;
private _range = 10;
private _curPos = [];
private _newPos = [];
private _bPoss = [];
private _rd = 0;
private _timer = 0;

//private _anims = ["STAND","STAND_IA","SIT_LOW","WATCH","WATCH1","WATCH2"];

//_unit forceWalk true;
_unit setBehaviour "SAFE";

while { alive _unit && isNull(_unit findNearestEnemy _unit) && !(_unit getVariable ["civ_insurgent",false]) }do{


    _bPoss = [];
	_i = 0;
	while { ((_building buildingPos _i) select 0) != 0 } do {
    	_bPoss set [count (_bPoss), (_building buildingPos _i)];
		_i = _i + 1;
	};

	_i2 = 0;
    while{_i2 < (count _bPoss)}do{

        //Tirage aléatoire
        _rd = round(random(2));

        /**********GO IN*************/
        if (_rd == 0) then {
            
            if (_unit getVariable ["civ_insurgent",false])exitWith{false};

            _newPos = (floor(random(count _bPoss)));
            _newPos = _bPoss select _newPos;
            waitUntil {sleep 4;unitReady _unit || !isNull(_unit findNearestEnemy _unit) || _unit distance _newPos < 2};
            _unit doMove _newPos;
            _timer = time;
            waitUntil {sleep 4;unitReady _unit || _unit distance _newPos < 2 || !isNull(_unit findNearestEnemy _unit) || time > _timer + 150};
            if (_unit getVariable ["civ_insurgent",false])exitWith{false};

            /*if (side _unit != CIV_SIDE) then{
                    _unit stop true;
                sleep 2;cv 
                [_unit,_anims call BIS_fnc_selectRandom,"FULL"] call BIS_fnc_ambientAnimCombat;
            };*/
            sleep (20 + random 5);
            /*if (side _unit!= CIV_SIDE) then{
                    if (alive _unit)then{
                        _unit stop false;
                    _unit call BIS_fnc_ambientAnim__terminate;
                    };
            };*/
            _i2 = _i2 + 1;
        }else{
            /**********GO OUT*************/
            if (_rd==1) then{
                _dir = random 360;
                _curPos = getPos _unit;
                _newPos = [_curPos ,_range,_range + 30, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
                _unit doMove _newPos;
                _timer = time;


                waitUntil {sleep 4; unitReady _unit || _unit distance _newPos < 2 || !isNull(_unit findNearestEnemy _unit) || time > _timer + 150};

                //Sit or not
                if (round(random 1)==1)then{
                    _unit stop true;
                    _unit action ["sitdown",_unit];
                    sleep 40 + random 25;
                    _unit action ["sitdown",_unit];
                    _unit stop false;
                }else{
                    sleep 20 + random 25;
                };
               
                //Play a suspect animation
                if (_unit getVariable["DCW_Suspect",false])then{
                    _unit stop true;
                    _unit playActionNow "medic";
                    sleep 4;
                    _unit stop false;
                };

            }else{
                [_unit,_meetPoint] call fnc_gotomeeting;
                sleep 20;
            };
        };
    };
};

_unit forceWalk false;
_unit setBehaviour "AWARE";
_unit setSpeedMode "NORMAL";