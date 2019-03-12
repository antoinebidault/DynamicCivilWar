/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

/*
Target shooting with a random timer
Bidass
*/

_unit = (_this select 0);
_target = (_this select 1);

_unit dotarget _target;
sleep 2;

while {alive _unit} do {
    _unit setAmmo [currentWeapon _unit, 5];
    _unit forceWeaponFire [weaponState _unit select 1, weaponState _unit select 2];
    sleep (14 + random 16);
};