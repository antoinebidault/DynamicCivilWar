//shoot.sqf
_unit = (_this select 0);
_target = (_this select 1);

_unit dotarget _target;
_unit setAmmo [currentWeapon _unit, 1];
sleep 2;
while {alive _unit} do {
sleep (14 + random 16);
_unit setAmmo [currentWeapon _unit, 5];
_unit forceWeaponFire [ weaponState _unit select 1, weaponState _unit select 2];
};