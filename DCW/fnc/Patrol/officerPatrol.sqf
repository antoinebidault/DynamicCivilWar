/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Inspired by SPUn / LostVar
 */
private["_marker"];
_truck = _this select 0;
_unit = _this select 1;
_driver = driver _truck;
_grp = group _unit;

if (DEBUG) then {
    _marker = createMarker [format["officer-patrol-%1",random 13100], getPos _unit];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [6,6];
    _marker setMarkerColor "ColorBlack";
    _marker setMarkerBrush "SolidBorder";
};

while {sleep 5;  alive _unit}do{
    _curPos = getPos _truck;
    
    /*_pos = [_curPos, _radius/2, _radius, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    _newPos = getPos([_pos,_radius,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad);
    _truck move _newPos;*/
    
    sleep 2;

    /*_timer = time;
    waitUntil {sleep 5;  !alive(_unit)  || _driver distance2D _newPos < 5 || time > _timer + 150};
    if (!alive _unit) exitWith{false}; 
    sleep 5 + random 25;*/

    _curPos =  getPosASL _driver;
    _compound = [_curPos, true, "neutral"] call fnc_findNearestMarker;

    _newPos = getMarkerPos(_compound select 0);

    _road = ([_newPos,1000,MARKER_WHITE_LIST] call BIS_fnc_nearestRoad);
    if (isNull _road) exitWith { };
    
    _newPos = getPosASL _road; 
    
    if (DEBUG) then {
    _marker setMArkerPos _newPos;
    };
    //_driver move _newPos;

    sleep 2; 
    (group _driver) move _newPos;

    /*
    _convoyWP = _grp addWaypoint [_newPos, 0];
    _convoyWP  setWaypointType "MOVE";
    _convoyWP  setWaypointSpeed "NORMAL";
    _convoyWP  setWaypointBehaviour "SAFE";
    _convoyWP  setWaypointCompletionRadius 1;
    _convoyWP  setWaypointFormation "COLUMN";
*/
    _timer = time;
    waitUntil { sleep 5; !alive(_unit)  || _truck distance2D _newPos < 14 || time > _timer + 800 };
    if (!alive _unit) exitWith{false};

    private _nH= _compound select 11;		
    if (count _nH == 0)exitWith{};
    private _H= selectRandom _nH;
    private _HP=_H buildingPos -1;

    //If available positions
    if (count _HP == 0)exitWith{};

    _newPos= selectRandom _HP;
    if (DEBUG) then {
        _marker setMArkerPos _newPos;
    };
    
    sleep 10;

    (_grp) leaveVehicle _truck;
    { unassignVehicle _x } forEach units _grp;

    sleep 5;

    _unit move _newPos;
    _unit setBehaviour "SAFE";
    _unit setSpeedMode "LIMITED";

    sleep 2;
    
    waitUntil {sleep 5; !alive(_unit) || unitReady _unit  || _unit distance2D _newPos < 15 || time > _timer + 250};
    if (!alive _unit) exitWith{false};

    if ((_compound select 13) > 70) then {
        [_compound,"massacred"] call fnc_setCompoundState;
        [_compound,15,100] spawn fnc_setCompoundSupport;
    } else {
        [_compound,"bastion"] call fnc_setCompoundState;
        [_compound,-30,100] spawn fnc_setCompoundSupport;
    };

    _newPos = (_truck modelToWorld [0,5,0]);
    if (DEBUG) then {
        _marker setMarkerPos _newPos;
    };
 //   sleep 60;
    _unit move _newPos;
    
    if (!isNil '_truck' && alive _truck)then {
        
        {
            _x assignAsCargo _truck;
        } foreach units _grp;
        sleep 1;
       // (units _grp) allowGetIn true;
        (units _grp) orderGetIn true;
    };

    waitUntil {sleep 5;{ vehicle _x != _x } count (units _grp) == count (units _grp)};

};

