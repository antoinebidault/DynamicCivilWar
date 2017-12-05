/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private _mortar = _this select 0;
private _targetedUnit = _this select 1;
private _pos = _this select 2;
private _distance = _this select 3;

private _dir = round([_targetedUnit,_mortar] call BIS_fnc_dirTo);

deleteMarker "DCW_mortar";
_marker = createMarker ["DCW_mortar",_pos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Mortar !";
_marker setMarkerType "hd_arrow";
_marker setMarkerDir _dir;
_refUnit = "Land_HelipadEmpty_F" createVehicle _pos;
_refUnit setDir 0;
_marker setMarkerPos (_refUnit getRelPos [_distance/2, _dir]);
deleteVehicle _refUnit;

if ({alive _x} count crew(_mortar) == count crew(_mortar))  then{
    [_targetedUnit,format["Mortar incoming ! Bearing %1",_dir]] spawn fnc_talk;
    while{alive _mortar && alive _targetedUnit }do{
        _shootingPos = [getPos _targetedUnit, 17, 160, 0, 0, 20, 0] call BIS_fnc_findSafePos;
        _mortar doArtilleryFire [_shootingPos, "8Rnd_82mm_Mo_shells", 1];
        if (getPos player distance _pos > (_radius + 80)) exitWith{false};
        sleep 8;
    };
};

true;