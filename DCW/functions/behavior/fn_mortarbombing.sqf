/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Triggered when a mortar spawn. The mortar will attack the unit passed in param.
    To prevent game breaking, the mortar round impact is calculated to be not too close from the unit.

  Parameters:
    0: OBJECT - mortar
    1: OBJECT - targeted unit
    2: ARRAY - unit position [X,Y,Z]
    3: RADUIS - Maximum of distance where the round will fall

  Returns:
    BOOL - true 
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
    [_targetedUnit,format[localize "STR_DCW_mortarBombing_incoming",_dir], true] remoteExec ["DCW_fnc_talk"];
    while{alive _mortar && alive _targetedUnit }do{
        _shootingPos = [getPos _targetedUnit, 25, 260, 0, 0, 20, 0] call BIS_fnc_findSafePos;
        _mortar doArtilleryFire [_shootingPos, _mag, 1];
        if (getPos _targetedUnit distance _pos > (_radius + 150)) exitWith{false};
        sleep 8;
    };
};

true;