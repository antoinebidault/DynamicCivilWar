/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//Inspired by SPUn / LostVar
private ["_unit","_radius","_newPos","_bPoss","_curPos","_pos"];

_unit = _this select 0;
_radius = _this select 1;

while {sleep 5;  alive _unit}do{

    _curPos = getPosASL _unit;
    _pos = [_curPos, _radius/2, _radius, 2, 0, 20, 0] call BIS_fnc_FindSafePos;
    _newPos = getPosASL([_pos,_radius] call BIS_fnc_nearestRoad);
    _unit move _newPos;
    sleep 2;

    private _marker = createMarker [format["sold%1",random 13100], _newPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorWhite";
    _marker setMarkerBrush "SolidBorder";


    _timer = time;
    waitUntil {sleep 5; !alive(_unit) || unitReady  _unit || (vehicle _unit) distance _newPos < 4 || time > _timer + 900};
    if (!alive _unit) exitWith{false}; 
    sleep 5 + random 25;

    _curPos =  getPosASL _unit;
    _newPos = getMarkerPos (([_curPos] call fnc_findNearestMarker) select 0);
    _newPos = getPosASL([_newPos,1000] call BIS_fnc_nearestRoad);

    private _marker = createMarker [format["sold%1",random 13100], _newPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorWhite";
    _marker setMarkerBrush "SolidBorder";

    _unit move _newPos;
    sleep 2; 

    _timer = time;

    waitUntil {sleep 5; !alive(_unit) || unitReady _unit || (vehicle _unit) distance _newPos < 10 || time > _timer + 900};
    if (!alive _unit) exitWith{false};

    private _nH=nearestObjects [_unit, ["house"], 340];		
    private _H=selectRandom _nH;
    private _HP=_H buildingPos -1;
    _newPos= selectRandom _HP;

    private _marker = createMarker [format["sold%1",random 13100], _newPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorWhite";
    _marker setMarkerBrush "SolidBorder";

    if (vehicle _unit !=  _unit)then {
        private _vehicle = (vehicle _unit);
        sleep 10;
        { unassignvehicle _x; _x action ["EJECT", _vehicle]; sleep 1; } foreach assignedCargo (vehicle _unit);
        sleep 5;
    };

    _unit move _newPos;
    sleep 2;
    
    waitUntil {sleep 5; !alive(_unit) || unitReady _unit|| (vehicle _unit) distance _newPos < 3 || time > _timer + 900};
    if (!alive _unit) exitWith{false};
    sleep 60;
    if (!isNil '_vehicle')then {
        { _x assignAsCargo _vehicle; } foreach ((units (group _unit)) select {vehicle _x == _x});
        (units (group _unit)) orderGetIn true;
    };
    sleep 100;
};

