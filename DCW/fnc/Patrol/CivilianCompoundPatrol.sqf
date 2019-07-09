/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Civilian patrol in compound. 
    Modified script of SPUn / LostVar

  Parameters:
    0: OBJECT - Group of units
    1: NUMBER - Range in meter
    2: ARRAY - Meeting position => a random position where everybody comes
    3: ARRAY - BUilding list

  Returns:
    BOOL - true 
*/

private _grp = _this select 0;
private _radius = _this select 1;
private _meetPoint = _this select 2;
private _buildings = _this select 3;
private _unit = leader _grp;

// If no building exit loop and do a basic patrol
if (count _buildings == 0) exitWith {[_grp,_radius] call DCW_fnc_simplePatrol;};

//private _buildings = [getPos _unit,_radius] call DCW_fnc_findBuildings;
//if(isNil("_buildings"))exitWith{};

private _building = _buildings call BIS_fnc_selectRandom; 
//if (isNil "_building")exitWith{};

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

_unit setBehaviour "SAFE"; 

//_unit forceWalk  true;
(group _unit) setSpeedMode "LIMITED";
(group _unit) setBehaviour "SAFE";

scopeName "main";
while { alive _unit && !(_unit getVariable ["civ_insurgent",false]) }do{

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
            
            if (_unit getVariable ["civ_insurgent",false] || !alive _unit)then{breakTo "main";};

            _newPos = (floor(random(count _bPoss)));
            _newPos = _bPoss select _newPos;
            waitUntil {sleep 4;unitReady _unit  || _unit distance _newPos < 2};
            _unit doMove _newPos;
            _timer = time;
            waitUntil {sleep 4;unitReady _unit || _unit distance _newPos < 2 || !alive _unit  ||  time > _timer + 150};
            if (_unit getVariable ["civ_insurgent",false] || !alive _unit)then{breakTo "main";};

            sleep (13 + random 5);
            _i2 = _i2 + 1;
        }else{
            /**********GO OUT*************/
            if (_rd==1) then{
                _dir = random 360;
                _curPos = getPos _unit;
                _newPos = [_curPos ,_range,_range + 30, 1, 0, 20, 0] call BIS_fnc_findSafePos;
                _unit doMove _newPos;
                _timer = time;

                waitUntil {sleep 4; unitReady _unit || !alive _unit || _unit distance _newPos < 2  || time > _timer + 150};

                if (_unit getVariable ["civ_insurgent",false] || !alive _unit)then{breakTo "main";};

                //Sit or not
                if (round(random 1)==1)then{
                    _unit action ["sitdown",_unit];
                    sleep 40 + random 25;
                    _unit action ["sitdown",_unit];
                    
                }else{
                    sleep 20 + random 25;
                };
               
                //Play a suspect animation
                if (_unit getVariable["DCW_Suspect",false] && !stopped _unit)then{
                    _unit stop true;
                    [_unit, "medic"] remoteExec ["playActionNow"];
                    sleep 4;
                    _unit stop false;
                    _unit setUnitPos "AUTO";
                    _unit playAction "PlayerStand";
                };

            }else{
                [_unit,_meetPoint] call DCW_fnc_gotomeeting;
                if (_unit getVariable ["civ_insurgent",false] || !alive _unit)then{breakTo "main";};
                sleep 20;
            };

            if (_unit getVariable ["civ_insurgent",false] || !alive _unit)then{breakTo "main";};
        };
    };
    
    _unit = leader _grp;
};

// Go out if you detected enemy;
if (random 100 > 50) then {
     _newPos = [getPos _unit ,0, 40, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _unit move  _newPos;
};

_unit forceWalk false;
_unit setBehaviour "AWARE";
_unit setSpeedMode "NORMAL";