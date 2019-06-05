/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _mortar = _this select 0;
private _targetedUnit = _this select 1;
private _pos = _this select 2;
private _radius = _this select 3;

private _dir = round([_pos,getPos _mortar] call BIS_fnc_dirTo);
//private _dirOpposite = round([_mortar,_targetedUnit] call BIS_fnc_dirTo);

deleteMarker "DCW_mortar";
_marker = createMarker ["DCW_mortar",_pos];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Mortar !";
_marker setMarkerType "hd_arrow";
_marker setMarkerDir _dir;
_refUnit = "Land_HelipadEmpty_F" createVehicle _pos;
_refUnit setDir 0;
_marker setMarkerPos (_refUnit getRelPos [_radius+50,_dir]);
deleteVehicle _refUnit;

private _mag = (magazines _mortar) select 0;  // def = 8Rnd_82mm_Mo_shells

if ({alive _x} count crew(_mortar) == count crew(_mortar))  then{
    [_targetedUnit,format["Mortar incoming ! Bearing %1",_dir], true] remoteExec ["fnc_talk"];
    while{alive _mortar && alive _targetedUnit }do{
        _shootingPos = [getPos _targetedUnit, 25, 260, 0, 0, 20, 0] call BIS_fnc_FindSafePos;
        _mortar doArtilleryFire [_shootingPos, _mag, 1];
        if (getPos _targetedUnit distance _pos > (_radius + 150)) exitWith{false};
        sleep 8;
    };
};

true;