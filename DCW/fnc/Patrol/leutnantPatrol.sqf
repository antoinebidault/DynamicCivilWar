/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Inspired by SPUn / LostVar
private ["_truck","_driver","_unit","_radius","_newPos","_bPoss","_curPos","_pos"];

_truck = _this select 0;
_unit = _this select 1;
_radius = _this select 2;

while {sleep 5;  alive _unit}do{
    _driver = driver _truck;
    _driver setSpeedMode "NORMAL";
    _curPos = getPos _truck;
    _pos = [_curPos, _radius/2, _radius, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
    _newPos = getPos([_pos,_radius] call BIS_fnc_nearestRoad);
    _truck move _newPos;
    sleep 2;

    private _marker = createMarker [format["sold%1",random 13100], _newPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorWhite";
    _marker setMarkerBrush "SolidBorder";


    _timer = time;
    waitUntil {sleep 5;  !alive(_unit)  || _driver distance2D _newPos < 5 || time > _timer + 150};
    if (!alive _unit) exitWith{false}; 
    sleep 5 + random 25;

    _curPos =  getPos _driver;
    _newPos = getMarkerPos(([_curPos] call fnc_findNearestMarker) select 0);
    _newPos = getPos([_newPos,1000] call BIS_fnc_nearestRoad);

    private _marker = createMarker [format["sold%1",random 13100], _newPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorWhite";
    _marker setMarkerBrush "SolidBorder";

    _driver move _newPos;
    sleep 2; 

    _timer = time;
    waitUntil {sleep 5; !alive(_unit)  || _driver distance2D _newPos < 5 || time > _timer + 150};
    if (!alive _unit) exitWith{false};

    private _nH= [_newPos,150] call fnc_findBuildings;		

   
    if (count _nH == 0)exitWith{};
    private _H= selectRandom _nH;
    private _HP=_H buildingPos -1;

    //If available positions
    if (count _HP == 0)exitWith{};

    _newPos= selectRandom _HP;
    private _marker = createMarker [format["sold%1",random 13100], _newPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorWhite";
    _marker setMarkerBrush "SolidBorder";
    

    sleep 10;
    (group _unit) leaveVehicle _truck;
    sleep 5;

    _unit move _newPos;
    _unit setBehaviour "SAFE";
    _unit setSpeedMode "LIMITED";

    sleep 2;
    
    waitUntil {sleep 5; !alive(_unit) || _unit distance2D _newPos < 5 || time > _timer + 250};
    if (!alive _unit) exitWith{false};

    sleep 60;

    if (!isNil '_truck')then {

        //Available Turrets
        private _nbTurrets = (count(allTurrets [_truck, true])-1);

        {
            if (_nbTurrets > 0) then{
                _x assignAsCargo _truck;
                _nbTurrets = _nbTurrets - 1;
            }else{
                _x assignAsCargo _truck;
            };
        } foreach ((units (group _unit)) select {vehicle _x == _x});
        sleep 1;
        (units (group _unit)) allowGetIn true;
        (units (group _unit)) orderGetIn true;
    };
    waitUntil {sleep 5;{ vehicle _x == _truck } count (units (group _unit)) == count (units (group _unit))};

};

