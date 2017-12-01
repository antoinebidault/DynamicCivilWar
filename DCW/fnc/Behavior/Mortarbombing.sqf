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

if ({alive _x} count crew(_mortar) == count crew(_mortar))  then{
    [_targetedUnit,format["Mortar incoming ! Bearing %1",_dir]] spawn fnc_talk;
    while{alive _mortar && alive _targetedUnit }do{
        _shootingPos = [getPosASL _targetedUnit, 17, 160, 0, 0, 20, 0] call BIS_fnc_findSafePos;
        _mortar doArtilleryFire [_shootingPos, "8Rnd_82mm_Mo_shells", 1];
        if (getPosASL player distance _pos > (_radius + 80)) exitWith{false};
        sleep 8;
    };
};

true;