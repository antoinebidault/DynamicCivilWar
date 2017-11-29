/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


private ["_leader","_marker","_lastKnownPosition","_flrObj"];
_leader = _this;

_marker = createMarker [format["sold%1",random 13100], position player];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [6,6];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "SolidBorder";

while { alive _leader && alive player }do{
    if (_leader knowsAbout player >= .5) then {
        if (time > LAST_FLARE_TIME + 120)then{
            _flrObj = "F_40mm_white" createvehicle ((player) modelToWorld [50-round(random 25),50-round(random 25),200]); 
            _flrObj setVelocity [0,0,-10];
            LAST_FLARE_TIME = time;
        };
        _lastKnownPosition = _leader getHideFrom player;
    }else{
        //Si déclenchement de la recherche
        if (CHASER_TRIGGERED)then{
            _lastKnownPosition = [position player , 50, 300, 1, 0, 20, 0] call BIS_fnc_findSafePos;
        }else{
            _lastKnownPosition = [position _leader , 30, 100, 1, 0, 20, 0] call BIS_fnc_findSafePos;
        };
    };
    _marker setMarkerPos _lastKnownPosition;

    group _leader move _lastKnownPosition;
    
    sleep 20;
};

