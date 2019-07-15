/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Make the enemy soldier surrender

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

params["_unit","_gunner"];

_unit removeAllEventHandlers "FiredNear";
_unit setCaptive true;
_unit action ["Surrender", _unit]; 
removeHeadgear _unit;
_weapon = currentWeapon _unit;     
_unit removeWeapon (currentWeapon _unit);
sleep .2;
_weaponHolder = "WeaponHolderSimulated" createVehicle [0,0,0];
_weaponHolder addWeaponCargoGlobal [_weapon,1];
_weaponHolder setPos (_unit modelToWorld [0,.2,1.2]);
_weaponHolder disableCollisionWith _unit;
_dir = random(360);
_speed = 1.5;
_weaponHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir),4];  

_unit call DCW_fnc_addActionLiberate;
_unit call DCW_fnc_addActionLookInventory;
_unit call DCW_fnc_addActionGetIntel;
[_unit] call DCW_fnc_shout;

if (!isNull _gunner) then {
  [_gunner, ["This enemy is surrendering","He gives up !","Hands up !", "Your hands in the hair !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
};